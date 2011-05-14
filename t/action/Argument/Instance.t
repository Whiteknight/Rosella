INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Test::test(ActionArgInstanceTest);

class ActionArgInstanceTest {
    method test_BUILD() {
        my $arg := Rosella::construct(Rosella::Action::Argument::Instance, 1);
        $!assert.instance_of($arg, Rosella::Action::Argument::Instance);
    }

    method resolve_value() {
        my $arg := Rosella::construct(Rosella::Action::Argument::Instance, 1);
        my $value := $arg.resolve_value();
        $!assert.equal($value, 1);
    }
}
