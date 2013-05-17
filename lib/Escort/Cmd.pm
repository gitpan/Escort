package Escort::Cmd;
BEGIN {
  $Escort::Cmd::AUTHORITY = 'cpan:GETTY';
}
{
  $Escort::Cmd::VERSION = '0.003';
}
# ABSTRACT: Role for commands of escort

use Moo::Role;

requires 'run';

has app => (
	is => 'rw',
);

has escort => (
	is => 'ro',
	lazy => 1,
	builder => sub { shift->app->escort },
);

sub execute {
	my ( $self, $args, $chain ) = @_;
	my $app = shift @{$chain};
	$self->app($app);
	$self->run(@{$args});
}

1;

__END__
=pod

=head1 NAME

Escort::Cmd - Role for commands of escort

=head1 VERSION

version 0.003

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<https://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by L<Raudssus Social Software|https://raudss.us/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

