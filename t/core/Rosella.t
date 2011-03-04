INIT {
    pir::load_bytecode("rosella/core.pbc");
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(RosellaTest);

class My::Test::Class {
    method sum($a, $b) {
        return $a + $b;
    }
}

class RosellaTest is Rosella::Test::Testcase {
    method test_call_parrot_method() {
        my $item := My::Test::Class.new();
        my $sum := Rosella::call_parrot_method($item, "sum", [4, 5], {});
        Assert::equal($sum, 9);
    }

    method test_build() {
    }

    method test_get_type_name() {
    }

    method test_get_type_class() {
    }
}
