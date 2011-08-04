INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "container");
}

Rosella::Test::test(Container::ItemFactory::Test);

class Container::ItemFactory::Test {
    method test_BUILD() {
        my $factory := Rosella::construct(Rosella::Container::ItemFactory);
        $!assert.not_null($factory);
    }

    method create() {
        $!assert.throws({
            my $factory := Rosella::construct(Rosella::Container::ItemFactory);
            my $item := $factory.create();
        });
    }

    method create_typed() {
        $!status.unimplemented("test create_typed with no initializers");
    }

    method create_typed_initializers() {
        $!status.unimplemented("test create with initializers");
    }
}
