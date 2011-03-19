INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/proxy.pbc");
}

class FooController is Rosella::Proxy::Controller {
    method get_keyed($proxy, $val_type, $key_type, $key)
    {
        return 7;
    }

    method set_keyed($proxy, $val_type, $key_type, $key, $value)
    {
        $value($key);
    }

    method op_keyed($proxy, $op_type, $key_type, $key)
    {
        return 0;
    }
}

class My::Foo {
    method bar($arg) { return "real $arg"; }
}

Rosella::Test::test(Proxy::Builder::PMCKeyedHash::Test);
class Proxy::Builder::PMCKeyedHash::Test {
    method test_get_keyed_intercept() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::PMCKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        my $result := $p[1];
        Assert::equal($result, 7);
    }

    method test_set_keyed_intercept() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::PMCKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        my $value := 0;
        $p[1] := sub($i) { $value := pir::set__IP($i); };
        Assert::equal($value, 1);
    }

    method test_delete_keyed_intercept() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::PMCKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        $!context.unimplemented("test_delete_keyed_intercept");
    }

    method test_defined_keyed_intercept() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::PMCKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        $!context.unimplemented("test_defined_keyed_intercept");
    }

    method test_exists_keyed_intercept() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::PMCKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        $!context.unimplemented("test_exists_keyed_intercept");
    }
}
