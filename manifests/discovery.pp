# iscsiadm -m discovery -t sendtargets -p 1.2.3.4 -p 5.6.7.8 (...) -I eth0
define iscsi::discovery(
                          $portals,
                          $iface=$name,
                          $debug=false
                        ) {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  validate_string($iface)
  validate_array($portals)

  if($debug)
  {
    file { "/tmp/discovery-${iface}":
      ensure  => 'present',
      content => template("${module_name}/discovery.erb"),
    }
  }

  exec { "interface iscsi ${iface} ${portals}":
    command => template("${module_name}/discovery.erb"),
    unless  => 'iscsiadm -m session',
    require => [ Class['iscsi::service'], Iscsi::Interface[$iface] ],
  }

}
