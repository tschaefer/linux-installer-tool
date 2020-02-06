#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    'ABSTRACT'      => 'Swiss Army knife for the simple installer for embedded Linux systems.',
    'AUTHOR'        => 'Tobias Schaefer <github@blackox.org>',
    'DISTNAME'      => 'Linux-Installer-Tools',
    'EXE_FILES'     => [ 'bin/linux-installer-tool' ],
    'META_MERGE'    => {
        resources   => {
            'license'    => 'http://dev.perl.org/licenses',
            'homepage'   => 'https://github.com/tschaefer/linux-installer-tools',
            'repository' => 'https://github.com/tschaefer/linux-installer-tools.git',
        }
    },
    'NAME'          => 'Linux::Installer::Tool',
    'PREREQ_PM'     => {
        'Linux::Installer'  => '1.00'
    },
    'VERSION_FROM'  => 'lib/Linux/Installer/Tool.pm',
    'clean'         => { FILES => 'Linux-Installer-Tools-*' },
    'dist'          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    ($ExtUtils::MakeMaker::VERSION >= 6.3002 ? ('LICENSE' => 'perl', ) : ()),
);
