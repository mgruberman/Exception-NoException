## no critic (RcsKeywords,PodSections,PodAtEnd,UseWarnings)
package Exception::NoException;

use strict;

=head1 NAME

Exception::NoException - An exception object that's always false.

=head1 VERSION

Version 0.02

=cut

use vars '$VERSION';    ## no critic InterpolationOfMetachars
$VERSION = '0.02';

=head1 SYNOPSIS

Throw non-exception exceptions when you're using die() for flow
control and want $@ to appear to be false/empty.

  use Exception::NoException;
  eval {
    die Exception::NoException->new;
  };
  die $@ if $@;

This is most useful when using L<File::Find>C<::find> or similar
callback-using functions. You can wrap your call in an eval and stop
execution by throwing a non-error. When you look at C<$@> to see if
there's a problem, you won't find any.

=head1 METHODS

=over

=item C<Exception::NoException->new>

This method takes no arguments and returns a new
Exception::NoException object. This object overloads all available
operators. Whenever an overloaded function is used a false value is
returned and $@ is cleared.

=cut

use overload;
use overload(
    map { $_ => \&_false }
        map { split ' ' }    ## no critic EmptyQuotes
        values %overload::ops    ## no critic PackageVars
);

sub new {
    my $class = shift;
    my $obj;
    return bless \$obj, $class;
}

=item C<Exception::NoException->AUTOLOAD>

=item C<$obj->AUTOLOAD>

This uses autoload to always return &_false when called for any method.

=cut

{
    no warnings 'once';    ## no critic PunctuationVars
    *AUTOLOAD = \&_false;
}

=item C<$obj->_false>

Clears $@ and returns a false value.

=cut

sub _false {
    eval { };

    return wantarray
        ? ()
        : !!0;
}

=back

=head1 EXAMPLES

=over

=item L<File::Find>C<::find>

 use File::Find;
 use Exception::NoException;

 eval {
     find( sub {
         if ( $File::Find::name =~ /something/ ) {
             # do something with the file
             die Exception::NoException->new;
         }
     } );
 };
 die $@ if $@;

=back

=head1 CAVEATS

ref() and blessed() will still return true for these objects. I'm
considering using the 0 and/or \0 packages for this.

=head1 AUTHOR

Joshua ben Jore, C<< <jjore at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-exception-noexception at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Exception-NoException>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Exception::NoException

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Exception-NoException>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Exception-NoException>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Exception-NoException>

=item * Search CPAN

L<http://search.cpan.org/dist/Exception-NoException>

=back

=head1 ACKNOWLEDGEMENTS

Yitzchak Scott-Thoennes came up with a problem where an exception
object used an eval block during the C<bool> conversion from
L<overload>. The following snippet caused him hours of grief and it
inspired me to come up with an object where that effect was actually
desired. It also happens to solve a common problem with loops that use
callbacks.

 # Yitzchak's problem:
 eval {
     die SomeObject->new;
 };
 if ( $@ ) {
     # now $@ is empty.
 }
 package SomeObject;
 use overload bool => sub { eval { } };
 sub new { bless [], shift }

To solve Yitzchak's problem, copy $@ ala C<my $e = $@> before
examining it.

=head1 COPYRIGHT & LICENSE

Copyright 2006 Joshua ben Jore, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

## no critic EndWithOne

# Quote blatantly copied from Michael Poe's errantstory.com
'The Adventures Of Kung-Fu Jesus and His Amazing Giant Robot';
