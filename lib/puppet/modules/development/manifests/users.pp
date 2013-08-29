class development::users {

	$users = loadyaml('/etc/bownty/config/users.yaml')
	create_resources(development::user, $users)

}
