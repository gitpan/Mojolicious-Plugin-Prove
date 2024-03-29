package Mojolicious::Plugin::Prove;

# ABSTRACT: run test scripts via browser

use Mojo::Base 'Mojolicious::Plugin::Prove::Base';

use File::Basename;
use File::Spec;

our $VERSION = '0.01';

sub register {
    my ($self, $app, $conf) = @_;
    
    # we need configuration hash that looks like
    # {
    #    prefix => 'prove',
    #    tests  => {
    #        name  => '/testdir',
    #        name2 => '/other/dir',
    #    }
    # }
    
    # Add template path
    $self->add_template_path($app->renderer, __PACKAGE__);
    
    # Add ṕublic path
    my $static_path = File::Spec->catdir( dirname(__FILE__), 'Prove', 'public' );
    push @{ $app->static->paths }, $static_path;
    
    $app->plugin( 'PPI' );
    
    # Routes
    my $r      = $conf->{route}  // $app->routes;
    my $prefix = $conf->{prefix} // 'prove';
    
    $self->prefix($prefix);
    $self->conf( $conf->{tests} || {} );
    
    
    {
        my $r = $r->route("/$prefix")->to(
            'controller#',
            namespace => 'Mojolicious::Plugin::Prove',
            plugin    => $self,
            prefix    => $self->prefix,
            conf      => $self->conf,
        );
        
        $r->get('/')->to( '#list' );
        $r->get('/test/*name/*file/run')->to( '#run' );
        $r->get('/test/*name/*file')->to( '#file' );
        $r->get('/test/*name')->to( '#list' );
    }
}

1;


__END__
=pod

=head1 NAME

Mojolicious::Plugin::Prove - run test scripts via browser

=head1 VERSION

version 0.01

=head1 SYNOPSIS

  # Mojolicious::Lite
  plugin 'Prove' => {
      tests => {
          my_tests => '/path/to/test/files.t',
      },
  };

  # Mojolicious
  $app->plugin( 'Prove' => {
      tests => {
          my_tests => '/path/to/test/files.t',
      },
  });

  # Access
  http://localhost:3000/prove
  
  # Prefix
  plugin 'Prove' => {
      tests => {
          my_tests => '/path/to/test/files.t',
      },
      prefix => 'tests',
  };

=head1 AUTHOR

Renee Baecker <module@renee-baecker.de>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Renee Baecker.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

