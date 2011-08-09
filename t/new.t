use strict;
use warnings;
use Test::More;
use FindBin;
use Encode;
use GitConfigParser;

subtest 'parser' => sub {
    my $parser = GitConfigParser->new( "$FindBin::Bin/gitconfig" );

    ok $parser;
    ok Encode::is_utf8($parser->data->{alias}->{ci});

    done_testing();
};

done_testing();


