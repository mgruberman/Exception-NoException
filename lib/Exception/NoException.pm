## no critic (UseWarnings,PodSections)
# $Id: /Exception-NoException/trunk/lib/Exception/NoException.pm 187 2006-10-07T16:27:35.885450Z josh  $
package Exception::NoException;

use strict;

use vars '$VERSION';    ## no critic InterpolationOfMetachars
$VERSION = '0.05';

require Exception::NoException::_obj;

sub new {
    my $class = shift @_;
    $class .= '::_obj';
    my $obj;

    return bless \$obj, $class;
}

sub get_no_exception {
    my $class = shift @_;
    $class .= '::_obj';

    return $class->can('_no_exception');
}

## no critic EndWithOne
# Quote blatantly copied from Michael Poe's errantstory.com
'The Adventures Of Kung-Fu Jesus and His Amazing Giant Robot';

__END__

=head1 NAME

Exception::NoException - An exception object that's always false.

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

=item C<< Exception::NoException->new >>

This method takes no arguments and returns a new C<<
Exception::NoException::_obj >> object. This object overloads all
available operators. Whenever an overloaded function is used a false
value is returned and $@ is cleared.

=item C<< Exception::NoException->get_no_exception >>

XXX Docs go here.

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

=head1 SUBCLASSING

XXX Docs go here.

=head1 AUTHOR

Joshua ben Jore, C<< <jjore at cpan.org> >>

=head1 BUGS

=over

=item *

ref() and blessed() will still return true for these objects. I'm
considering using the 0 and/or \0 packages for this.

=back

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
