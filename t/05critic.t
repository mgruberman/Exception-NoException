#!perl
# $Id: /Exception-NoException/trunk/t/05critic.t 56 2006-08-16T22:53:12.587740Z josh  $
use Test::More;

if ( not $ENV{AUTHOR_TESTS} ) {
    plan skip_all => 'Skipping author tests';
}
else {
    require Test::Perl::Critic;
    Test::Perl::Critic->import( -severity => 1 );
    all_critic_ok();
}
