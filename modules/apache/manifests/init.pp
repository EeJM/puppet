class apache {

	if $operatingsystem == 'CentOS' {
		$apache = "httpd"
		$vhostPath = "/etc/httpd/conf.d"
	} else {
		$apache = "apache2"
		$vhostPath = "/etc/apache2/sites-enabled"
	}
	package {$apache:
		ensure		=> 'latest',
		allow_virtual	=> 'true',
	}

	file { ['/var/www/',
		'/var/www/eero.testi.com/', ]:
		ensure	=> 'directory',
		mode	=> '0755',
		
	}

	file { '/var/www/eero.testi.com/index.html':
		ensure	=> 'present',
		mode	=> '0644',
		content => 'This is the working virtualhost.',
	}

	file { "$vhostPath/eero.conf":
		content	=> template('apache/eero.conf.erb'),
		require	=> Package[$apache],
		notify	=> Service[$apache],
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
