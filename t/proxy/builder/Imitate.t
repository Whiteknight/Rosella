INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/proxy.pbc");
}

Rosella::Test::test(Proxy::Builder::Imitate::Test);

class FooController is Rosella::Proxy::Controller {
    method isa_pmc($proxy, $type) {
        if (pir::does__IPS($type, "array")) {
            return 1;
        }
        return 0;
    }

    method isa($proxy, $name) {
        if ($name eq "IS_String") {
            return 1;
        }
        return 0;
    }

    method does($proxy, $role) {
        if ($role eq "DOES_String") {
            return 1;
        }
        return 0;
    }
}

class My::Foo {
    method bar($arg) { return "real $arg"; }
}

class Proxy::Builder::Imitate::Test {
    method test_BUILD() {
        my $imitate := Rosella::build(Rosella::Proxy::Builder::Imitate);
        Assert::instance_of($imitate, Rosella::Proxy::Builder::Imitate);
    }

    # TODO: Test the default behavior of Rosella::Proxy::Controller also.
    #       The default controller should fall back to sane behavior.

    method Imitate() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::Imitate)
        ]);
        my $imitator := $factory.create(FooController.new());
        Assert::not_null($imitator);
    }

    method isa() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::Imitate)
        ]);
        my $imitator := $factory.create(FooController.new());
        my $is_ok := pir::isa__IPS($imitator, "IS_String");
        Assert::equal($is_ok, 1);

        my $is_nok := pir::isa__IPS($imitator, "IS_NOT_String");
        Assert::equal($is_nok, 0);
    }

    method isa_pmc() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::Imitate)
        ]);
        my $imitator := $factory.create(FooController.new());
        my $is_ok := pir::isa__IPP($imitator, []);
        Assert::equal($is_ok, 1);

        my $is_nok := pir::isa__IPP($imitator, {});
        Assert::equal($is_nok, 0);
    }

    method does() {
        my $factory := Rosella::build(Rosella::Proxy::Factory, My::Foo, [
            Rosella::build(Rosella::Proxy::Builder::Imitate)
        ]);
        my $imitator := $factory.create(FooController.new());
        my $does_ok := pir::does__IPS($imitator, "DOES_String");
        Assert::equal($does_ok, 1);

        my $does_nok := pir::does__IPS($imitator, "DOES_NOT_String");
        Assert::equal($does_nok, 0);
    }
}
