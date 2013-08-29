# Configure APT sources before installing packages
Apt::Source <| |> -> Apt::Pin <| |> -> Exec['apt_update'] -> Package <| |>

# Update APT before installing any packages
Exec <| title=='apt_update' |> -> Package <| |>

Exec {
  path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
}

hiera_include("classes")
