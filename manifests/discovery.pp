# iscsiadm -m discovery -t sendtargets -p 1.2.3.4 -p 5.6.7.8 (...) -I eth0
define iscsi::discovery(
                          $portals,
                          $ifaces = undef,
                          $debug  = false
                        ) {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  validate_array($portals)

  if($debug)
  {
    file { "/tmp/discovery-${name}":
      ensure  => 'present',
      content => template("${module_name}/discovery.erb"),
    }
  }

  Exec <| tag == 'eyp-iscsi-iface' |>

  ->

  exec { "interface iscsi ${name} ${portals}":
    command => template("${module_name}/discovery.erb"),
    unless  => 'iscsiadm -m session',
    require => Class['iscsi::service'],
    tag     => 'eyp-iscsi-discovery',
  }

}
