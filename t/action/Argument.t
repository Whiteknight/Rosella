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
        $!context.unimplemented("This");
    }

    method test_position() {
        $!context.unimplemented("This");
    }

    method test_set_positioning() {
        $!context.unimplemented("This");
    }

    method test_type() {
        $!context.unimplemented("This");
    }

    method test_resolve_to() {
        $!context.unimplemented("This");
    }
}
