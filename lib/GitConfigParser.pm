package GitConfigParser;
use strict;
use warnings;
our $VERSION = '0.01';

use base qw/Class::Accessor::Fast/;

__PACKAGE__->mk_accessors(qw/file data/);

use File::HomeDir;
use Path::Class ();
use Data::Recursive::Encode;

sub new {
    my ($class,$file) = @_;

    unless( $file ) {
        $file = Path::Class::file(File::HomeDir->my_home,'.gitconfig');
    }

    my $self = bless {
        file => Path::Class::file($file), 
    },$class;

    $self->_init();

    return $self;
}

sub _init {
    my $self = shift;

    # load file
    my $fh = $self->file->openr or die $@;

    my $data = {};
    my $title;
    while( my $row = <$fh> ) {
        chomp $row;

        if( $row =~ /^\[(.+)\]$/ ) {
            $title = $1;
        }
        elsif( $row =~ /^[\s\t]+(.*?)\s*=\s*(.+)$/ ) {
            $data->{$title}->{$1} = $2;
        }
    }

    $fh->close();

    $self->data(Data::Recursive::Encode->decode_utf8($data));
}

sub get {
    my ($self,$key) = @_;

    if( $key ) {
        $self->data->{$key};
    }
    else {
        $self->data;
    }
}

1;
__END__

=head1 NAME

GitConfigParser -

=head1 SYNOPSIS

  use GitConfigParser;

=head1 DESCRIPTION

GitConfigParser is

=head1 AUTHOR

Hiroyuki Yamanaka E<lt>hiroyukimm at gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
