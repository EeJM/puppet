class helloeero {

	file { "/tmp/helloworld":
		owner	=> "sucker",
		group	=> "sucker",
		mode	=> "640",
		content => "Eero made this.\n",
	}

	package { "openssh-server":
		ensure	=> latest
	}

	package { "vim":
		ensure	=> latest
	}
}
