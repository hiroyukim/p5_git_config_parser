use inc::Module::Install;
name 'GitConfigParser';
all_from 'lib/GitConfigParser.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
