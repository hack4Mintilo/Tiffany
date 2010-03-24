package Tempa::TT;
use strict;
use warnings;
use parent qw/Tempa::Base/;
use Template;

sub render {
    my ($self, @args) = @_;
    my $tt = Template->new(@{$self->{args}});
    $tt->process( $self->{path}, @args, \my $out )
      or do { $self->errstr( $tt->error ); return };
    $out;
}

1;