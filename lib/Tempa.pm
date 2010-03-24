package Tempa;
use strict;
use warnings;
use 5.00800;
our $VERSION = '0.01';
use MRO::Compat;
use Carp;

sub new {
    my ($class, $path, @args) = @_;
    if ($path =~ /\.([^.]+)$/) {
        if (my $klass = $class->_lookup($1)) {
            return $klass->new($path, @args);
        } else {
            Carp::croak("Cannot detect file type from file name: $path");
        }
    } else {
        Carp::croak("Cannot detect ext. from file name: $path");
    }
}

sub is_registered {
    my ($class, $ext) = @_;
    $class->_lookup($ext);
}

# hmm... I want to make this method as public.
sub _lookup {
    my ($class, $ext) = @_;
    $ext = lc $ext;
    no strict 'refs';
    for my $klass (@{mro::get_linear_isa($class)}) {
        my $target = ${"$klass\::_map"}->{$ext};
        return $target if $target;
    }
    return undef;
}

sub register {
    my ($class, $ext, $klass) = @_;
    no strict 'refs';
    ${"$class\::_map"}->{lc $ext} = $klass;
}

1;
__END__

=encoding utf8

=head1 NAME

Tempa -

=head1 SYNOPSIS

  use Tempa;

=head1 DESCRIPTION

Tempa is

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
