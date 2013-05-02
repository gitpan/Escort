package Escort::Cmd::Release;
BEGIN {
  $Escort::Cmd::Release::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Cmd::Release::VERSION = '0.001';
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

	die "command requires a distname as first parameter" unless @args;

	my $dist = shift @args;

	####

	die "It's on my todo";
}

1;

__END__

=pod

=head1 NAME

Escort::Cmd::Release

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Raudssus Social Software.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
