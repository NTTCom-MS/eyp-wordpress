class wordpress::params {

  $site_dependencies = [ 'unzip' ]

	case $::osfamily
	{
		'redhat':
    		{

			case $::operatingsystemrelease
			{
				/^[67].*$/:
				{
				}
				default: { fail("Unsupported RHEL/CentOS version!")  }
			}
		}
		'Debian':
		{

			case $::operatingsystem
			{
				'Ubuntu':
				{
					case $::operatingsystemrelease
					{
						/^14.*$/:
						{
						}
						default: { fail("Unsupported Ubuntu version! - $::operatingsystemrelease")  }
					}
				}
				'Debian': { fail("Unsupported")  }
				default: { fail("Unsupported Debian flavour!")  }
			}
		}
		default: { fail("Unsupported OS!")  }
	}
}
