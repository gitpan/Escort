package Escort::Web;
BEGIN {
  $Escort::Web::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Web::VERSION = '0.003';
}
# ABSTRACT: Web::Simple Web application for escort server

use Moo;
use Web::Simple;
use Plack::App::File;
use Plack::Builder;
use Path::Class;
use namespace::autoclean;

has escort => (
    is => 'ro',
    required => 1,
);
sub root { shift->escort->root }

sub dispatch_request {
    my $self = shift;
    my $env = shift;

    # session not yet
    # sub () { $self->session },

    sub (POST) {

        #sub {  },

    },

    sub () {

        my $path = $env->{PATH_INFO};
        my $seat = $self->escort->hostname_to_seat(split(":",$env->{HTTP_HOST}));
        my $root = $self->escort->seat_dir($seat);
        my $file = file($root,$path)->absolute->stringify;

        if (-f $file) {
            return [ 403, [ 'Content-type' => 'text/plain' ], [ 'forbidden' ] ] if $file =~ m!\.escort\.yml!;
            return Plack::App::File->new(file => $file);
        } elsif (-d $file) {
            return Plack::App::File->new(file => $file.'/index.html');
        } elsif ($path =~ m!/perldoc/(.*)$!) {
            my $new_url = 'https://metacpan.org/module/'.$1;
            return [ 303, [ 'Location' => $new_url, 'Content-type' => 'text/plain' ], [ 'Redirecting to '.$new_url ] ];            
        }

        return [ 404, [ 'Content-type' => 'text/plain' ], [ $path.' not found' ] ];

    },
}

1;
__END__
=pod

=head1 NAME

Escort::Web - Web::Simple Web application for escort server

=head1 VERSION

version 0.003

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<https://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by L<Raudssus Social Software|https://raudss.us/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

