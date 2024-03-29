package Escort::Cmd::Surveyor;
BEGIN {
  $Escort::Cmd::Surveyor::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Cmd::Surveyor::VERSION = '0.003';
}
# ABSTRACT: [BETA] Command for getting packages from a given library directory

use MooX Options => [ protect_argv => 0 ];
with qw( Escort::SeatCmd );

sub run {
	my ( $self, @args ) = @_;
	require Dist::Surveyor;
	Dist::Surveyor::main('--makecpan',$self->escort->seat_dir($self->seat),@args);
}

1;

__END__
=pod

=head1 NAME

Escort::Cmd::Surveyor - [BETA] Command for getting packages from a given library directory

=head1 VERSION

version 0.003

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<https://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by L<Raudssus Social Software|https://raudss.us/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

