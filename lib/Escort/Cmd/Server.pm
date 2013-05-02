package Escort::Cmd::Server;
BEGIN {
  $Escort::Cmd::Server::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Cmd::Server::VERSION = '0.002';
}
# ABSTRACT: Command for starting an independent webserver to use the repositories

use MooX Options => [ protect_argv => 0 ];
with qw( Escort::Cmd );

use Escort::Web;
use Plack::Runner;
use Starman;

option listen => (
	is => 'ro',
	format => 's',
	lazy => 1,
	builder => sub { ':80' },
);

sub run {
	my ( $self, @args ) = @_;

	my $runner = Plack::Runner->new(
		includes => ['lib'],
		server => 'Starman',
		app => 	Escort::Web->new(
			escort => $self->escort,
		)->to_psgi_app,
	);
	
	$runner->parse_options('--listen',$self->listen,@args);

	exit $runner->run;

}

1;

__END__

=pod

=head1 NAME

Escort::Cmd::Server - Command for starting an independent webserver to use the repositories

=head1 VERSION

version 0.002

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Raudssus Social Software.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
