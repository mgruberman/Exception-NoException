#!perl
# $Id: /src/Exception-NoException/trunk/t/02pod-coverage.t 168 2006-08-16T21:29:24.508066Z josh  $
use Test::More;

if ( not $ENV{AUTHOR_TESTS} ) {
    plan skip_all => 'Skipping author tests';
}
else {
    eval "use Test::Pod::Coverage 1.04";
    die $@ if $@;

    all_pod_coverage_ok();
}
