define iscsi::session($ifaces, $portals, $target = $name) {

  # DEPRECATED, please use iscsi::discovery

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  validate_array($ifaces)
  validate_array($portals)

  file { "/tmp/session-${ifaces}":
    ensure => 'present',
    content => template("${module_name}/session/execsession.erb"),
  }

  exec { "interface iscsi ${target} ${ifaces} ${portals}":
    command => template("${module_name}/session/execsession.erb"),
    unless  => "iscsiadm -m session",
    require => Class['iscsi::service'],
  }

}
