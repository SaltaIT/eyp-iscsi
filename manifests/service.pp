class iscsi::service inherits iscsi {

  #
  validate_bool($iscsi::manage_docker_service)
  validate_bool($iscsi::manage_service)
  validate_bool($iscsi::service_enable)

  validate_re($iscsi::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${iscsi::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $iscsi::manage_docker_service)
  {
    if($iscsi::manage_service)
    {
      service { 'iscsi':
        ensure => $service_ensure,
        enable => $service_enable,
      }

      service { 'iscsid':
        ensure => $service_ensure,
        enable => $service_enable,
      }
    }
  }
}
