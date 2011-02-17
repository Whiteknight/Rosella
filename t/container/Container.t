INIT {
    pir::load_bytecode("parrot_test_xunit.pbc");
    pir::load_bytecode("parrot_container.pbc");
}

ContainerTest.suite.run();

class ContainerTest is ParrotTest::Testcase {
    method test_BUILD() {
        my $container := ParrotContainer::build(ParrotContainer::Container);
    }

    method test_default_container() {
        my $c := ParrotContainer::Container::default_container();
        Assert::instance_of($c, ParrotContainer::Container, "no default");
    }

    method test_register_factory_method() {
        my $c := ParrotContainer::build(ParrotContainer::Container);
        $c.register_factory_method("Foobar", sub () {
            return pir::box__PI(7);
        });
        my $i := $c.resolve("Foobar");
        Assert::equal($i, 7, "not equal");
    }

    method test_register_type_withactions() {
        my $c := ParrotContainer::build(ParrotContainer::Container);
        $c.register_type("String",
            :meth_inits([
                ParrotContainer::build(ParrotContainer::Action::Sub,
                    sub ($obj) {
                        pir::set__vPS($obj, "FooBarBaz");
                    }, []
                ),
                ParrotContainer::build(ParrotContainer::Action::Method,
                    "replace", [
                        ParrotContainer::build(ParrotContainer::ActionArg::Instance, "B", :position(0)),
                        ParrotContainer::build(ParrotContainer::ActionArg::Instance, "C", :position(1))
                    ]
                )
            ]
        ));
        my $bar := $c.resolve("String");
        Assert::equal($bar, "FooCarCaz", "not equal");
    }
}
