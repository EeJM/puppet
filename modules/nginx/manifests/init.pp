class nginx {

	package { "nginx":
		ensure	=> latest,
	}

	file { "/etc/nginx/nginx.conf":
		source	=> '/etc/modules/nginx/templates/nginx.conf',
	}

	file { ['/var/www/',
		'/var/www/eeromikkonen/', ]:
		ensure	=> 'directory',
		owner	=> 'nginx',
		group	=> 'nginx',
		recurse => true,
		mode	=> '0744',
	}

	service { 'nginx':
		ensure	=> 'running',
		enable	=> 'true',
	}

}
