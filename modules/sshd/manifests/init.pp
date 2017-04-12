class sshd {

	package { 'openssh-server':
		ensure	=> 'latest',
		allow_virtual	=> 'true',
	}

	service { 'sshd':
		ensure	=> 'running',
		enabled	=> 'true',
		
	}
}
