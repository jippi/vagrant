# Disclaimer

This is kinda broken, please poke me at CakeFest to get a pre-build box

In case you really want to build it from scratch, then run "vagrant provision" like ~20 times to make it all work

# Usage

```
git clone https://github.com/jippi/vagrant.git
git submodule update --init --recursive
bin/up
```

SSH:

user: cakefest
pass: cakefest

Put your `id_rsa` and `id_rsa.pub` in `development/config/users/cakefest/.ssh`

Make sure they are with permission `0500` (`chmod -R 0700 development/config/users/cakefest/.ssh`)

Hostname:

Use `local.cakefest.org` or just `10.10.10.10`

