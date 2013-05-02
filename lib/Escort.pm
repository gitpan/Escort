package Escort;
BEGIN {
  $Escort::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::VERSION = '0.001';
}
# ABSTRACT: Base class for an escort managed repository

use Moo;
use Cwd;
use CPAN::Repository;
use Dist::Data;
use CPAN::Documentation::HTML;
use Path::Class;
use File::ShareDir qw( dist_dir );
use Class::Load ':all';

use Escort::Config;

use namespace::autoclean;

has root => (
	is => 'ro',
	required => 1,
);

has config_file => (
	is => 'ro',
	predicate => 1,
);

has config => (
	is => 'ro',
	lazy => 1,
	builder => sub {
		my $self = shift;
		Escort::Config->new(
			root => $self->root,
			$self->has_config_file ? ( config_file => $self->config_file ) : (),
		);
	},
);

sub distribution_filebase {
	my ( $self, $filename ) = @_;
	my $filebase = file($filename)->basename;
	$filebase =~ s/\.tar\.gz$//;
	$filebase =~ s/\.zip$//;
	return $filebase;
}

sub add_distribution {
	my ( $self, $dist, $author, $seat ) = @_;

	$author = 'CPAN' unless $author;
	my $filename = file($dist)->absolute->stringify;

	my $repo = $self->get_cpan_repository($seat);
	$repo->add_author_distribution($author, $filename);

	my $distdata = Dist::Data->new(
		dir => dir($repo->dir,'release',$self->distribution_filebase($filename)),
		filename => $filename,
	);
	$distdata->extract_distribution;

	my $cdh = CPAN::Documentation::HTML->new( root => $repo->dir );
	$cdh->add_dist($filename);
	$cdh->save_index;
	$cdh->save_cache;

	$self->save_index($seat);
	$self->config->save_config;

	return;
}

has assets => (
	is => 'ro',
	lazy => 1,
	builder => sub {{
		"default.css" => file(dist_dir('CPAN-Documentation-HTML'),'default.css'),
		"default.png" => file(dist_dir('CPAN-Documentation-HTML'),'default.png'),
	}},
);

sub replace_assets {
	my ( $self, $zoom, $prefix ) = @_;
	$prefix = '' unless $prefix;
	for (keys %{$self->assets}) {
		my $file = $_;
		my $id_file = $file;
		$id_file =~ s/\./-/g;
		for (qw( src href )) {
			$zoom = $zoom->select('#cdh-'.$_.'-'.$id_file)->add_to_attribute( $_ => $prefix.'perldoc/'.$file );
		}
	}
	$zoom = $zoom->select('#cdh-index-link')->add_to_attribute( href => $prefix.'perldoc/index.html' );
	return $zoom;
}

sub save_index {
	my ( $self, $seat ) = @_;
	my $target = file($self->seat_dir($seat),'index.html');
	$target->spew(
		$self->replace_assets(
			HTML::Zoom->from_html(scalar file(dist_dir('CPAN-Documentation-HTML'),'default.html')->slurp)
				->select('.cdh-title')
					->replace_content('Your private CPAN repository'.(
						$seat ? ' - Seat: '.$seat : ''
					))
				->select('.cdh-body')
					->replace_content('Meh...')
		)->to_html
	);

}

sub seat_dir {
	my ( $self, $seat ) = @_;
	if (defined $seat and defined $self->config->seatmap->{$seat}) {
		$seat = $self->config->seatmap->{$seat};
	}
	my $dir = defined $seat && $self->has_seat($seat)
			? dir($self->root,$seat)
			: dir($self->root);
}

sub has_seat {
	my ( $self, $seat ) = @_;
	return 0 unless $seat;
	return 0 if grep { $_ eq $seat } qw(
		modules
		authors
		perldoc
	);
	return 0 if $seat =~ m!^\.!;
	return -d dir($self->root,$seat)->absolute->stringify ? 1 : 0;
}

sub get_cpan_repository {
	my ( $self, $seat ) = @_;
	CPAN::Repository->new(
		dir => $self->seat_dir($seat)->absolute->stringify,
	);
}

sub hostname_to_seat {
	my ( $self, $hostname ) = @_;
	if ($self->config->use_host_only) {
		my @hostparts = split(/\./,$hostname);
		$hostname = shift @hostparts;
	}
	return $hostname;
}

sub sync {
	my ( $self, $remote ) = @_;
	my ( $scheme ) = split(":",$remote);
	my $class = 'Escort::Sync::'.uc($scheme);
	load_class($class);
	return $class->new(
		escort => $self->escort,
		remote => $remote,
	);
}

1;

__END__

=pod

=head1 NAME

Escort - Base class for an escort managed repository

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Raudssus Social Software.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
