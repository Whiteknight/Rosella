INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "container");
}

Rosella::Test::test(ContainerTest);

class MyTestClass {
    has $!a;
    has $!b;
    method MyTestClass($a, $b) { $!a := $a; $!b := $b; }
    method a() { $!a; }
    method b() { $!b; }
}

class ContainerTest {
    method test_BUILD() {
        my $container := Rosella::construct(Rosella::Container);
        $!assert.not_null($container);
        $!assert.instance_of($container, Rosella::Container);
    }

    method test_default_container() {
        my $c := Rosella::Container::default_container();
        $!assert.instance_of($c, Rosella::Container, "no default");
    }

    method set_default_container() {
        my $c := "test";
        Rosella::Container::set_default_container($c);
        my $d := Rosella::Container::default_container();
        $!assert.same($c, $d);
    }

    method test_resolve_default_factory() {
        my $c := Rosella::construct(Rosella::Container);
        # No previous registration, falls back to the default object factory
        my $item := $c.resolve("String");
        $!assert.instance_of($item, "String");
    }

    method test_resolve_default_factory_with_args() {
        my $c := Rosella::construct(Rosella::Container);
        # No previous registration, falls back to the default object factory
        # Pass arguments to the constructor
        my $item := $c.resolve(MyTestClass, 1, 2);
        $!assert.instance_of($item, MyTestClass);
        $!assert.equal($item.a, 1);
        $!assert.equal($item.b, 2);
    }

    method test_resolve_create() {
        my $c := Rosella::construct(Rosella::Container);
        my $item := $c.resolve_create("String");
        $!assert.instance_of($item, "String");
    }

    method test_register_factory_method() {
        my $c := Rosella::construct(Rosella::Container);
        $c.register_factory_method("Foobar", sub () {
            return pir::box__PI(7);
        });
        my $i := $c.resolve("Foobar");
        $!assert.equal($i, 7, "not equal");
    }

    method test_register_type_withactions() {
        my $c := Rosella::construct(Rosella::Container);
        $c.register_type("String",
            :meth_inits([
                Rosella::construct(Rosella::Action::Sub,
                    sub ($obj) {
                        pir::set__vPS($obj, "FooBarBaz");
                    }, []
                ),
                Rosella::construct(Rosella::Action::Method,
                    "replace", [
                        Rosella::construct(Rosella::Action::Argument::Instance, "B", :position(0)),
                        Rosella::construct(Rosella::Action::Argument::Instance, "C", :position(1))
                    ]
                )
            ]
        ));
        my $bar := $c.resolve("String");
        $!assert.equal($bar, "FooCarCaz", "not equal");
    }

    method register_prototype() {
        $!status.unimplemented("This");
    }

    method register_instance() {
        $!status.unimplemented("This");
    }

    method register_instance_type() {
        $!status.unimplemented("This");
    }

    method resolve() {
        $!status.unimplemented("This");
    }

    method test_auto_register() {
        my $c := Rosella::construct(Rosella::Container, :auto_register(1));
        my $a := $c.resolve("String");
        my $b := $c.resolve("String");
        $!assert.same($a, $b);
    }

    method test_auto_register_disabled() {
        my $c := Rosella::construct(Rosella::Container, :auto_register(0));
        my $a := $c.resolve("String");
        my $b := $c.resolve("String");
        $!assert.not_same($a, $b);
    }
}
