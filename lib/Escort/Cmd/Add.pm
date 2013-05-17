package Escort::Cmd::Add;
BEGIN {
  $Escort::Cmd::Add::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Cmd::Add::VERSION = '0.003';
}
# ABSTRACT: Simple command to add given distributions 

use MooX Options => [ protect_argv => 0 ];
with qw( Escort::SeatCmd );

sub run { shift->add_distribution($_) for (@_) }

1;

__END__
=pod

=head1 NAME

Escort::Cmd::Add - Simple command to add given distributions 

=head1 VERSION

version 0.003

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<https://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by L<Raudssus Social Software|https://raudss.us/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

