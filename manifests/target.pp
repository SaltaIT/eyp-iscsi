define iscsi::target($targetname = $name) {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if ! defined(Class['iscsi'])
  {
    fail('You must include the iscsi base class before using any iscsi defined resources')
  }

  exec { "interface iscsi ${targetname}":
    command => "bash -c 'iscsiadm -m discovery -p ${targetname} -t st; iscsiadm -m node -L automatic'",
    unless  => "bash -c 'iscsiadm -m node'",
    require => Class['iscsi::service'],
  }

}
