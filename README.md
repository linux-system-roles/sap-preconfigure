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

- set in defaults/main.yml:

### Minimum package check:
The following variable will check miminum package versions. Default is no.
```yaml
sap_preconfigure_min_package_check
```

### Only perform an installation check
If the following variable is set to yes, the role only run an installation check. Default is no.
```yaml
sap_preconfigure_installation_check_only
```

### Perform a yum update
If the following variable is set to yes, the role will run a yum update before performing configuration changes. Default is no.
```yaml
sap_preconfigure_update
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
If you not want the role to check and if necessary modify /etc/hosts according to SAP's requirements, set the following variable to no. Default is yes.
```yaml
sap_preconfigure_modify_etc_hosts
```

### hostname
If the role should not use the hostname as reported by Ansible (=ansible_hostname), set the following variable according to your needs:
```yaml
sap_hostname
```

### DNS domain name
If the role should not use the DNS domain name as reported by Ansible (=ansible_domain), set the following variable according to your needs:
```yaml
sap_domain
```

### IP address
If the role should not use the primary IP address as reported by Ansible (=ansible_default_ipv4.address), set the following variable according to your needs:
```yaml
sap_ip
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
