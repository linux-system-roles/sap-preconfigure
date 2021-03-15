#!/usr/bin/python3

import os, sys, subprocess
#import yaml

if (len(sys.argv) == 1):
   _managed_node=input("Provide name of managed node: ")
else:
   _managed_node=sys.argv[1]

print('Managed node: ' + _managed_node)

_mn_rhel_release = subprocess.getoutput("ssh root@" + _managed_node + " cat /etc/redhat-release")
print('Managed node Red Hat release: ' + _mn_rhel_release)
_mn_hw_arch = subprocess.getoutput("ssh root@" + _managed_node + " uname -m")
print('Managed node HW architecture: ' + _mn_hw_arch)

__tests = [
   {
      'number': '1',
      'name': 'Run in check mode on new system',
      'command_line_parameter': '--check ',
      'ignore_error_final': True,
      'compact_assert_output': False,
      'role_vars': []
   },
   {
      'number': '2',
      'name': 'Run in assert mode on new system. Continue with the next test in case of any error',
      'command_line_parameter': '',
      'ignore_error_final': True,
      'compact_assert_output': False,
      'role_vars': [
         {
            'sap__preconfigure_assert': True
         }
      ]
   },
   {
      'number': '3',
      'name': 'Run in assert mode on new system, check for possible RHEL update, ignore any error',
      'command_line_parameter': '',
      'ignore_error_final': False,
      'compact_assert_output': False,
      'role_vars': [
         {
            'sap_preconfigure_assert': True,
            'sap_preconfigure_assert_ignore_errors': True,
            'sap_preconfigure_update': True
         }
      ]
   },
   {
      'number': '4',
      'name': 'Run in assert mode on new system, check for possible RHEL update, ignore any error, compact output',
      'command_line_parameter': '',
      'ignore_error_final': False,
      'compact_assert_output': True,
      'role_vars': [
         {
            'sap_preconfigure_assert': True,
            'sap_preconfigure_assert_ignore_errors': True,
            'sap_preconfigure_update': True
         }
      ]
   },
   {
      'number': '5',
      'name': 'Run in normal mode on new system, no reboot',
      'command_line_parameter': '',
      'ignore_error_final': False,
      'compact_assert_output': False,
      'role_vars': [
         {
            'sap_preconfigure_fail_if_reboot_required': False
         }
      ]
   },
   {
      'number': '6',
      'name': 'Run in check mode on configured system',
      'command_line_parameter': '--check ',
      'ignore_error_final': False,
      'compact_assert_output': False,
      'role_vars': []
   },
   {
      'number': '7',
      'name': 'Run in assert mode on modified system. Continue with the next test in case of any error',
      'command_line_parameter': '',
      'ignore_error_final': True,
      'compact_assert_output': False,
      'role_vars': [
         {
            'sap_preconfigure_assert': True
         }
      ]
   },
   {
      'number': '8',
      'name': 'Run in assert mode on modified system, check for possible RHEL update, ignore any error, compact output',
      'command_line_parameter': '',
      'ignore_error_final': False,
      'compact_assert_output': True,
      'role_vars': [
         {
            'sap_preconfigure_assert': True,
            'sap_preconfigure_assert_ignore_errors': True,
            'sap_preconfigure_update': True
         }
      ]
   },
   {
      'number': '9',
      'name': 'Run in normal mode. Update to the latest packages. Allow a reboot.',
      'command_line_parameter': '',
      'ignore_error_final': False,
      'compact_assert_output': False,
      'role_vars': [
         {
            'sap_preconfigure_update': True,
            'sap_preconfigure_reboot_ok': True
         }
      ]
   },
   {
      'number': '10',
      'name': 'Run in assert mode on modified system. Continue with the next test in case of any error',
      'command_line_parameter': '',
      'ignore_error_final': True,
      'compact_assert_output': False,
      'role_vars': [
         {
            'sap_preconfigure_assert': True
         }
      ]
   },
   {
      'number': '11',
      'name': 'Run in assert mode on modified system, check for possible RHEL update, ignore any error, compact output',
      'command_line_parameter': '',
      'ignore_error_final': False,
      'compact_assert_output': True,
      'role_vars': [
         {
            'sap_preconfigure_assert': True,
            'sap_preconfigure_assert_ignore_errors': True,
            'sap_preconfigure_update': True
         }
      ]
   }
]

for par1 in __tests:
   print ('\n' + 'Test ' + par1['number'] + ': ' + par1['name'])
   command = 'ansible-playbook default-settings.yml '
   command += par1['command_line_parameter']
   command += '-l ' + _managed_node + ' '
   command += '-e "'
   for par2 in par1['role_vars']:
      command += str(par2)
   command += '"'
   if (par1['compact_assert_output'] == True):
      command += ' | ./beautify-assert-output.sh'
   print ("command: " + command)
   rc = os.system(command)
   if (rc != 0):
      if (par1['ignore_error_final'] == True):
         print('Test ' + par1['number'] + ' finished with return code ' + str(rc) + '. Continuing with the next test')
      else:
         print('Test ' + par1['number'] + ' finished with return code ' + str(rc) + '.')
         exit(rc)
   else:
      print('Test ' + par1['number'] + ' finished with return code 0.')
