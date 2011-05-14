INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/prototype.pbc");
}

Rosella::Test::test(PrototypeItemTest);

class PrototypeItemTest {
    method test_BUILD() {
        my $pmc := Rosella::construct(Rosella::Prototype::Entry, 1);
    }

    method test_create() {
        my $proto := "This is a string";
        my $item := Rosella::construct(Rosella::Prototype::Entry, $proto);
        my $other := $item.create();
        $!assert.equal($proto, $other);
        $!assert.not_same($proto, $other);
    }

    method test_construct() {
        my $proto := "This is a string";
        my &const := sub($self) { $self.replace("This", "That"); };
        my $item := Rosella::construct(Rosella::Prototype::Entry, $proto, &const);
        my $other := $item.create();
        $item.construct($other);
        $!assert.equal($other, "That is a string");
        $!assert.not_equal($other, $proto);
    }

    method test_construct_args() {
        my $proto := "This is a string";
        my &const := sub($self, $a, $b) { $self.replace($a, $b); };
        my $item := Rosella::construct(Rosella::Prototype::Entry, $proto, &const);
        my $other := $item.create();
        $item.construct($other, ["string", "test"]);
        $!assert.equal($other, "This is a test");
        $!assert.not_equal($other, $proto);
    }
}

