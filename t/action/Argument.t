INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Test::test(Action::Argument::Test);

class Action::Argument::Test {
    method test_BUILD() {
        my $arg := Rosella::construct(Rosella::Action::Argument);
    }

    method test_setup_positioning_name() {
        my $arg := Rosella::construct(Rosella::Action::Argument);
        $arg.setup_positioning(:name("Foo"));
        my $name := pir::getattribute__PPS($arg, 'name');
        my $pos := pir::getattribute__PPS($arg, 'position');
        $!assert.equal($name, "Foo");
        $!assert.equal($pos, -1);
    }

    method test_setup_positioning_position() {
        my $arg := Rosella::construct(Rosella::Action::Argument);
        $arg.setup_positioning(:position(7));
        my $name := pir::getattribute__PPS($arg, 'name');
        my $pos := pir::getattribute__PPS($arg, 'position');
        $!assert.is_null($name);
        $!assert.equal($pos, 7);
    }

    method resolve_value_FAIL() {
        my $arg := Rosella::construct(Rosella::Action::Argument);
        $!assert.throws({
            my $foo := $arg.resolve_value();
        });
    }

    method verify_all_arguments() {
        $!assert.throws_nothing({
            Rosella::Action::Argument::verify_all_arguments("", []);
        });

        $!assert.throws_nothing({
            Rosella::Action::Argument::verify_all_arguments("", [
                Rosella::construct(Rosella::Action::Argument)
            ]);
        });
    }

    method verify_all_arguments_FAIL() {
        $!assert.throws({
            Rosella::Action::Argument::verify_all_arguments("", [
                Rosella::construct(Rosella::Version)
            ]);
        });
    }
}
