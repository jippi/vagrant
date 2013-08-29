class jenkins {

  include jenkins::apt
  include jenkins::package
  include jenkins::service

}
