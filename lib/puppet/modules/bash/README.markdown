# puppet-bash

## Description

Deploys a set of bash initialization and profile files to `etc/`. In each profile one can query if the shell is a login shell, if it is interactive and if the profile has already been sourced by a parent shell. Profile files can be created either globally or per user, settings per user take precedence over global ones.

## Dependencies

* Tested with Puppet 2.6 and Bash 3/4
* Targeted for FreeBSD, for other systems path names and example profiles can easily be modified. Default is to deploy everything to `/usr/local/etc/bash`.

## Usage

Copy the files from `/usr/local/etc/bash/skel` to your user home (preserving symbolic links) and start a new shell. Then, place profile files either in `/usr/local/etc/bash/profiles` or `~/.bash_profiles`.

## Details

There is a nice [blog article](http://anselm-strauss.blogspot.com/2010/10/about-those-bash-profiles.html) ;-)

## Written By

[Anselm Strauss](http://github.com/amsibamsi)
