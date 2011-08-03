INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "proxy");
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

Rosella::Test::test(Proxy::Builder::StringKeyedHash::Test);
class Proxy::Builder::StringKeyedHash::Test {
    method test_get_keyed_intercept() {
        my $factory := Rosella::construct(Rosella::Proxy::Factory, My::Foo, [
            Rosella::construct(Rosella::Proxy::Builder::StringKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        $!status.unimplemented("test_get_keyed_intercept");
    }

    method test_set_keyed_intercept() {
        my $factory := Rosella::construct(Rosella::Proxy::Factory, My::Foo, [
            Rosella::construct(Rosella::Proxy::Builder::StringKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        $!status.unimplemented("test_set_keyed_intercept");
    }

    method test_delete_keyed_intercept() {
        my $factory := Rosella::construct(Rosella::Proxy::Factory, My::Foo, [
            Rosella::construct(Rosella::Proxy::Builder::StringKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        $!status.unimplemented("test_delete_keyed_intercept");
    }

    method test_defined_keyed_intercept() {
        my $factory := Rosella::construct(Rosella::Proxy::Factory, My::Foo, [
            Rosella::construct(Rosella::Proxy::Builder::StringKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        $!status.unimplemented("test_defined_keyed_intercept");
    }

    method test_exists_keyed_intercept() {
        my $factory := Rosella::construct(Rosella::Proxy::Factory, My::Foo, [
            Rosella::construct(Rosella::Proxy::Builder::StringKeyedHash)
        ]);

        my $p := $factory.create(FooController.new());
        $!status.unimplemented("test_exists_keyed_intercept");
    }
}
