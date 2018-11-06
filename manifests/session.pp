define iscsi::session(
                        $iface,
                        $portals,
                        $target = $name,
                        $debug  = false,
                      ) {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if($debug)
  {
    file { "/tmp/session-${iface}":
      ensure  => 'present',
      content => template("${module_name}/session/execsession.erb"),
    }
  }

  Exec <| tag == 'eyp-iscsi-discovery' |>

  ->

  exec { "interface iscsi ${target} ${iface} ${portals}":
    command => template("${module_name}/session/execsession.erb"),
    unless  => "iscsiadm -m session -P 1 | grep -E \"Iface Name|Target\" | paste - - - - - | grep ${iface} | grep ${target}",
    require => Class['iscsi::service'],
    tag     => 'eyp-iscsi-session',
  }

}
