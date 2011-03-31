INIT {
    pir::load_bytecode("rosella/core.pbc");
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Test::test(ActionTest);

class ActionTest {
    method test_BUILD() {
        my $action := Rosella::build(Rosella::Action, "foo", []);
        Assert::instance_of($action, Rosella::Action, "Is not an Action");
    }

    method prepare_args_empty() {
        my $action := Rosella::build(Rosella::Action, "foo", []);
        my @pos := [];
        my %named := {};
        $action.prepare_args(@pos, %named);
        Assert::equal(+@pos, 0);
        Assert::equal(+%named, 0);
    }

    method prepare_args_positional() {
        my $action := Rosella::build(Rosella::Action, "foo", [
            Rosella::build(Rosella::Action::Argument::Instance, 5, :position(0)),
            Rosella::build(Rosella::Action::Argument::Instance, "Test", :position(1)),
        ]);
        my @pos := [];
        my %named := {};
        $action.prepare_args(@pos, %named);
        Assert::equal(+@pos, 2);
        Assert::equal(+%named, 0);
        Assert::equal(@pos[0], 5);
        Assert::equal(@pos[1], "Test");
    }

    method prepare_args_positional_skip() {
        my $action := Rosella::build(Rosella::Action, "foo", [
            Rosella::build(Rosella::Action::Argument::Instance, 5, :position(0)),
            Rosella::build(Rosella::Action::Argument::Instance, "Test", :position(2)),
        ]);
        my @pos := [];
        my %named := {};
        $action.prepare_args(@pos, %named);
        Assert::equal(+@pos, 3);
        Assert::equal(+%named, 0);
        Assert::equal(@pos[0], 5, 'pos[0]');
        Assert::not_defined(@pos[1], 'pos[1]');
        Assert::equal(@pos[2], "Test", 'pos[2]');
    }

    method prepare_args_named() {
        my $action := Rosella::build(Rosella::Action, "foo", [
            Rosella::build(Rosella::Action::Argument::Instance, 5, :name("A")),
            Rosella::build(Rosella::Action::Argument::Instance, "Test", :name("B"))
        ]);
        my @pos := [];
        my %named := {};
        $action.prepare_args(@pos, %named);
        Assert::equal(+@pos, 0);
        Assert::equal(+%named, 2);
        Assert::equal(%named{"A"}, 5);
        Assert::equal(%named{"B"}, "Test");
    }
}
