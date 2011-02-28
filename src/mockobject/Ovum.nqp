# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

# The cuckoo's egg takes the place of a real object in the system.
class Cuculus::Canorus::Ovum;

has &!CUCULUS_BEHAVIOR;
has $!CUCULUS_CANORUS;

module Cuculus::Canorus::Ovum::_;

# This method is called by Cuculus::Ovum objects as a vtable override for 'find_method'.
# (It is withheld from that namespace solely to keep the namespace clean.) Thus,
# this is NOT REALLY A METHOD on this class - it is a method on the Cuculus::Egg
# class, and C< self > reflects that, as do the attributes.
our method VTABLE_find_method($name) {
    has &!CUCULUS_BEHAVIOR;
    has $!CUCULUS_CANORUS;

    my &method := -> *@pos, *%named {
        my $self := @pos[0];
        my $callsig := CallSignature.new(
            :method($name),
            :named(%named),
            :object($self),
            :positional(@pos),
        );

        my $cuckoo := pir::getattribute__PPS($self, '$!CUCULUS_CANORUS');

        if pir::isnull($cuckoo) {
            # If it wasn't set, then either we're inside the init :vtable method, or
            # we're boned. Pop someting from the init stack and hope for the best.
            Cuculus::Canorus::Ovum::_::pop_inits($self);
            $cuckoo := pir::getattribute__PPS($self, '$!CUCULUS_CANORUS');
        }

        my $behavior := pir::getattribute__PPS($self, '&!CUCULUS_BEHAVIOR');
        # TODO: Expand this.
        Parrot::call_method($cuckoo, $behavior, $callsig);
        #&behavior($cuckoo, $callsig);
    };

    my &closure := pir::newclosure__PP(&method);
    pir::assign__vPS(&closure, $name);
    &closure;
}

our method pop_inits() {
    has &!CUCULUS_BEHAVIOR;
    has $!CUCULUS_CANORUS;

    pir::die("Trying to pop inits, but stack is empty")
        unless our @_Init_stack;

    &!CUCULUS_BEHAVIOR := @_Init_stack.pop;
    $!CUCULUS_CANORUS := @_Init_stack.pop;
    self;
}

sub push_inits( :$behavior!, :$cuckoo! ) {
    our @_Init_stack.push($cuckoo);
    @_Init_stack.push($behavior);
}
