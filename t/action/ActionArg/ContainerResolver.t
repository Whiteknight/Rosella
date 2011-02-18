INIT {
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/action.pbc");
    pir::load_bytecode("rosella/container.pbc");
}

ActionArgContainerResolverTest.suite.run();

class ActionArgContainerResolverTest is Rosella::Testcase {
    method test_BUILD() {
        my $c := Rosella::build(Rosella::Container);
        my $arg := Rosella::build(Rosella::ActionArg::ContainerResolver, $c, "String");
    }
}
