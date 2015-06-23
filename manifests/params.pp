# mcelog::params
class mcelog::params {

  $package_name         = 'mcelog'
  $config_file_template = 'mcelog/mcelog.conf.erb'

  # MCE is only supported on x86_64
  if $::architecture != 'x86_64' {
    fail("Module ${module_name} is not supported on architecture: ${::architecture}")
  }

  # MCE is only supported on physical hardware
  if $::is_virtual == true or $::is_virtual == 'true' {
    fail("Module ${module_name} is not supported on virtual servers")
  }

  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        5: {
          $config_file_path = '/etc/mcelog.conf'
          $service_manage   = false
          $service_name     = 'mcelogd'
        }
        6: {
          $config_file_path = '/etc/mcelog/mcelog.conf'
          $service_manage   = true
          $service_name     = 'mcelogd'
        }
        7: {
          $config_file_path = '/etc/mcelog/mcelog.conf'
          $service_manage   = true
          $service_name     = 'mcelog'
        }
        default: {
          fail("Module ${module_name} is not supported on operatingsystemmajrelease: ${::operatingsystemmajrelease}")
        }
      }
    }
    default: {
      fail("Module ${module_name} is not supported on osfamily: ${::osfamily}")
    }
  }
}
