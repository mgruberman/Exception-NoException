#!perl
# $Id: /src/Exception-NoException/trunk/t/05critic.t 301 2006-10-07T16:28:46.718930Z josh  $
use Test::More;

if ( not $ENV{AUTHOR_TESTS} ) {
    plan skip_all => 'Skipping author tests';
}
else {
    require Test::Perl::Critic;
    Test::Perl::Critic->import( -severity => 3 );
    all_critic_ok();
}
