#!perl
# $Id: /Exception-NoException/trunk/t/00signature.t 55 2006-08-16T21:29:24.508066Z josh  $
use Test::More;

if ( not $ENV{AUTHOR_TESTS} ) {
    plan skip_all => 'Skipping author tests';
}
else {
    plan tests => 1;
    require Test::Signature;
    Test::Signature->import;
    signature_ok();
}
