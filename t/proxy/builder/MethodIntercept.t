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

class MethodInterceptTest {
    method test_method_intercept_controller() {
        my $f := My::Foo.new();
        my $result := $f.bar("test");
        $!assert.equal($result, "real test");

        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::MethodIntercept)
        ]);

        my $p := $factory.create(FooController.new());
        $result := $p.bar("next test");
        $!assert.equal($result, "fake next test");
    }

    # If we have a target and not a controller, the proxy passes through
    # find_method requests to the target
    method test_method_intercept_target() {
        my $f := My::Foo.new();

        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::MethodIntercept)
        ]);
        my $null := pir::null__P();
        my $p := $factory.create($null, $f);
        my $result := $p.bar("next test");
        $!assert.equal($result, "real next test");
    }
}
