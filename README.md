# Disclaimer

This is kinda broken, please poke me (Jippi) to get a pre-build box

In case you really want to build it from scratch, then run "vagrant provision" like ~20 times to make it all work

It probably won't work yet though ;)

### Usage

Put your `id_rsa` and `id_rsa.pub` in `development/config/users/cakefest/.ssh`

Make sure they are with permission `0500` (`chmod -R 0700 development/config/users/cakefest/.ssh`)

This keys will automatically be used when using `git` inside the box

```
git clone https://github.com/jippi/vagrant.git
git submodule update --init --recursive
bin/up
```

### SSH:

user: cakefest
pass: cakefest

### Hostname:

Use `local.cakefest.org` or just `10.10.10.10`

### Services

```
SSH 22      [SSH]           : local.cakefest.org:22
HTTP 80     [nginx]         : http://local.cakefest.org/
HTTP 9200   [elastic search]: http://local.cakefest.org:9200/
MySQL 3306  [mysql]         : mysql://local.cakefest.org:3306
```

### Paths

When logged in as `cakefest` go to `www/cakefest/htdocs/`

Nginx is configured to use `www/cakefest/htdocs/webroot/` as root

### MySQL

user: cakefest
pass: cakefest

### phpmyadmin

phpMyAdmin can be found at http://local.cakefest.org/phpmyadmin

There will be 3 DBs

`cakefest` - the primary db

`cakefest_seed` - the optional seed db for tests

`cakefest_test` - the test db for phpunit

### CakePHP DB Config

There is a pre-defined `database.php` in `www/cakefest/database.php` - you can copy or symlink this to your `Config` directory

### Composer

Composer is installed globally as `composer`

### Software

```
PHP 5.5
Percona MySQL 5.6
Elastic Search 0.90.3
Redis
Gearman
PHPunit
Nginx
```
