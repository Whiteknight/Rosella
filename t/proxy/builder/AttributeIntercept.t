INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/proxy.pbc");
}

Rosella::Test::test(AttributeInterceptTest);

class FooController is Rosella::Proxy::Controller {
    has $!data;
    method get_attr_str($proxy, $name) {
        return "fake: $name - $!data";
    }

    method set_attr_str($proxy, $name, $value) {
        $!data := "fake $value";
    }
}

class My::Foo {
    has $!test;
}

class AttributeInterceptTest is Rosella::Test::Testcase {
    method test_get_attribute() {
        my $f := My::Foo.new();
        pir::setattribute__vPSP($f, '$!test', "hello");
        my $result := pir::getattribute__PPS($f, '$!test');
        Assert::equal($result, "hello");

        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::AttributeIntercept)
        ]);

        my $p := $factory.create(FooController.new());
        $result := pir::getattribute__PPS($p, '$!test');
        Assert::equal($result, 'fake: $!test - ');
    }

    method test_set_attribute() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::AttributeIntercept)
        ]);

        my $p := $factory.create(FooController.new());
        pir::setattribute__vPSP($p, '$!test', "hello");
        my $result := pir::getattribute__PPS($p, '$!test');
        Assert::equal($result, 'fake: $!test - fake hello');
    }
}
