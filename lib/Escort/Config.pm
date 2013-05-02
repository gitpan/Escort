package Escort::Config;
BEGIN {
  $Escort::Config::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Config::VERSION = '0.001';
}
# ABSTRACT: Config loading class

use Moo;
use YAML qw( LoadFile DumpFile );
use Path::Class;
use namespace::autoclean;

has root => (
	is => 'ro',
	required => 1,
);

has config_file => (
	is => 'ro',
	lazy => 1,
	builder => sub { file(shift->root,'.escort.yml') },
);

has config => (
	is => 'ro',
	lazy => 1,
	builder => sub {
		my $self = shift;
		-f $self->config_file
			? {%{LoadFile($self->config_file)}}
			: {}
	},
);

our %defaults = (
	seatmap => {},
	seattree => {},
	seattree_use_root => 0,
	use_host_only => 1,
	auto_generate => 1,
	upload_htpasswd => undef,
	upload_password => undef,
);

sub save_config {
	my ( $self ) = @_;
	my %config = map {
		defined $self->$_ ? ( $_ => $self->$_ ) : (),
	} keys %defaults;
	local $YAML::UseHeader = 0;
	DumpFile($self->config_file,\%config);
}

for my $attr (keys %defaults) {
	has $attr => (
		is => 'ro',
		lazy => 1,
		builder => sub { my $self = shift; defined $self->config->{$attr} ? $self->config->{$attr} : $defaults{$attr} },
	);
}

1;

__END__

=pod

=head1 NAME

Escort::Config - Config loading class

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Raudssus Social Software.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
