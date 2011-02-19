INIT {
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Testcase::test(ActionArgTest);

class ActionArgTest is Rosella::Testcase {
    method test_BUILD() {
        my $arg := Rosella::build(Rosella::ActionArg);
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
