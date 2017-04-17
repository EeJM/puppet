class apache {

	if $operatingsystem == 'CentOS' {
		$apache = "httpd"
		$vhostPath = "/etc/httpd/conf.d"

	} else {
		$apache = "apache2"
		$vhostPath = "/etc/apache2/sites-enabled"


	}

	define apachevhost {
		file { "/etc/httpd/conf.d/${title}.conf":
			ensure	=> 'present',
			mode	=> '0644',
			content	=> template("apache/vhost.conf.erb"),
			require => Package['httpd'],
			notify  => Service['httpd'],
		}

		file { "/var/www/${title}/":
			ensure	=> 'directory',
			mode	=> '0755',
		}

		file { "/var/www/${title}/index.html":
			ensure	=> 'present',
			mode	=> '0644',
			content	=> "This is a virtualhost ${title}\n"
		}
	}

	package {$apache:
		ensure		=> 'latest',
		allow_virtual	=> 'true',
	}

	file { '/var/www/':
		ensure	=> 'directory',
		mode	=> '0775',
	}

	apachevhost { "testsite":
		
	}

	apachevhost { "testsite2":

	}

	file { "/var/www/html/index.html":
		content => 'This is the default landing page.',
		require => Package[$apache],
	}

	service { $apache:
		ensure	=> 'running',
		enable	=> 'true',
	}
}
