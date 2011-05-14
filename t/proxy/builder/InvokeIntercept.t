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

class InvokeInterceptTest {
    method test_method_intercept() {
        my $factory := Rosella::construct(Rosella::Proxy::Factory, My::Foo, [
            Rosella::construct(Rosella::Proxy::Builder::InvokeIntercept)
        ]);

        my $p := $factory.create(FooController.new());
        my $result := $p("first");
        $!assert.equal($result, "invoked: first");
    }
}
