package Escort::Cmd::Release;
BEGIN {
  $Escort::Cmd::Release::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Cmd::Release::VERSION = '0.003';
}
# ABSTRACT: TODO

use MooX Options => [ protect_argv => 0 ];
with qw( Escort::SeatCmd );

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

Escort::Cmd::Release - TODO

=head1 VERSION

version 0.003

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<https://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by L<Raudssus Social Software|https://raudss.us/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

