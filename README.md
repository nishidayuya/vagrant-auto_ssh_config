# vagrant-auto_ssh_config

A vagrant plugin for automatically generating ssh_config entry.

[![License X11](https://img.shields.io/badge/license-X11-brightgreen.svg)](https://raw.githubusercontent.com/nishidayuya/vagrant-auto_ssh_config/master/LICENSE.txt)
[![Gem Version](https://badge.fury.io/rb/vagrant-auto_ssh_config.svg)](http://badge.fury.io/rb/vagrant-auto_ssh_config)

## Installation

```sh
$ vagrant plugin install vagrant-auto_ssh_config
```

## Usage

After plugin installed and run "vagrant up", you can login vagrant machine by "ssh vagrant-latest" without "vagrant ssh-config --host vagrant-latest >> ~/.ssh/config".

This plugin creates/updates ssh_config entry at "vagrant up". And it deletes ssh_config entry for "vagrant-latest" at "vagrant halt".

## News

0. 2014-11-06 0.0.0 First release.

## Development

### Test on Vagrant machine

1. Install related gems: `bundle`
2. Run Vagrant machine: `bundle exec vagrant up`

### Install from source

1. Create a gem: `bundle exec rake build`
2. Install built gem: `vagrant plugin install pkg/vagrant-auto_ssh_config-VERSION.gem`

### Contributing

1. Fork it ( https://github.com/nishidayuya/vagrant-auto_ssh_config/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
