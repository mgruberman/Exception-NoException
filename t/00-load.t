#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Exception::NoException' );
}

diag( "Testing Exception::NoException $Exception::NoException::VERSION, Perl $], $^X" );
