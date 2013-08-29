class ssh::server::config::gateway_ports($ensure = 'enabled') {

  augeas { "ssh-allow-gateway-ports":
    context => "/files/etc/ssh/sshd_config",
    changes => [
      $ensure ? {
        enabled => "set GatewayPorts 'yes'",
        default => "set GatewayPorts 'no'"
      }
    ],
    notify => Service['ssh']
  }

}
