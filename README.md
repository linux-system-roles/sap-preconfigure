sap-preconfigure
================

This role configures a RHEL 8 system according to applicable SAP notes so that any SAP software can be installed.

Requirements
------------

To use this role, your system needs to be installed according to SAP note 2772999, section "Installing Red Hat Enterprise Linux 8". Most important here: Choose the "Server" Base Environment (=environment group) in the installer, without any add-ons.

Role Variables
--------------

vars/main.yml:
sap_preconfigure_packages: contains the additional packages which are not contained in the "Server" environment group and which are needed for any SAP software
sap_preconfigure_size_of_tmpfs_gb: Formula for setting the size of TMPFS
sap_preconfigure_locale: Locale to be checked.
sap_preconfigure_db_group_name: Name of the RHEL group which is used for the database processes.

Dependencies
------------

This role does not depend on any other role.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      roles:
         - role: sap-preconfigure

License
-------

BSD

Author Information
------------------

Bernd Finger
