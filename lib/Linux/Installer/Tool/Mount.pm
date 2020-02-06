package Linux::Installer::Tool::Mount;

use strict;
use warnings;

use Moose;
extends 'Linux::Installer';

has 'root' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

override 'run' => sub {
    my $self = shift;

    $self->logger->info("Mount system.");

    $self->_open_crypted_partition();
    $self->_mount_filesystem();

    return;
};

__PACKAGE__->meta->make_immutable;

1;