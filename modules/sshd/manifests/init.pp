class sshd {

	package { 'openssh-server':
		ensure	=> 'latest',
		allow_virtual	=> 'true',
	}

	service { 'sshd':
		ensure	=> 'running',
		enable	=> 'true',	
	}

	file { '/etc/ssh/sshd_config':
		content		=> template('sshd/sshd_config.erb'),
		require		=> Package['openssh-server'],
		notify		=> Service['sshd'],
	}
}
