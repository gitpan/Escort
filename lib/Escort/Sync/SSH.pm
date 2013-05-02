package Escort::Sync::SSH;
BEGIN {
  $Escort::Sync::SSH::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Sync::SSH::VERSION = '0.001';
}

use Moo;
with qw( Escort::Sync );

sub sync {
	my ( $self, $remote ) = @_;
}

1;

__END__

=pod

=head1 NAME

Escort::Sync::SSH

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Raudssus Social Software.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
