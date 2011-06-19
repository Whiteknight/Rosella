INIT {
    pir::load_bytecode("rosella/test.pbc");
}

sub hash(*%h) { %h }

Rosella::Test::test(Test::SuiteFactory::Test);
class Test::SuiteFactory::Test {
    method test_BUILD() {
        my $v := Rosella::construct(Rosella::Test::SuiteFactory::Vector, "", "", {});
        $!assert.not_null($v);
        $!assert.instance_of($v, Rosella::Test::SuiteFactory::Vector);
    }

    # We have other tests for end-to-end vectorized tests. We only want to
    # target the get_test_methods method here
    method get_test_methods() {
        my $result := "";
        my $v := Rosella::construct(Rosella::Test::SuiteFactory::Vector,
            -> $obj, $data {},
            <foo bar baz fie>,
            {}
        );
        my %m := $v.get_test_methods();
        $!assert.does(%m, "hash");
    }

    method get_test_methods_array() {
        my $result := "";
        my $v := Rosella::construct(Rosella::Test::SuiteFactory::Vector,
            -> $obj, $data {},
            <foo bar baz fie>,
            {}
        );
        my %m := $v.get_test_methods();
        $!assert.equal(+%m, 4);
        $!assert.exists_keyed_str(%m, "test 1");
        $!assert.exists_keyed_str(%m, "test 2");
        $!assert.exists_keyed_str(%m, "test 3");
        $!assert.exists_keyed_str(%m, "test 4");
    }

    method get_test_methods_hash() {
        my $result := "";
        my $v := Rosella::construct(Rosella::Test::SuiteFactory::Vector,
            -> $obj, $data {},
            hash(:foo("foo"), :bar("bar"), :baz("baz"), :fie("fie")),
            {}
        );
        my %m := $v.get_test_methods();
        $!assert.equal(+%m, 4);
        $!assert.exists_keyed_str(%m, "foo");
        $!assert.exists_keyed_str(%m, "bar");
        $!assert.exists_keyed_str(%m, "baz");
        $!assert.exists_keyed_str(%m, "fie");
    }
}
