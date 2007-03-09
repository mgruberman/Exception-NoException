## no critic Warnings
# $Id: /src/Exception-NoException/trunk/lib/Exception/NoException/_obj.pm 166 2006-08-16T21:22:18.048528Z josh  $

package Exception::NoException::_obj;
use strict;
use vars '$VERSION';    ## no critic Interpolation
$VERSION = '0.01';

# Provide ->get_no_exception
use Exception::NoException;

# Pretend to be an empty scalar.
use UNIVERSAL::ref;
sub ref {''}

#use UNIVERSAL::ref;
#sub ref {''}

# Compile it and load %overload::ops
use overload ();

# Overload all operations
my %h =
    map { $_ => Exception::NoException->get_no_exception }
    map { split ' ' }    ## no critic EmptyQuotes
    values %overload::ops    ## no critic PackageVars
    ;

#use Data::Dumper;
#print Dumper( \%h );
overload->import(%h);

*AUTOLOAD = Exception::NoException->get_no_exception;

sub _no_exception {

    # Clear $@
    eval { };

    # Return false
    return wantarray
        ? ()
        : !!0;
}

## no critic EndWithOne
# Quote blatantly copied form Michael Poe's errantstory.com
q[ Hey, what does this switch labeled 'Pulsating Ejector' do?

   I don't know... I've always been too afraid to find out ];

__END__

=head1 NAME

Exception::NoException::_obj - Implementation for Exception::NoException object

=head1 DESCRIPTION

This object overloads all operations with C<<
Exception::NoException->get_no_exception >>. It also AUTOLOADs all
methods with the same.

=head1 METHODS

=over

=item C<< $obj->_no_exception >>

This is the default "false"/"no exception" function.

=item C<< $obj->AUTOLOAD >>

This object autoloads everything as calls to C<< ->no_exception >>.

=back

=head1 SEE ALSO

L<Exception::NoException>
