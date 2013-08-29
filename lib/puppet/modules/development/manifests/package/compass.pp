class development::package::compass {

	package { 'compass':
		ensure	 => installed,
		provider => gem;
	}

}
