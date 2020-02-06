package Linux::Installer::Tool::Chroot;

use strict;
use warnings;

use Moose;
extends 'Linux::Installer';

sub _mount_api_filesystems {
    my $self = shift;

    my $cmd;
    foreach my $api_filesystem (qw{ proc sys dev }) {
        $cmd = sprintf "mkdir -p %s",
          File::Spec->catdir( $self->mountpoint, $api_filesystem );
        $self->exec($cmd);
    }

    $cmd = sprintf "mount -t proc /proc %s",
      File::Spec->catdir( $self->mountpoint, 'proc' );
    $self->exec($cmd);

    $cmd = sprintf "mount -o bind /sys %s", File::Spec->catdir( $self->mountpoint, 'sys' );
    $self->exec($cmd);

    $cmd = sprintf "mount -o bind /dev %s", File::Spec->catdir( $self->mountpoint, 'dev' );
    $self->exec($cmd);

    return;
}

sub _umount_api_filesystems {
    my $self = shift;

    foreach my $api_filesystem (qw{ proc sys dev }) {
        my $cmd = sprintf "umount %s",
          File::Spec->catdir( $self->mountpoint, $api_filesystem );
        $self->exec($cmd);
    }

    return;
}

sub _chroot {
    my $self = shift;

    $self->logger->info("Chroot into system.");

    my $cmd = sprintf "chroot %s", $self->mountpoint;
    $self->exec($cmd);

    return;
}

override 'run' => sub {
    my $self = shift;

    $self->_open_crypted_partition();
    $self->_mount_filesystem();
    $self->_mount_api_filesystems();

    $self->_chroot();

    $self->_umount_api_filesystems();
    $self->_umount_filesystem();

    my $cmd = sprintf "rm -rf %s", $self->root;
    $self->exec($cmd);

    $self->_close_crypted_partition();

    return;
};

__PACKAGE__->meta->make_immutable;

1;
