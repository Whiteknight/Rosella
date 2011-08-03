INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "container");
}

Rosella::Test::test(ActionArgContainerResolverTest);

class ActionArgContainerResolverTest {
    method test_BUILD() {
        my $c := Rosella::construct(Rosella::Container);
        my $arg := Rosella::construct(Rosella::Action::Argument::ContainerResolver, $c, "String");
        $!assert.not_null($arg);
    }

    method resolve() {
        my $item := "test string";
        my $c := Rosella::construct(Rosella::Container);
        $c.register_instance_type("String", $item);
        my $arg := Rosella::construct(Rosella::Action::Argument::ContainerResolver, $c, "String");
        my $result := $arg.resolve_value();
        $!assert.equal($item, $result);
        $!assert.same($item, $result);
    }
}
