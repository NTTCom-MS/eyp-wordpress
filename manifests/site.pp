#
define wordpress::site(
                        $dbname,
                        $dbuser,
                        $dbpassword,
                        $dbhost='localhost',
                        $basedir=$name,
                        $srcdir='/usr/local/src',

			                ) {

	if ! defined(Class['wordpress'])
	{
		fail('You must include the wordpress base class before using any wordpress defined resources')
	}

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  file { "${basedir}/wp-config.php":
    ensure => 'present',
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => template("${module_name}/wpconfig.erb"),
  }

  exec { "mkdir p basedir ${basedir} wordpress":
    command => "mkdir -p ${basedir}",
    creates => $basedir,
  }

  exec { "copy ${basedir} wordpress":
    require => [
                Package['unzip'],
                Exec[["unzip wordpress ${srcdir}", "mkdir p basedir ${basedir} wordpress"]],
              ],
    command => "cp -r ${srcdir}/wordpress/* ${basedir}",
    creates => "${basedir}/wp-login.php",
  }





}
