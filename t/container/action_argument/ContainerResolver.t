INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
    pir::load_bytecode("rosella/container.pbc");
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
