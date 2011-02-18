INIT {
    pir::load_bytecode("rosella/core.pbc");
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/container.pbc");
}

ContainerTest.suite.run();

class ContainerTest is Rosella::Testcase {
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
        Assert::true(pir::isa($item, "String"));
    }

    method test_resolve_create() {
        my $c := Rosella::build(Rosella::Container);
        my $item := $c.resolve_create("String");
        Assert::true(pir::isa($item, "String"));
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
                        Rosella::build(Rosella::ActionArg::Instance, "B", :position(0)),
                        Rosella::build(Rosella::ActionArg::Instance, "C", :position(1))
                    ]
                )
            ]
        ));
        my $bar := $c.resolve("String");
        Assert::equal($bar, "FooCarCaz", "not equal");
    }
}
