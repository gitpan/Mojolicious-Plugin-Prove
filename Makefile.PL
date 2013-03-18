
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "run test scripts via browser",
  "AUTHOR" => "Renee Baecker <module\@renee-baecker.de>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Mojolicious-Plugin-Prove",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "Mojolicious::Plugin::Prove",
  "PREREQ_PM" => {
    "App::Prove" => 0,
    "Capture::Tiny" => 0,
    "Cwd" => 0,
    "File::Basename" => 0,
    "File::Find::Rule" => 0,
    "File::Spec" => 0,
    "Mojolicious" => "3.51"
  },
  "VERSION" => "0.01",
  "test" => {
    "TESTS" => ""
  }
);


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



