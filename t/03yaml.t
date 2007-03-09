#!perl
# $Id: /src/Exception-NoException/trunk/t/03yaml.t 168 2006-08-16T21:29:24.508066Z josh  $
use Test::More;

if ( not $ENV{AUTHOR_TESTS} ) {
    plan skip_all => 'Skipping author tests';
}
else {
    plan tests => 1;
    require YAML;
    YAML->import('LoadFile');

    ok( LoadFile("META.yml") );
}
