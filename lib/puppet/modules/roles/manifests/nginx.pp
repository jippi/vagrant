class roles::nginx {

  include nginx
  include nginx::apt
  include nginx::package
  include nginx::service
  include nginx::no_default_site
  include nginx::www_shell

}
