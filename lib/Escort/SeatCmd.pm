package Escort::SeatCmd;
BEGIN {
  $Escort::SeatCmd::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::SeatCmd::VERSION = '0.003';
}
# ABSTRACT: Role for commands which add distributions

use Moo::Role;
use MooX::Options protect_argv => 0;
with 'Escort::Cmd';

option author => (
	is => 'ro',
	format => 's',
	predicate => 1,
);

option seat => (
	is => 'ro',
	format => 's',
	predicate => 1,
);

option original_author => (
	is => 'ro',
);

option with_deps => (
	is => 'ro',
);

option with_min_deps => (
	is => 'ro',
);

option fetch_only => (
	is => 'ro',
);

sub add_distribution {
	my ( $self, $dist, $author ) = @_;

	unless ($self->original_author) {
		$author = $self->has_author ? $self->author : undef;
	}
	$self->escort->add_distribution($dist, $author, $self->seat) unless $self->fetch_only;
}

1;

__END__
=pod

=head1 NAME

Escort::SeatCmd - Role for commands which add distributions

=head1 VERSION

version 0.003

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<https://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by L<Raudssus Social Software|https://raudss.us/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

