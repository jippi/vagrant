class development::users {

	$users = loadyaml('/etc/vagrant/config/users.yaml')
	create_resources(development::user, $users)

}
