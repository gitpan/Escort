package Escort::App;
BEGIN {
  $Escort::App::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::App::VERSION = '0.002';
}
# ABSTRACT: Base class for the command line application

use Moo;
use MooX::Options;
use MooX::Cmd base => 'Escort::Cmd';
use Cwd;
use Escort;

option config_file => (
	is => 'ro',
	format => 's',
	predicate => 1,
);

option root => (
	is => 'ro',
	format => 's',
	default => sub { getcwd() },
);

has escort => (
	is => 'ro',
	lazy => 1,
	builder => sub {
		my ( $self ) = @_;
		Escort->new(
			root => $self->root,
			$self->has_config_file ? ( config_file => $self->config_file ) : (),
		);
	},
);

sub execute {
	my ( $self, $args, $chain ) = @_;
	print <<"__EOHELP__";

Usage:

$0
  [--root /root/of/cpan]
  [--config_file /alternative/config_file.yml]
  add
    [--author AUTHOR]
    [--seat differentsubcpan]
    File-0.001.tgz OtherFile-0.002.tar.gz
  release
    [--author AUTHOR]
    [--seat differentsubcpan]
    Dist-Name
  get
    [--author AUTHOR]
    [--original_author]
    [--seat differentsubcpan]
    [--fetch_only]
    Dist-Name-0.004
  server
    [--listen HOST:PORT]
  surveyor
    [... optional dist_surveyor parameter ...]
    /library/path/for/dist_surveyor

Commands:

add			Adding several distributions to your CPAN

release		Add current directory with given Dist-Name [TODO]

server		Starts up a webserver for accessing your CPAN

surveyor	Generates CPAN from given lib directory [TODO]
			See https://metacpan.org/module/Dist::Surveyor

__EOHELP__
	exit 0;
}

1;

__END__

=pod

=head1 NAME

Escort::App - Base class for the command line application

=head1 VERSION

version 0.002

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Raudssus Social Software.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
