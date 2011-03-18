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
        self.unimplemented("This");
    }

    method test_position() {
        self.unimplemented("This");
    }

    method test_set_positioning() {
        self.unimplemented("This");
    }

    method test_type() {
        self.unimplemented("This");
    }

    method test_resolve_to() {
        self.unimplemented("This");
    }
}
