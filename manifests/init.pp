# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class wordpress($srcdir='/usr/local/src') inherits wordpress::params {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  exec { "mkdir wordpress ${srcdir}":
    command => "mkdir -p ${srcdir}",
    creates => $srcdir,
  }

  exec { "download wordpress.zip ${srcdir}":
    require => Exec["mkdir wordpress ${srcdir}"],
    command => "wget --no-check-certificate http://wordpress.org/latest.zip -O ${srcdir}/latest-wordpress.zip",
    creates => "${srcdir}/latest-wordpress.zip",
  }

  exec { "unzip wordpress ${srcdir}":
    command => "unzip ${srcdir}/latest-wordpress.zip -d ${srcdir}",
    creates => "${srcdir}/wordpress/wp-login.php",
    require => [Package['unzip'] ,Exec["download wordpress.zip ${srcdir}"]],
  }


}
