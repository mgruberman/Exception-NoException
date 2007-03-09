## no critic (UseWarnings)
# $Id: /src/Exception-NoException/trunk/Makefile.PL 168 2006-08-16T21:29:24.508066Z josh  $
use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Exception::NoException',
    AUTHOR        => 'Joshua ben Jore <jjore@cpan.org>',
    VERSION_FROM  => 'lib/Exception/NoException.pm',
    ABSTRACT_FROM => 'lib/Exception/NoException.pm',
    PL_FILES      => {},
    PREREQ_PM     => { 'Test::More' => 0, 'UNIVERSAL::ref' => 0 },
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Exception-NoException-*' },
);
