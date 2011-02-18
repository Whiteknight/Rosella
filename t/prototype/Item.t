INIT {
    pir::load_bytecode("rosella/core.pbc");
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/prototype.pbc");
}

PrototypeItemTest.suite.run();

class PrototypeItemTest is Rosella::Testcase {
    method test_BUILD() {
        my $pmc := Rosella::build(Rosella::Prototype::Item, 1);
    }

    method test_create() {
        my $proto := "This is a string";
        my $item := Rosella::build(Rosella::Prototype::Item, $proto);
        my $other := $item.create();
        Assert::equal($proto, $other);
        Assert::not_same($proto, $other);
    }

    method test_construct() {
        my $proto := "This is a string";
        my &const := sub($self) { $self.replace("This", "That"); };
        my $item := Rosella::build(Rosella::Prototype::Item, $proto, &const);
        my $other := $item.create();
        $item.construct($other);
        Assert::equal($other, "That is a string");
        Assert::not_equal($other, $proto);
    }

    method test_construct_args() {
        my $proto := "This is a string";
        my &const := sub($self, $a, $b) { $self.replace($a, $b); };
        my $item := Rosella::build(Rosella::Prototype::Item, $proto, &const);
        my $other := $item.create();
        $item.construct($other, ["string", "test"]);
        Assert::equal($other, "This is a test");
        Assert::not_equal($other, $proto);
    }
}

