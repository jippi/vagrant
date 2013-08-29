require syslog-ng::define

class syslog-ng {

	include syslog-ng::package
	include syslog-ng::service
	include syslog-ng::files

}
