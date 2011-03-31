INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::TestContext::Test);

class Test::TestContext::Test {
    method test_BUILD() {
        my $testcontext := Rosella::build(Rosella::Test::TestContext);
        Assert::instance_of($testcontext, Rosella::Test::TestContext);
    }

    method test_BUILD_data() {
        my $testcontext := Rosella::build(Rosella::Test::TestContext, :foo("Foo"), :bar("Bar"));
        Assert::instance_of($testcontext, Rosella::Test::TestContext);
    }

    method test_get_data_null() {
        my $testcontext := Rosella::build(Rosella::Test::TestContext);
        my $data := $testcontext.get_data("Foo");
        Assert::is_null($data);
    }

    method test_get_data_constructor_args() {
        my $testcontext := Rosella::build(Rosella::Test::TestContext, :Foo("Bar"));
        my $data := $testcontext.get_data("Foo");
        Assert::equal($data, "Bar");
    }

    method test_set_data() {
        my $testcontext := Rosella::build(Rosella::Test::TestContext);
        $testcontext.set_data("Foo", "Baz");
        my $data := $testcontext.get_data("Foo");
        Assert::equal($data, "Baz");
    }

    method test_set_data_overwrite() {
        my $testcontext := Rosella::build(Rosella::Test::TestContext, :Foo("Bar"));
        $testcontext.set_data("Foo", "Baz");
        my $data := $testcontext.get_data("Foo");
        Assert::equal($data, "Baz");
    }
}
