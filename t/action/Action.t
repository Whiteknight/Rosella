INIT {
    pir::load_bytecode("rosella/core.pbc");
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Test::test(ActionTest);

class ActionTest {
    method test_BUILD() {
        my $action := Rosella::construct(Rosella::Action, "foo", []);
        $!assert.instance_of($action, Rosella::Action, "Is not an Action");

        $action := Rosella::construct(Rosella::Action, "foo");
        $!assert.instance_of($action, Rosella::Action, "Is not an Action");
    }

    method test_BUILD_FAILS() {
        $!assert.throws({
            my $null := pir::null__p();
            my $action := Rosella::construct(Rosella::Action, $null);
        });

        $!assert.throws({
            my $action := Rosella::construct(Rosella::Action, "foo", [
                Rosella::construct(Rosella::Version)
            ]);
        });
    }

    method prepare_args_empty() {
        my $action := Rosella::construct(Rosella::Action, "foo", []);
        my @pos := [];
        my %named := {};
        $action.prepare_args(@pos, %named);
        $!assert.equal(+@pos, 0);
        $!assert.equal(+%named, 0);
    }

    method prepare_args_positional() {
        my $action := Rosella::construct(Rosella::Action, "foo", [
            Rosella::construct(Rosella::Action::Argument::Instance, 5, :position(0)),
            Rosella::construct(Rosella::Action::Argument::Instance, "Test", :position(1)),
        ]);
        my @pos := [];
        my %named := {};
        $action.prepare_args(@pos, %named);
        $!assert.equal(+@pos, 2);
        $!assert.equal(+%named, 0);
        $!assert.equal(@pos[0], 5);
        $!assert.equal(@pos[1], "Test");
    }

    method prepare_args_positional_skip() {
        my $action := Rosella::construct(Rosella::Action, "foo", [
            Rosella::construct(Rosella::Action::Argument::Instance, 5, :position(0)),
            Rosella::construct(Rosella::Action::Argument::Instance, "Test", :position(2)),
        ]);
        my @pos := [];
        my %named := {};
        $action.prepare_args(@pos, %named);
        $!assert.equal(+@pos, 3);
        $!assert.equal(+%named, 0);
        $!assert.equal(@pos[0], 5, 'pos[0]');
        $!assert.not_defined(@pos[1], 'pos[1]');
        $!assert.equal(@pos[2], "Test", 'pos[2]');
    }

    method prepare_args_named() {
        my $action := Rosella::construct(Rosella::Action, "foo", [
            Rosella::construct(Rosella::Action::Argument::Instance, 5, :name("A")),
            Rosella::construct(Rosella::Action::Argument::Instance, "Test", :name("B"))
        ]);
        my @pos := [];
        my %named := {};
        $action.prepare_args(@pos, %named);
        $!assert.equal(+@pos, 0);
        $!assert.equal(+%named, 2);
        $!assert.equal(%named{"A"}, 5);
        $!assert.equal(%named{"B"}, "Test");
    }
}
