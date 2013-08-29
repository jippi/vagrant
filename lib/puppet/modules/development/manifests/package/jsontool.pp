class development::package::jsontool {

	package { 'jsontool':
		ensure 		=> installed,
		provider 	=> npm;
	}

}
