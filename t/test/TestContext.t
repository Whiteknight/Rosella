INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::TestContext::Test);

class Test::TestContext::Test {
    method test_BUILD() {
        my $testcontext := Rosella::construct(Rosella::Test::TestContext);
        $!assert.instance_of($testcontext, Rosella::Test::TestContext);
    }

    method test_BUILD_data() {
        my $testcontext := Rosella::construct(Rosella::Test::TestContext, :foo("Foo"), :bar("Bar"));
        $!assert.instance_of($testcontext, Rosella::Test::TestContext);
    }

    method test_get_data_null() {
        my $testcontext := Rosella::construct(Rosella::Test::TestContext);
        my $data := $testcontext.get_data("Foo");
        $!assert.is_null($data);
    }

    method test_get_data_constructor_args() {
        my $testcontext := Rosella::construct(Rosella::Test::TestContext, :Foo("Bar"));
        my $data := $testcontext.get_data("Foo");
        $!assert.equal($data, "Bar");
    }

    method test_set_data() {
        my $testcontext := Rosella::construct(Rosella::Test::TestContext);
        $testcontext.set_data("Foo", "Baz");
        my $data := $testcontext.get_data("Foo");
        $!assert.equal($data, "Baz");
    }

    method test_set_data_overwrite() {
        my $testcontext := Rosella::construct(Rosella::Test::TestContext, :Foo("Bar"));
        $testcontext.set_data("Foo", "Baz");
        my $data := $testcontext.get_data("Foo");
        $!assert.equal($data, "Baz");
    }
}
