INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::Loader::Test);

class MyFakeTest is Rosella::Test::Testcase {
    method test_one() {}
    method test_two() {}
    method test_three() {}
}

class MyFakeSubTest is MyFakeTest {
    method test_one() {}
    method test_four() {}
}

class Test::Loader::Test is Rosella::Test::Testcase {
    method test_BUILD() {
        my $loader := Rosella::build(Rosella::Test::Loader, MyFakeTest);
        Assert::not_null($loader);
    }

    method test_load_tests() {
        my $loader := Rosella::build(Rosella::Test::Loader, MyFakeTest);
        my @tests := $loader.load_tests();
        Assert::equal(+@tests, 3);
    }

    method test_load_tests_subclass() {
        my $loader := Rosella::build(Rosella::Test::Loader, MyFakeSubTest);
        my @tests := $loader.load_tests();
        Assert::equal(+@tests, 4);
    }

    method test_get_test_methods() {
        my $loader := Rosella::build(Rosella::Test::Loader, MyFakeTest);
        my @tests := $loader.get_test_methods();
        Assert::equal(+@tests, 3);
    }

    method test_get_test_subclass() {
        my $loader := Rosella::build(Rosella::Test::Loader, MyFakeSubTest);
        my @tests := $loader.get_test_methods();
        Assert::equal(+@tests, 4);
    }

    method test_is_test_method() {
        my $loader := Rosella::build(Rosella::Test::Loader, MyFakeTest);
        Assert::is_true($loader.is_test_method("test_a"));
        Assert::is_false($loader.is_test_method("not_a_test"));
    }

    method test_is_test_method_alt_prefix() {
        my $loader := Rosella::build(Rosella::Test::Loader, MyFakeTest, :test_prefix("foo"));
        Assert::is_true($loader.is_test_method("fooTest"));
        Assert::is_false($loader.is_test_method("test_a"));
    }
}
