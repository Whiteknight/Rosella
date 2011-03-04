INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/proxy.pbc");
}

Rosella::Test::test(MethodInterceptTest);

class FooController is Rosella::Proxy::Controller {
    method find_method($proxy, $name) {
        return method($arg) { return "fake $arg"; }
    }
}

class My::Foo {
    method bar($arg) { return "real $arg"; }
}

class MethodInterceptTest is Rosella::Test::Testcase {
    method test_method_intercept() {
        my $f := My::Foo.new();
        my $result := $f.bar("test");
        Assert::equal($result, "real test");

        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::MethodIntercept)
        ]);

        my $p := $factory.get_proxy(FooController.new());
        $result := $p.bar("next test");
        Assert::equal($result, "fake next test");
    }
}
