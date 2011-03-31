INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Test::test(Action::Argument::Test);

class Action::Argument::Test {
    method test_BUILD() {
        my $arg := Rosella::build(Rosella::Action::Argument);
    }

    method test_name() {
        $!status.unimplemented("This");
    }

    method test_position() {
        $!status.unimplemented("This");
    }

    method test_set_positioning() {
        $!status.unimplemented("This");
    }

    method test_type() {
        $!status.unimplemented("This");
    }

    method test_resolve_to() {
        $!status.unimplemented("This");
    }
}
