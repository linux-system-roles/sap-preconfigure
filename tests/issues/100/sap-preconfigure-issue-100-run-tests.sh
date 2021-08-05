#!/bin/bash
MANAGED_NODE=$1
if [[ ${MANAGED_NODE}. = "." ]]; then
   echo "Enter the name of the managed node: "
   read MANAGED_NODE
fi

echo
printf "Managed node Red Hat release: "
ssh ${MANAGED_NODE} cat /etc/redhat-release
printf "Managed node HW architecture: "
ssh ${MANAGED_NODE} uname -m
echo

# Test 1: no entry for nofile in /etc/security/limits.d/99-sap.conf
echo "Test 1: No entry for nofile in /etc/security/limits.d/99-sap.conf"
ansible-playbook sap-preconfigure-issue-100-prepare-test-1.yml -l ${MANAGED_NODE}
echo
echo "Status before running the test:"
ssh ${MANAGED_NODE} "awk '/nofile/&&/[a-z@]/{a++; print}END{printf (\"%d nofile entries\n\", a)}' /etc/security/limits.d/99-sap.conf"
echo
echo "Test 1: Run role:"
ansible-playbook sap-preconfigure-issue-100-test.yml -l ${MANAGED_NODE}
echo
echo "Status after running the test:"
ssh ${MANAGED_NODE} "awk '/nofile/&&/[a-z@]/{a++; print}END{printf (\"%d entries\n\", a)}' /etc/security/limits.d/99-sap.conf"
echo
echo "Test 1: Assertion:"
ansible-playbook sap-preconfigure-issue-100-assert.yml -l ${MANAGED_NODE}

echo
echo "---"
echo
# Test 2: wrong entry for nofile in /etc/security/limits.d/99-sap.conf
echo "Test 2: Add wrong entries for nofile in /etc/security/limits.d/99-sap.conf"
ansible-playbook sap-preconfigure-issue-100-prepare-test-2.yml -l ${MANAGED_NODE}
echo
echo "Status before running the test:"
ssh ${MANAGED_NODE} "awk '/nofile/&&/[a-z@]/{a++; print}END{printf (\"%d nofile entries\n\", a)}' /etc/security/limits.d/99-sap.conf"
echo
echo "Test 2: Run role:"
ansible-playbook sap-preconfigure-issue-100-test.yml -l ${MANAGED_NODE}
echo
echo "Status after running the test:"
ssh ${MANAGED_NODE} "awk '/nofile/&&/[a-z@]/{a++; print}END{printf (\"%d entries\n\", a)}' /etc/security/limits.d/99-sap.conf"
echo
echo "Test 2: Assertion:"
ansible-playbook sap-preconfigure-issue-100-assert.yml -l ${MANAGED_NODE}
