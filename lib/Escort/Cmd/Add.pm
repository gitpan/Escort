package Escort::Cmd::Add;
BEGIN {
  $Escort::Cmd::Add::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Cmd::Add::VERSION = '0.001';
}

use MooX Options => [ protect_argv => 0 ];
with qw( Escort::Cmd );

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

sub run {
	my ( $self, @args ) = @_;

	for (@args) {
		$self->escort->add_distribution($_,
			$self->has_author ? $self->author : undef,
			$self->has_seat ? $self->seat : undef,
		);
	}
}

1;

__END__

=pod

=head1 NAME

Escort::Cmd::Add

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Raudssus Social Software.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
