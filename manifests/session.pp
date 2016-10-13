define iscsi::session($ifaces, $portals, $target = $name) {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if ! defined(Class['iscsi'])
  {
    fail('You must include the iscsi base class before using any iscsi defined resources')
  }

  validate_array($ifaces)
  validate_array($portals)

  exec { "interface iscsi ${target} ${ifaces} ${portals}":
    command => template("${module_name}/session/execsession.erb"),
    unless  => "iscsiadm -m session | grep \"${target}\"",
    require => Class['iscsi::service'],
  }

}
