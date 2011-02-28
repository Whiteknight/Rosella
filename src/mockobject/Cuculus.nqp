# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Cuculus::Canorus;

has @!antiphons;
has @!call_log;
has $!class;
has %!passthrough_antiphons;
has $!verifier;

our method add_antiphon($callsig) {
    my $antiphon := new_antiphon($callsig);
    @!antiphons.push($antiphon);

    # Return the antiphon so we can chain .will(...) calls.
    $antiphon;
}

our method antiphons() { @!antiphons; }
our method call_log() { @!call_log; }

our method class(*@value) {
    if @value {
        pir::die( 'Cannot reset $!class attribute: already points to ' ~ "'$!class'" )
            if pir::defined(pir::getattribute__PPS(self, '$!class'));
        $!class := P6metaclass.get_parrotclass(@value.shift);
    }

    $!class;
}

sub get_behavior($egg) {
    unless isa($egg, 'Cuculus::Canorus::Ovum') {
        _dumper($egg);
        pir::die( "Must be called with a Cuckoo's egg." );
    }

    pir::getattribute__PPS($egg, '&!CUCULUS_BEHAVIOR');
}

sub get_cuckoo($egg) {
    unless isa($egg, 'Cuculus::Canorus::Ovum') {
        _dumper($egg);
        pir::die( "Must be called with a Cuckoo's egg." );
    }

    pir::getattribute__PPS($egg, '$!CUCULUS_CANORUS');
}

sub get_passthrough_antiphons($parent) {
    # See TT#1497 for why this bogosity is needed.
    my $pre_class := pir::new__PS( 'Class' );
    $pre_class.add_parent( pir::get_class__PS( 'P6protoobject' ) );
    #~ $pre_class.add_parent( P6metaclass.get_parrotclass: $parent );
    $pre_class.add_parent( $parent );

    my %passthrough;

    for get_rootclass_methods() -> $method_name {
        # Make a callsig for the method
        my $callsig := CallSignature.new(:method($method_name));
        my $antiphon := new_antiphon($callsig);

        # TODO: If subject class overrides PROTOOVERRIDES, we'll miss it.
        if $method_name eq 'new' {
            $antiphon.will_do: Cuculus::Canorus::mock_new;
        }
        elsif $method_name eq '__dump' {
            $antiphon.will_do: P6object::__dump;
        }
        else {
            my &method := $pre_class.find_method($method_name);

            # NOTE: If the class being mocked it NOT a P6object class, but (for example)
            # one of the .pir classes in the runtime library, then it may not _have_ all
            # the methods provided by P6object. So check for null.
            $antiphon.will_do: &method
                    unless pir::isnull(&method);
        }

        %passthrough{$method_name} := $antiphon;
    }

    %passthrough;
}

sub get_rootclass_methods() {
    # TODO: Maybe P6object inherits from something, someday. Should this scan the MRO?
    unless our @_Rootclass_methods {
        my $root_class := P6metaclass.get_parrotclass('P6object');
        @_Rootclass_methods := $root_class.inspect('methods').keys;
        @_Rootclass_methods.sort;
    }

    @_Rootclass_methods;
}

our method init_egg( $egg, :$behavior = 'mock_execute' ) {
    pir::die( "Must be called with a Cuckoo's egg." )
        unless isa($egg, 'Cuculus::Canorus::Ovum');

    # This is null if we DIDN'T get called by an init :vtable. If we DID, then
    # this pop was already done in the method closure.
    if pir::isnull(pir::getattribute__PPS($egg, '$!CUCULUS_CANORUS')) {
        Cuculus::Canorus::Ovum::_::pop_inits($egg);
    }

    # Always (re)set the behavior, because new_egg starts all eggs in execute mode first.
    pir::setattribute__vPSP($egg, '&!CUCULUS_BEHAVIOR', $behavior);
    $egg;
}

our method _init_obj(*@pos, *%named) {
    @!antiphons := @!antiphons; # Null -> empty
    @!call_log := @!call_log; # Null -> empty

    self._init_args(|@pos, |%named);

    self;
}

our method install_vtable_overrides($proto_egg) {
    my %vtable_overrides;

    my @mro := pir::class__PP($proto_egg).inspect('all_parents');

    for @mro -> $parent {
        for $parent.inspect('vtable_overrides') {
            %vtable_overrides{$_.key} := $_.value
                unless %vtable_overrides.contains( $_.key );
        }
    }

    # Turn on find-method redirection for the proto-object
    my $proto_class := pir::class__PP($proto_egg);
    has_vtable('find_method', Cuculus::Canorus::Ovum::_::VTABLE_find_method,
        $proto_class);

    # Turn on find-method redirection for the mock class.
    has_vtable('find_method', Cuculus::Canorus::Ovum::_::VTABLE_find_method,
        :class($proto_egg));

    #~ has_vtable(:class($proto_egg), 'init', -> $self {
    #~ say("Init of ", pir::typeof__SP($self), " from ", pir::typeof__SP(self));
        #~ Opcode::setattribute($self, '$!CUCULUS_CANORUS', self);
        #~ Opcode::setattribute($self, '&!CUCULUS_BEHAVIOR', Cuculus::Canorus::mock_execute);

        #~ $self.'init :vtable'();
    #~ });

    #~ has_vtable(:class($proto_egg), 'init_pmc', -> $self, %args {
    #~ say("Initpmc of ", pir::typeof__SP($self), " from ", pir::typeof__SP(self));
        #~ Opcode::setattribute($self, '$!CUCULUS_CANORUS', self);
        #~ Opcode::setattribute($self, '&!CUCULUS_BEHAVIOR', Cuculus::Canorus::mock_execute);

        #~ $self.'init_pmc :vtable'(%args);
    #~ });

    #~ # Anything else just gets mocked out
    #~ for %vtable_overrides -> $vtable {
        #~ has_vtable(:class($proto_egg), $vtable.key, -> $self, *@args {
            #~ (pir::find_method__PPS(self, $vtable.key ~ ' :vtable'))(self, |@args);
        #~ });
    #~ }
}

our method mock_class($parent = 'P6object', :$named) {
    $parent := P6metaclass.get_parrotclass($parent);
    $named := $named || mock_class_name($parent);

    %!passthrough_antiphons := get_passthrough_antiphons($parent);

    # Do this before P6metaclass has a chance to create the new proto_egg - should catch
    # any init :vtable methods.

    Cuculus::Canorus::Ovum::_::push_inits(:cuckoo(self), :behavior('mock_execute'));

    my $proto_egg := P6metaclass.new_class: $named, :parent( 'Cuculus::Canorus::Ovum' );
    P6metaclass.add_parent: $proto_egg, $parent;

    $!class := P6metaclass.get_parrotclass($proto_egg);
    self.init_egg($proto_egg);

    self.install_vtable_overrides($proto_egg);
    $proto_egg;
}

sub mock_class_name($parent) {
    our $_Next_id := 0 unless $_Next_id;

    if ~ $parent eq 'P6object' {
        $parent := '<anonymous>';
    }

    my $name := ~ $parent ~ "::<mock{$_Next_id++;}>";
}

our method mock_execute($callsig) {
    @!call_log.push($callsig);	# record the call

    for @!antiphons -> $one {
        if $one.matches($callsig) {
            return $one.invoke($callsig);
        }
    }

    if %!passthrough_antiphons.contains($callsig.method) {
        return %!passthrough_antiphons{$callsig.method}.invoke($callsig);
    }

    $callsig.object; # returns "self"
}

our method mock_new(*@pos, *%named) {
    # Make a new cuckoo, mocking the same class.
    my $cuckoo := $!CUCULUS_CANORUS;
    my $new_cuckoo := $cuckoo.WHAT.new(:class($cuckoo.class), :passthrough($cuckoo.passthrough));

    # Pretend to be the standard P6object new method: Create a new egg linked to
    # the new cuckoo, and invoke the (mocked) _init_obj.
    my $new_egg := $new_cuckoo.new_egg;
    $new_egg._init_obj(|@pos, |%named);

    # NB: Init_obj probably returns $new_cuckoo, which isn't what we want the user to get.
    $new_egg;
}

sub new_antiphon($callsig) {
    my $antiphon := Cuculus::Antiphon.new(
        :sig_matcher(
            Cuculus::SigMatcher.new(
                :expecting($callsig))));
}

# NB: This isn't a 'new' operation - see `mock_new` for that - it's just creating a new
# tracking object, of which there might be many. (Remember that each instance of this class
# represents an object, but each egg represents a mode to use calling the object: config, execute,
# or verify, and the eggs are throw-away, so there may be lots of them pointing to the same object:
# calling($foo).a(1).will_do X, calling($foo).a(2).will_do Y, etc.

our method new_egg( :$behavior = 'mock_execute' ) {
    # Put the new egg in execute mode until any init:vtable finishes.
    Cuculus::Canorus::Ovum::_::push_inits(:cuckoo(self), :behavior('mock_execute'));
    my $new_egg := pir::new__PP($!class);
    self.init_egg($new_egg, $behavior);
}

our method passthrough($value?) {
    %!passthrough_antiphons := (pir::defined($value)
            ?? $value
            !! %!passthrough_antiphons);
}

our method verifier($value?) { pir::defined($value) ?? ($!verifier := $value) !! $!verifier; }

our method verify_calls($callsig) {
    $!verifier.sig_matcher:
        Cuculus::SigMatcher.new:
            :expecting($callsig);

    $!verifier.verify(self);
}
