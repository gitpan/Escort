package Escort::Sync::SSH;
BEGIN {
  $Escort::Sync::SSH::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Sync::SSH::VERSION = '0.002';
}
# ABSTRACT: Syncing to a remote SSH target

use Moo;
with qw( Escort::Sync );

sub sync {
	my ( $self, $remote ) = @_;
}

1;

__END__

=pod

=head1 NAME

Escort::Sync::SSH - Syncing to a remote SSH target

=head1 VERSION

version 0.002

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Raudssus Social Software.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
