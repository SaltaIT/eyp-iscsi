# == Class: iscsi
#
# === iscsi::install documentation
#
class iscsi::install inherits iscsi {

  if($iscsi::multipath)
  {
    class { 'multipathd': }
  }

  if($iscsi::manage_package)
  {
    package { $iscsi::params::package_name:
      ensure => $iscsi::package_ensure,
    }
  }

}
