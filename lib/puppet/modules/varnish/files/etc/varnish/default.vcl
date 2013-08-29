# This is a basic VCL configuration file for varnish.  See the vcl(7)
# man page for details on VCL syntax and semantics.
#
# Default backend definition.  Set this to point to your content
# server.
#

backend default {
	.host                   = "web";
    .port                   = "80";
    .connect_timeout        = 180s;
    .first_byte_timeout     = 180s;
    .between_bytes_timeout  = 80s;
    .probe = {
        .request =
              "GET / HTTP/1.1"
              "Host: 100-default.like.st"
              "Connection: close";
    }
}

#
# Below is a commented-out copy of the default VCL logic.  If you
# redefine any of these subroutines, the built-in logic will be
# appended to your code.
#
sub vcl_recv {
	set req.backend = default;

	if (req.backend.healthy) {
		set req.grace = 30s;
	} else {
		set req.grace = 1h;
	}

	if (req.restarts == 0) {
		if (req.http.x-forwarded-for) {
			set req.http.X-Origin-IP	= req.http.X-Forwarded-For;
			set req.http.X-Forwarded-For	= req.http.X-Forwarded-For + ", " + client.ip;
		} else {
			set req.http.X-Origin-IP	= client.ip;
			set req.http.X-Forwarded-For	= client.ip;
		}
	}

    if (req.http.Authorization || req.http.WWW-Authenticate) {
            /* Not cacheable by default */
            return (pass);
    }

	# Pipe Range requests
	if (req.http.Range) {
		return(pipe);
	}

	# Facebook hack
	if (req.http.user-agent ~ "facebookexternalhit") {
		return(pipe);
	}

	if (req.request != "GET" && req.request != "HEAD" && req.request != "PUT" && req.request != "POST" && req.request != "TRACE" && req.request != "OPTIONS" && req.request != "DELETE") {
		 /* Non-RFC2616 or CONNECT which is weird. */
		 return (pipe);
	}

	if (req.request != "GET" && req.request != "HEAD") {
		/* We only deal with GET and HEAD by default */
		return (pass);
	}

	# Never cache admin
	if (req.url ~ "^/admin/") {
		return (pass);
	}

	set req.http.X-AllowCookies = "no";
	if (req.url ~ "^/files/" || req.url ~ "^/theme/" || req.url ~ "/img/" || req.url ~ "/css/" || req.url ~ "/js/" || req.url ~ "/fonts/") {
		set req.http.X-AllowCookies = "yes";
#		unset req.http.Cookie;
	}

	# bonbon
	if (req.url ~ "^/tagging_race/css/" || req.url ~ "^/tagging_race/images/") {
		unset req.http.Cookie;
	}

	if ((req.http.Cookie && req.http.X-AllowCookies != "yes")) {
		/* Not cacheable by default */
		return (pass);
	}

	set req.http.X-CanPurge		= "no";
	set req.http.X-SkipCache	= "no";

	# No cache IPs
	#if (req.http.X-Origin-IP ~ "109\.202\.139\.50") {
	#	set req.http.X-SkipCache	= "yes";
	#	set req.http.X-CanPurge		= "yes";
	#}

	# Purge IPs
	#if (req.http.X-Origin-IP ~ "109\.202\.139\.50") {
	#	set req.http.X-CanPurge = "yes";
	#}

	# test
	if (req.http.Cache-Control ~ "no-cache") {
		return (pass);
	}

	if (req.http.X-CanPurge == "yes") {
		if (req.http.Cache-Control ~ "no-cache") {
			ban("req.url ~ " + req.url);
			return (pass);
		}

		if (req.request == "PURGE") {
			ban("req.url ~ " + req.url);
			return (pass);
		}
	 }

	 if (req.http.Accept-Encoding) {
		# Handle compression correctly. Varnish treats headers literally, not
		# semantically. So it is very well possible that there are cache misses
		# because the headers sent by different browsers aren't the same.
		# @see: http:// varnish.projects.linpro.no/wiki/FAQ/Compression
		if (req.http.Accept-Encoding ~ "gzip") {
			# if the browser supports it, we'll use gzip
			set req.http.Accept-Encoding = "gzip";
		} elsif (req.http.Accept-Encoding ~ "deflate") {
			# next, try deflate if it is supported
			set req.http.Accept-Encoding = "deflate";
		} else {
			# unknown algorithm. Probably junk, remove it
			unset req.http.Accept-Encoding;
		}
	}

	# assets
	if (req.url ~ "^/files/" || req.url ~ "^/theme/" || req.url ~ "/img/" || req.url ~ "/css/" || req.url ~ "/js/" || req.url ~ "/fonts/") {
		return(lookup);
	}

	# stats (dktop)
	if (req.url ~ "^/pages/top_list/" || req.url ~ "^/pages/graph" || req.url ~ "^/content/politikendk/") {
	        unset req.http.Cookie;
		return(lookup);
	}

	# bonbon
	if (req.url ~ "^/tagging_race/css/" || req.url ~ "^/tagging_race/images/") {
		return(lookup);
	}

	# Disable cache by default
	return (pass);
}
#
sub vcl_pipe {
	# Note that only the first request to the backend will have
	# X-Forwarded-For set.	If you use X-Forwarded-For and want to
	# have it set for all requests, make sure to have:
	set bereq.http.connection = "close";
	# here.	 It is not set by default as it might break some broken web
	# applications, like IIS with NTLM authentication.
	return (pipe);
}
#
# sub vcl_pass {
#	  return (pass);
# }
#
# sub vcl_hash {
#	  set req.hash += req.url;
#	  if (req.http.host) {
#		  set req.hash += req.http.host;
#	  } else {
#		  set req.hash += server.ip;
#	  }
#	  return (hash);
# }
#
sub vcl_hit {
	if (req.request == "PURGE") {
		set obj.ttl = 0s;
		error 200 "Purged.";
	}
	if (obj.ttl == 0s) {
		return(pass);
	}
	return(deliver);
}

sub vcl_miss {

	if (req.request == "PURGE") {
		error 404 "Not in cache.";
	}
}

sub vcl_fetch {
	set beresp.do_esi = true; /* Do ESI processing               */

#	Disabled as it was hiding error output
#	if (beresp.status != 200 && beresp.status != 403 && beresp.status != 404 && beresp.status != 301 && beresp.status != 302) {
#		return(restart);
#	}

	if (req.http.Authorization || req.http.WWW-Authenticate || beresp.http.WWW-Authenticate) {
		return(hit_for_pass);
	}

	set beresp.ttl = 600s;

	# Never cache admin
        if (req.url ~ "^/admin/") {
		set beresp.ttl = 0s;
        }

	if (req.http.X-SkipCache == "yes") {
		set beresp.ttl = 0s;
	}

	if (req.http.X-CanPurge == "yes") {
		set beresp.http.X-CanPurge = "Can purge";
	}

	# Respect force-reload, and clear cache
	if (req.http.Cache-Control ~ "no-cache") {
		set beresp.http.X-Cacheable = "NO:Not Cacheable (Forced reload)";
		ban("req.url ~ " + req.url);
		return (hit_for_pass);
	}

	# Only cache stuff that is cacheable
        if (req.url ~ "^/files/" || req.url ~ "^/theme/" || req.url ~ "/img/" || req.url ~ "/css/" || req.url ~ "/js/" || req.url ~ "/fonts/") {
                unset beresp.http.Cookie;
		unset beresp.http.Set-Cookie;
		set beresp.ttl = 1s;
        }

        # stats (dktop)
        if (req.url ~ "^/pages/top_list/" || req.url ~ "^/pages/graph" || req.url ~ "^/content/politikendk/") {
                unset beresp.http.Cookie;
		unset beresp.http.Set-Cookie;
		set beresp.ttl = 1s;
        }

	if (beresp.ttl == 0s) {
		set beresp.http.X-Cacheable = "NO:Not Cacheable (beresp)";
		return (hit_for_pass);
	}

	if (beresp.http.Set-Cookie) {
		set beresp.http.X-Cacheable = "NO:Not Cacheable (Set-Cookie)";
		return (hit_for_pass);
	}

        if (beresp.ttl < 0s) {
                set beresp.http.X-Cacheable = "NO:Not Cacheable (TTL < 0)";
                return (hit_for_pass);
        }

	if (!beresp.http.X-Cacheable) {
		set beresp.http.X-Cacheable = "Yes";
	}

	# BMW is a special kiddo, cache it for one hour
	if (req.http.host ~ "bmw.like.st") {
		set beresp.ttl = 3600s;
	}

	if (beresp.ttl < 600s) {
		set beresp.http.X-Cacheable-info = "Raised ttl from " + beresp.ttl + " to 600";
		set beresp.ttl = 600s;
	}

	return (deliver);
}


sub vcl_deliver {
	set resp.http.X-Served-By = server.hostname;

	if (obj.hits > 0) {
		set resp.http.X-Cache = "HIT";
		set resp.http.X-Cache-Hits = obj.hits;
	} else {
		set resp.http.X-Cache = "MISS";
	}

	return (deliver);
}
#
# sub vcl_error {
#	  set obj.http.Content-Type = "text/html; charset=utf-8";
#	  synthetic {"
# <?xml version="1.0" encoding="utf-8"?>
# <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
#  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
# <html>
#	<head>
#	  <title>"} obj.status " " obj.response {"</title>
#	</head>
#	<body>
#	  <h1>Error "} obj.status " " obj.response {"</h1>
#	  <p>"} obj.response {"</p>
#	  <h3>Guru Meditation:</h3>
#	  <p>XID: "} req.xid {"</p>
#	  <hr>
#	  <p>Varnish cache server</p>
#	</body>
# </html>
# "};
#	  return (deliver);
# }
