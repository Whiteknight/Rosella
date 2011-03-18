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

class AttributeInterceptTest {
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

    # Test that we can do intercepts on PMCProxy types. The logic is different
    # so we have to do extra tests
    method test_get_attribute_pmcproxy() {
        # We need the Passthough builder here to force other vtables to
        # redirect to the target
        my $f := Rosella::build(Rosella::Proxy::Factory, 'String', [
            Rosella::build(Rosella::Proxy::Builder::Passthrough),
            Rosella::build(Rosella::Proxy::Builder::AttributeIntercept)
        ]);
        my $null := pir::null__P();
        my $target := pir::box__PS("Hello world!");
        my $p := $f.create($null, $target);
        Assert::equal($p, "Hello world!");
        $p.replace("world", "rosella");
        Assert::equal($p, "Hello rosella!");
    }

    method test_set_attribute_pmcproxy() {
        my $f := Rosella::build(Rosella::Proxy::Factory, 'Exception', [
            Rosella::build(Rosella::Proxy::Builder::AttributeIntercept)
        ]);
        my $null := pir::null__P();
        my $target := pir::new__PS("Exception");
        pir::setattribute__vPSP($target, "payload", pir::box__PS("I'm an exception"));
        my $p := $f.create($null, $target);
        Assert::equal(pir::getattribute__PPS($p, "payload"), "I'm an exception");
        pir::setattribute__vPSP($target, "payload", pir::box__PS("Now I'm a proxy"));
        Assert::equal(pir::getattribute__PPS($p, "payload"), "Now I'm a proxy");
    }
}
