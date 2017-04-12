class workstation {
	package { 'vim':
		ensure	=> 'latest',
	}

	package { 'git':
		ensure	=> 'latest',
	}
}
