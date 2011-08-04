INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "action");
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
