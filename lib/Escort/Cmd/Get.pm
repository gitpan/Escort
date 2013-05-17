package Escort::Cmd::Get;
BEGIN {
  $Escort::Cmd::Get::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Cmd::Get::VERSION = '0.003';
}
# ABSTRACT: Get a specific distribution version (fetched via MetaCPAN)

use MooX Options => [ protect_argv => 0 ];
with qw( Escort::SeatCmd );

use JSON;
use LWP::Simple;
use URI;
use File::Temp qw( tempdir );
use Path::Class;
use namespace::autoclean;

sub run {
	my ( $self, @args ) = @_;
	for (@args) {
		my $data = decode_json(get('http://api.metacpan.org/release/_search?q=name:'.$_));
		my $hits = $data->{hits}->{total};
		if ($hits) {
			my $source = $data->{hits}->{hits}->[0]->{_source};
			my $download_url = URI->new($source->{download_url});
			my @path_segments = $download_url->path_segments;
			my $filename = pop @path_segments;
			my $author = $source->{author};
			if ($self->fetch_only) {
				getstore($download_url->as_string, $filename);
			} else {
				my $temp = tempdir;
				my $tempfile = file($temp,$filename)->stringify;
				getstore($download_url->as_string, $tempfile);
				$self->add_distribution($tempfile,$author);
			}
		} else {
			warn $_." distribution not found via api.metacpan.org!";
		}
	}

}

1;

__END__
=pod

=head1 NAME

Escort::Cmd::Get - Get a specific distribution version (fetched via MetaCPAN)

=head1 VERSION

version 0.003

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<https://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by L<Raudssus Social Software|https://raudss.us/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

