sap-preconfigure
================

This role configures a RHEL 7 or RHEL 8 system according to applicable SAP notes so that any SAP software can be installed. Future implementation may reduce the scope of this role, for example if certain installation or configuration steps are done in more specialized roles.

Requirements
------------

To use this role, your system needs to be installed according to:
- RHEL 7: SAP note 2002167, Red Hat Enterprise Linux 7.x: Installation and Upgrade, section "Installing Red Hat Enterprise Linux 7"
- RHEL 8: SAP note 2772999, Red Hat Enterprise Linux 8.x: Installation and Configuration, section "Installing Red Hat Enterprise Linux 8".

Role Variables
--------------

- set in vars/RedHat_7.yml and vars/RedHat_8.yml:

### SAP notes to apply
The following variable contains a list of all SAP notes which are used for this role. This is used to include yml files
from directories tasks/sapnote/<SAP Note number>.
```yaml
sap_preconfigure_sapnotes
```

### Required package groups
The following variables define the required package groups. Note that variable sap_preconfigure_packagegroups is automatically filled from either sap_preconfigure_packagegroups_x86_64 or sap_preconfigure_packagegroups_ppc64le:
```yaml
sap_preconfigure_packagegroups_x86_64
sap_preconfigure_packagegroups_ppc64le
sap_preconfigure_packagegroups_s390x
sap_preconfigure_packagegroups
```

### Required packages
The following variable defines the required additional packages:
```yaml
sap_preconfigure_packages
```

### size of TMPFS in GB:
The following variable contains a formula for setting the size of TMPFS according to SAP note 941735.
```yaml
sap_preconfigure_size_of_tmpfs_gb
```

### Locale
The following variable contains the locale to be check. This check is currently not implemented.
```yaml
sap_preconfigure_locale
```

### Modify /etc/hosts
If you want the role to modify /etc/hosts, set the following variable to yes.
If set to no, the role will only check if /etc/hosts is set according to SAP's requirements. Default is no.
```yaml
sap_preconfigure_modify_etc_hosts
```

### Linux group name of the database user
The following variable contains the name of the group which is used for the database(s), e.g. dba.
```yaml
sap_preconfigure_db_group_name
```

Dependencies
------------

This role does not depend on any other role.

Example Playbook
----------------

```yaml
---
    - hosts: all
      roles:
         - role: sap-preconfigure
         - role: sap-hana-preconfigure
```

Example Usage
-------------
ansible-playbook -l remote_host site.yml

License
-------

GNU General Public License v3.0

Author Information
------------------

Bernd Finger
