class apache {

	if $operatingsystem == 'CentOS' {
		package {'httpd':
			ensure		=> 'latest',
			allow_virtual	=> 'true',
		}
	}
	else {
		package {'apache2':
			ensure		=> 'latest',
			allow_virtual	=> 'true',
		}
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

	# Use this if you want the virtual host inside of a users home folder.

	#user { 'eero':
	#	ensure	=> 'present',
	#	home	=> '/home/eero',
	#	# The password is hashed and since this is a test script the password is: bJyTK6!K6M6-Ae!KD
	#	password => '$6$Gx6ZKz0m$v9NyqeDpTb/7w025j0DF80gNg0v.yZmLf8TtoI7BcqkH7Ij8spj9tkBSSQKGMrWjwmAkUUy39k6n..uLUoSX40',
	#}

	#file { '/home/eero/':
	#	ensure	=> 'directory',
	#	mode	=> '0755',
	#	require => User['eero'],
	#}

	#file { '/home/eero/public_html/':
	#	ensure	=> 'directory',
	#	owner	=> 'eero',
	#	group	=> 'eero',
	#	mode	=> '0755',
	#	require	=> User['eero'],
	#}

	#file { '/home/eero/public_html/index.html':
	#	owner	=> 'eero',
	#	group	=> 'eero',
	#	content	=> 'This is the working virtualhost for Eero.',
	#	mode	=> '0644',
	#	require	=> User['eero'],
	#}

	if $operatingsystem == 'CentOS' {

		file { '/etc/httpd/conf/httpd.conf':
			content	=> template('apache/httpd.conf.erb'),
			require	=> Package['httpd'],
			notify	=> Service['httpd'],
		}


	}
	else {

		file { '/etc/apache2/sites-enabled/eero.conf':
			content	=> template('apache/eero.conf.erb'),
			require => Package['apache2'],
			notify	=> Service['apache2'],
		}
	}

	if $operatingsystem == 'CentOS' {

		file { '/var/www/html/index.html':
			content => 'This is the default landing page.',
			require => Package['httpd'],
		}
	}
	else {
		file { '/var/www/html/index.html':
                        content => 'This is the default landing page.',
                        require => Package['apache2'],
                }
	}


	if $operatingsystem == 'CentOS' {
		service { 'httpd':
			ensure	=> 'running',
			enable	=> 'true',
		}
	}
	else {
		service { 'apache2':
			ensure	=> 'running',
			enable	=> 'true',
		}
	}
}
