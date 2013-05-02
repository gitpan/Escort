
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Base class for an escort managed repository",
  "AUTHOR" => "Torsten Raudssus <torsten\@raudss.us>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Escort",
  "EXE_FILES" => [
    "bin/escort"
  ],
  "LICENSE" => "perl",
  "NAME" => "Escort",
  "PREREQ_PM" => {
    "CPAN::Documentation::HTML" => "0.002",
    "CPAN::Repository" => "0.008",
    "Class::Load" => "0.20",
    "DateTime" => "1.03",
    "Dist::Surveyor" => "0.009",
    "File::Temp" => "0.2301",
    "HTTP::Tiny" => "0.029",
    "JSON" => "2.57",
    "LWP::Simple" => "6.00",
    "Moo" => "1.001000",
    "MooX" => "0.101",
    "MooX::Cmd" => "0.003",
    "MooX::Options" => "3.80",
    "Path::Class" => "0.32",
    "Plack" => "1.0024",
    "Starman" => "0.3011",
    "URI" => "1.60",
    "Web::Simple" => "0.020"
  },
  "TEST_REQUIRES" => {
    "Test::LoadAllModules" => "0.021",
    "Test::More" => "0.96"
  },
  "VERSION" => "0.002",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



