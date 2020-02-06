# linux-installer-tool

Swiss Army knife for the simple installer for embedded Linux systems.

## Introduction

__linux-installer-tool__

All instructions are given by configuration files. For examples see

    conf/installer.json
    conf/installer.log

in [Linux::Installer](https://github.com/tschaefer/linux-installer).

## Installation

Best way is to use the cpanm tool.

    $ perl Makefile.pl
    $ make dist
    $ VERSION=$(perl -le 'require "./lib/Linux/Installer/Tool.pm"; print
                $Linux::Installer::Tool::VERSION')
    $ cpanm Linux-Installer-Tool-$VERSION.tar.gz

## Usage

Following command will mount the filesystem hierachy defined in the
configuration file from the given device at the provided root path.

    $ linux-installer-mount \
      --config-file conf/installer.json \
      --log-config-file conf/installer.log.conf \
      --root-path /tmp/root \
      /dev/sdb

### License

http://dev.perl.org/licenses/
