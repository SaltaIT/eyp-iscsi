define iscsi::interface(
                          $interface = $name,
                          $ensure    = 'present',
                        ) {

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

  case $ensure
  {
    'present':
    {
      exec { "interface iscsi ${interface}":
        command => "bash -c 'iscsiadm -m iface -I ${interface} -o new ; iscsiadm -m iface -I ${interface} -n iface.net_ifacename -v ${interface} -o update'",
        unless  => "bash -c 'iscsiadm -m iface | grep ^${interface} | cut -f4 -d, | grep ${interface}'",
        require => Class['iscsi::install'],
        tag     => 'eyp-iscsi-iface',
      }
    }
    default:
    {
      fail('not implemented')
    }
  }

  #tot aixo no te sentit:
  #
  # iscsiadm -m iface -I eth4 --op=delete
  # iscsiadm -m iface -I eth5 --op=delete
  # iscsiadm -m iface -I eth4 --op=new
  # iscsiadm -m iface -I eth5 --op=new
  #
  # iscsiadm -m iface -I eth4 --op=update -n iface.hwaddress -v $(ip a show eth4 | grep link | awk '{ print $2 }')
  # iscsiadm -m iface -I eth5 --op=update -n iface.hwaddress -v $(ip a show eth5 | grep link | awk '{ print $2 }')

  # exec { "interface iscsi ${interface} sethwaddr":
  #   command => "bash -c 'iscsiadm -m iface -I ${interface} --op=update -n iface.hwaddress -v $(ip a show ${interface} | grep link | awk \"{ print \$2 }\")'",
  # }

  # [root@centos7 ~]# iscsiadm -m iface -I eth2 --op=update -n iface.hwaddress -v $(ip a show eth2 | grep link | awk "{ print \$2 }")
  # iscsiadm: Can not update interface binding from net_ifacename to hwaddress. You must delete the interface and create a new one
  # [root@centos7 ~]#

  # si ja asignem una interficie a una interficie de iscsi la resta es absurd

  # iscsiadm -m iface -I eth4 --op=update -n iface.mtu -v 9000
  # iscsiadm -m iface -I eth5 --op=update -n iface.mtu -v 9000
  # iscsiadm -m iface -I eth4 --op=update -n iface.initiatorname -v $(cat /etc/iscsi/initiatorname.iscsi  | cut -f2 -d=)
  # iscsiadm -m iface -I eth5 --op=update -n iface.initiatorname -v $(cat /etc/iscsi/initiatorname.iscsi  | cut -f2 -d=)
  # iscsiadm -m iface -I eth4 --op=update -n iface.ipaddress -v $(ip a s eth4 | grep inet | awk '{ print $2 }' | cut -f1 -d/)
  # iscsiadm -m iface -I eth5 --op=update -n iface.ipaddress -v $(ip a s eth5 | grep inet | awk '{ print $2 }' | cut -f1 -d/)

}
