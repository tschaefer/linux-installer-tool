package Linux::Installer::Tool::Spawn;

use strict;
use warnings;

use Moose;
extends 'Linux::Installer';

sub _spawn {
    my $self = shift;

    $self->logger->info("Spwan System.");

    my $cmd = sprintf "systemd-nspawn --directory %s", $self->mountpoint;
    $self->exec($cmd);

    return;
}

override 'run' => sub {
    my $self = shift;

    $self->_open_crypted_partition();
    $self->_mount_filesystem();
    $self->_mount_api_filesystems();

    $self->_spawn();

    $self->_umount_api_filesystems();
    $self->_umount_filesystem();

    my $cmd = sprintf "rm -rf %s", $self->root;
    $self->exec($cmd);

    $self->_close_crypted_partition();

    return;
};

__PACKAGE__->meta->make_immutable;

1;
