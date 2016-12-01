define iscsi::interface($interface = $name) {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
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

  #revisar:
  # 
  # iscsiadm --mode node --logoutall=all
  # iscsiadm -m iface -I eth4 --op=delete
  # iscsiadm -m iface -I eth5 --op=delete
  # iscsiadm -m iface -I eth4 --op=new
  # iscsiadm -m iface -I eth5 --op=new
  # iscsiadm -m iface -I eth4 --op=update -n iface.hwaddress -v 00:21:f6:16:af:c5
  # iscsiadm -m iface -I eth5 --op=update -n iface.hwaddress -v 00:21:f6:74:9a:b9
  # iscsiadm -m iface -I eth4 --op=update -n iface.mtu -v 9000
  # iscsiadm -m iface -I eth5 --op=update -n iface.mtu -v 9000
  # iscsiadm -m iface -I eth4 --op=update -n iface.initiatorname -v iqn.1994-05.com.redhat:evl8800545
  # iscsiadm -m iface -I eth5 --op=update -n iface.initiatorname -v iqn.1994-05.com.redhat:evl8800545
  # iscsiadm -m iface -I eth4 --op=update -n iface.ipaddress -v 10.155.147.77
  # iscsiadm -m iface -I eth --op=update -n iface.ipaddress -v 10.155.147.141
  # iscsiadm -m discovery -t sendtargets -p 10.155.147.123 -p 10.155.147.124 -p 10.155.147.125 -p 10.155.147.126 -I eth4
  # iscsiadm -m discovery -t sendtargets -p 10.155.147.187 -p 10.155.147.188 -p 10.155.147.189 -p 10.155.147.190 -I eth5
  # iscsiadm -m node -l
  # multipath -v2

}
