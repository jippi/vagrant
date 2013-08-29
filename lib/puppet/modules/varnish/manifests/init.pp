class varnish {

	include varnish::apt
	include varnish::package
	include varnish::service
	include varnish::files

}
