package Escort::Cmd::Sync;
BEGIN {
  $Escort::Cmd::Sync::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Cmd::Sync::VERSION = '0.003';
}
# ABSTRACT: Command for syncing to remote targets

use MooX Options => [ protect_argv => 0 ];
with qw( Escort::Cmd );

use Escort::Sync;

sub run {
	my ( $self, @args ) = @_;

	die "command requires at least one remote as first parameter" unless @args;

	for (@args) {
		$self->escort->sync($_);
	}
}

1;

__END__
=pod

=head1 NAME

Escort::Cmd::Sync - Command for syncing to remote targets

=head1 VERSION

version 0.003

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<https://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by L<Raudssus Social Software|https://raudss.us/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

