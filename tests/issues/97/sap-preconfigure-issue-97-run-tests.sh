#!/bin/bash
MANAGED_NODE=$1
if [[ ${MANAGED_NODE}. = "." ]]; then
   echo "Enter the name of the managed node: "
   read MANAGED_NODE
fi
_RHEL_RELEASE_MAJOR=$(ssh ${MANAGED_NODE} cat /etc/redhat-release | awk 'BEGIN{FS="release "}{split ($2, a, " "); split (a[1], b, "."); print b[1]}')

if [[ ${_RHEL_RELEASE_MAJOR} -ne 7 ]]; then
   echo "This test is only valid for RHEL 7 managed nodes. Exiting."
   echo
   exit 1
fi

echo
printf "Managed node Red Hat release: "
ssh ${MANAGED_NODE} cat /etc/redhat-release
printf "Managed node HW architecture: "
ssh ${MANAGED_NODE} uname -m
echo

# Test 1: no entry for vm.max_map_count in /etc/sysctl.d/sap.conf
echo "Test 1: No entry for vm.max_map_count in /etc/sysctl.d/sap.conf"
ansible-playbook sap-preconfigure-issue-97-prepare-test-1.yml -l ${MANAGED_NODE}
echo
echo "Status before running the test:"
ssh ${MANAGED_NODE} "awk '/vm.max_map_count/&&/[a-z@]/{a++; print}END{printf (\"%d vm.max_map_count entries\n\", a)}' /etc/sysctl.d/sap.conf"
echo
echo "Test 1: Run role:"
ansible-playbook sap-preconfigure-issue-97-test.yml --tags=role::sap-preconfigure:config -l ${MANAGED_NODE}
echo
echo "Status after running the test:"
ssh ${MANAGED_NODE} "awk '/vm.max_map_count/&&/[a-z@]/{a++; print}END{printf (\"%d entries\n\", a)}' /etc/sysctl.d/sap.conf"
echo
echo "Test 1: Assertion:"
ansible-playbook sap-preconfigure-issue-97-assert.yml -l ${MANAGED_NODE}

echo
echo "---"
echo
# Test 2: wrong entry for vm.max_map_count in /etc/sysctl.d/sap.conf
echo "Test 2: Add wrong entries for vm.max_map_count in /etc/sysctl.d/sap.conf"
ansible-playbook sap-preconfigure-issue-97-prepare-test-2.yml -l ${MANAGED_NODE}
echo
echo "Status before running the test:"
ssh ${MANAGED_NODE} "awk '/vm.max_map_count/&&/[a-z@]/{a++; print}END{printf (\"%d vm.max_map_count entries\n\", a)}' /etc/sysctl.d/sap.conf"
echo
echo "Test 2: Run role:"
ansible-playbook sap-preconfigure-issue-97-test.yml --tags=role::sap-preconfigure:config -l ${MANAGED_NODE}
echo
echo "Status after running the test:"
ssh ${MANAGED_NODE} "awk '/vm.max_map_count/&&/[a-z@]/{a++; print}END{printf (\"%d entries\n\", a)}' /etc/sysctl.d/sap.conf"
echo
echo "Test 2: Assertion:"
ansible-playbook sap-preconfigure-issue-97-assert.yml -l ${MANAGED_NODE}
