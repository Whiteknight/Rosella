INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/container.pbc");
}

Rosella::Test::test(ContainerTest);

class ContainerTest is Rosella::Test::Testcase {
    method test_BUILD() {
        my $container := Rosella::build(Rosella::Container);
    }

    method test_default_container() {
        my $c := Rosella::Container::default_container();
        Assert::instance_of($c, Rosella::Container, "no default");
    }

    method test_resolve_default_factory() {
        my $c := Rosella::build(Rosella::Container);
        # No previous registration, falls back to the default object factory
        my $item := $c.resolve("String");
        Assert::instance_of($item, "String");
    }

    method test_resolve_create() {
        my $c := Rosella::build(Rosella::Container);
        my $item := $c.resolve_create("String");
        Assert::instance_of($item, "String");
    }

    method test_register_factory_method() {
        my $c := Rosella::build(Rosella::Container);
        $c.register_factory_method("Foobar", sub () {
            return pir::box__PI(7);
        });
        my $i := $c.resolve("Foobar");
        Assert::equal($i, 7, "not equal");
    }

    method test_register_type_withactions() {
        my $c := Rosella::build(Rosella::Container);
        $c.register_type("String",
            :meth_inits([
                Rosella::build(Rosella::Action::Sub,
                    sub ($obj) {
                        pir::set__vPS($obj, "FooBarBaz");
                    }, []
                ),
                Rosella::build(Rosella::Action::Method,
                    "replace", [
                        Rosella::build(Rosella::Action::Argument::Instance, "B", :position(0)),
                        Rosella::build(Rosella::Action::Argument::Instance, "C", :position(1))
                    ]
                )
            ]
        ));
        my $bar := $c.resolve("String");
        Assert::equal($bar, "FooCarCaz", "not equal");
    }

    method test_auto_register() {
        my $c := Rosella::build(Rosella::Container, :auto_register(1));
        my $a := $c.resolve("String");
        my $b := $c.resolve("String");
        Assert::same($a, $b);
    }

    method test_auto_register_disabled() {
        my $c := Rosella::build(Rosella::Container, :auto_register(0));
        my $a := $c.resolve("String");
        my $b := $c.resolve("String");
        Assert::not_same($a, $b);
    }
}
