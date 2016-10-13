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

  file { '/tmp/session':
    ensure => 'present',
    content => template("${module_name}/session/execsession.erb"),

  }

  exec { "interface iscsi ${targetname}":
    command => "bash -c 'iscsiadm -m discovery -p ${targetname} -t st; iscsiadm -m node -L automatic'",
    unless  => "iscsiadm -m node",
    require => Class['iscsi::service'],
  }

}
