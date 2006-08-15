use Test::More tests => 3;
use Exception::NoException;

my $did_not_die = '';
eval {
    die Exception::NoException->new;
    $did_not_die = 1;
};
my $e = $@;
is( $@, '', "No exception" );
is( $e, '', "No exception" );
is( $did_not_die, '', 'Died' );
