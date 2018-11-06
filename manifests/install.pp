class iscsi::install inherits iscsi {

  if($iscsi::multipath)
  {
    include ::multipathd
  }

  if($iscsi::manage_package)
  {
    package { $iscsi::params::package_name:
      ensure => $iscsi::package_ensure,
    }
  }

  # potser a iscsi::interface?
  # net.ipv4.conf.all.arp_ignore = 1
  sysctl::set { 'net.ipv4.conf.all.arp_ignore':
    value => '1',
    order => '99',
  }
  # net.ipv4.conf.all.arp_announce = 2
  sysctl::set { 'net.ipv4.conf.all.arp_announce':
    value => '2',
    order => '99',
  }

  # net.ipv4.conf.all.rp_filter = 2
  sysctl::set { 'net.ipv4.conf.all.rp_filter':
    value => '2',
    order => '99',
  }

}
