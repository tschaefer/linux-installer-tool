package Linux::Installer::Tool::Umount;

use strict;
use warnings;

use Moose;
extends 'Linux::Installer';

has 'root' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

override '_build_disk' => sub {
    my $self = shift;

    my $disk = Linux::Installer::Disk->new( { device => $self->device } );

    return $disk;
};

override 'run' => sub {
    my $self = shift;

    $self->logger->info("Umount system.");

    $self->_umount_filesystem();

    my $cmd = sprintf "rm -rf %s", $self->root;
    $self->exec($cmd);

    $self->_close_crypted_partition();

    return;
};

__PACKAGE__->meta->make_immutable;

1;