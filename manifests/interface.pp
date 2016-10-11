define iscsi::interface($interface = $name) {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if ! defined(Class['iscsi'])
  {
    fail('You must include the iscsi base class before using any iscsi defined resources')
  }

  # # iscsiadm -m iface -I eth2 -o new
  # New interface eth2 added
  # # iscsiadm -m iface -I eth3 -o new
  # New interface eth3 added
  # # iscsiadm -m iface -I eth2 -n iface.net_ifacename -v eth2 -o update
  # eth2 updated.
  # # iscsiadm -m iface -I eth3 -n iface.net_ifacename -v eth3 -o update
  # eth3 updated.

  exec { "interface iscsi ${interface}":
    command => "bash -c 'iscsiadm -m iface -I ${interface} -o new ; iscsiadm -m iface -I ${interface} -n iface.net_ifacename -v ${interface} -o update'",
    unless  => "bash -c 'iscsiadm -m iface | grep ^${interface} | cut -f4 -d, | grep ${interface}'",
    require => Class['iscsi::install'],
  }

}
