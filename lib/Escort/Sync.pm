package Escort::Sync;
BEGIN {
  $Escort::Sync::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Sync::VERSION = '0.001';
}

use Moo::Role;
use DateTime;

requires 'sync';

has escort => (
    is => 'ro',
    required => 1,
);

has remote => (
    is => 'ro',
    required => 1,
);

#
# -1 = running
#  0 = failed
#  1 = success
#

has _status => (
    is => 'rw',
    builder => sub { -1 },
);
sub status { shift->_status }

has _log => (
    is => 'ro',
    builder => sub {[]},
);
sub log { shift->_log }

sub add_log {
    my ( $self, $log ) = @_;
    push @{$self->_log}, [ DateTime->now, $log ];
}

sub BUILD {
    my ( $self ) = @_;
    $self->add_log("Starting sync via ".(ref $self));
    $self->add_log("Remote: ".$self->remote);
    $self->add_log("Root  : ".$self->escort->root);
    $self->_status($self->sync);
    if ($self->status) {
        $self->add_log("Sync finished successful");
    } else {
        $self->add_log("Sync failed!");
    }
}

1;

__END__

=pod

=head1 NAME

Escort::Sync

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Raudssus Social Software.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
