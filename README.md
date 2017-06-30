# iscsi

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What iscsi affects](#what-iscsi-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with iscsi](#beginning-with-iscsi)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

A one-maybe-two sentence summary of what the module does/what problem it solves.
This is your 30 second elevator pitch for your module. Consider including
OS/Puppet version it works with.

## Module Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What iscsi affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements

This module requires pluginsync enabled

### Beginning with iscsi

```yaml
interfaceiscsi:
  'ens1f0': {}
  'ens2f0': {}
iscsidiscovery:
  'any':
    portals:
      - '10.12.100.1'
      - '10.12.100.2'
      - '10.12.100.7'
      - '10.12.100.8'
sessions_iscsi:
  'netapp12-ens1f0':
    target: 'iqn.1992-08.com.netapp:sn.53231fdeadd211e7a31600a098a3f0a4:vs.34'
    iface: 'ens1f0'
    portals:
      - '10.155.100.1'
      - '10.155.100.2'
  'netapp12-ens2f0':
    target: 'iqn.1992-08.com.netapp:sn.53231fdeadd211e7a31600a098a3f0a4:vs.34'
    iface: 'ens2f0'
    portals:
      - '10.12.100.1'
      - '10.12.100.2'
  'netapp78-ens1f0':
    target: 'iqn.1992-08.com.netapp:sn.64b04deadbeef1e78e5f00a098a3f4ec:vs.14'
    iface: 'ens1f0'
    portals:
      - '10.12.100.7'
      - '10.12.100.8'
  'netapp78-ens2f0':
    target: 'iqn.1992-08.com.netapp:sn.64b04deadbeef1e78e5f00a098a3f4ec:vs.14'
    iface: 'ens2f0'
    portals:
      - '10.12.100.7'
      - '10.12.100.8'
lun_alias:
  'OracleRAC_backup':
    wwid: '3600a0990886047282d244a4d55337852'
  'OracleRAC_DB_Disk1':
    wwid: '3600a0990886047282d244a4d55337855'
  'OracleRAC_DB_Disk2':
    wwid: '3600a0990886047282d244a4d55337856'
  'OracleRAC_DB_Disk3':
    wwid: '3600a0990886047282d244a4d55337857'
  'OracleRAC_DB_Disk4':
    wwid: '3600a0990886047282d244a4d55337858'
  'OracleRAC_FRA_Disk1':
    wwid: '3600a0990886047282d244a4d55337859'
  'OracleRAC_OCR_Disk1':
    wwid: '3600a0990886047282d244a4d5533785a'
  'OracleRAC_FRA_Disk2':
    wwid: '3600a09908860472845244a4e366f6679'
  'OracleRAC_FRA_Disk3':
    wwid: '3600a09908860472845244a4e366f667a'
```

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

TODO list

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
