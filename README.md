sap-preconfigure
================

This role configures a RHEL 7 or RHEL 8 system according to applicable SAP notes so that any SAP software can be installed.

Requirements
------------

To use this role, your system needs to be installed according to:
- RHEL 7: SAP note 2002167, Red Hat Enterprise Linux 7.x: Installation and Upgrade, section "Installing Red Hat Enterprise Linux 7"
- RHEL 8: SAP note 2772999, Red Hat Enterprise Linux 8.x: Installation and Configuration, section "Installing Red Hat Enterprise Linux 8".

Role Variables
--------------

- set in vars/RedHat_7.yml and vars/RedHat_8.yml:

sap_preconfigure_sapnotes: List of applicable SAP notes. Used to include yml files from directory tasks/sapnote/<SAP Note number>.
sap_preconfigure_packagegroups_x86_64: Package group (environment group) to check or install (x86_64)
sap_preconfigure_packagegroups_ppc64le: Package group (environment group) to check or install (ppc64le)
sap_preconfigure_packagegroups: Automatically set from one of the two variables above
sap_preconfigure_packages: Contains the additional packages which are not contained in sap_preconfigure_packagegroups and which are
   needed for SAP software installation.
sap_preconfigure_size_of_tmpfs_gb: Formula for setting the size of TMPFS. See also SAP note 941735.
sap_preconfigure_locale: Locale to be checked. This is currently not implemented.
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

GNU General Public License v3.0

Author Information
------------------

Bernd Finger
