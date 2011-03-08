INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/proxy.pbc");
}

Rosella::Test::test(InvokeInterceptTest);

class FooController is Rosella::Proxy::Controller {
    method invoke($proxy, @pos, %named)
    {
        return "invoked: " ~ @pos[0];
    }
}

class My::Foo { }

class InvokeInterceptTest is Rosella::Test::Testcase {
    method test_method_intercept() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::InvokeIntercept)
        ]);

        my $p := $factory.create(FooController.new());
        my $result := $p("first");
        Assert::equal($result, "invoked: first");
    }
}
