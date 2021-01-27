#!/bin/bash
MANAGED_NODE=$1
if [[ ${MANAGED_NODE}. = "." ]]; then
   echo "Enter the name of the managed node (RHEL 7 only): "
   read MANAGED_NODE
fi

echo
printf "Managed node Red Hat release: "
ssh ${MANAGED_NODE} cat /etc/redhat-release
printf "Managed node HW architecture: "
ssh ${MANAGED_NODE} uname -m
echo
_RHEL_RELEASE_MAJOR=$(ssh ${MANAGED_NODE} cat /etc/redhat-release | awk 'BEGIN{FS="release "}{split ($2, a, " "); split (a[1], b, "."); print b[1]}')

if [[ ${_RHEL_RELEASE_MAJOR} -ne 7 ]]; then
   echo "This test is only valid for RHEL 7 managed nodes. Exiting."
   echo
   exit 1
fi

# Test 1: Just run the role
echo "Test 1: Run role:"
ansible-playbook sap-preconfigure-issue-99-test.yml -l ${MANAGED_NODE}
echo
echo "Test 1: Assertion:"
ansible-playbook sap-preconfigure-issue-99-assert.yml -l ${MANAGED_NODE} -e "@sap-preconfigure-issue-99-assert-vars.yml"

