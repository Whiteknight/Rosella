INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Test::test(ActionSubTest);

class ActionSubTest is Rosella::Test::Testcase {
    method test_BUILD() {
        my $action := Rosella::build(Rosella::Action::Sub, sub($item){}, []);
        Assert::instance_of($action, Rosella::Action::Sub, "Is not an Action");
    }

    method test_execute() {
        my $data := "This is a test";
        my $action := Rosella::build(Rosella::Action::Sub,
            sub($item) {
                $item.replace("This", "That");
            }, []
        );
        $action.execute($data);
        Assert::equal($data, "That is a test");
    }

    method test_BUILD_with_ActionArgs() {
        my $data := "This is a test";
        my $action := Rosella::build(Rosella::Action::Sub,
            sub($item, $a, $b) {
                $item.replace($a, $b);
            }, [
                Rosella::build(Rosella::Action::Argument::Instance, "a", :position(0)),
                Rosella::build(Rosella::Action::Argument::Instance, "b", :position(1))
            ]
        );
        $action.execute($data);
        Assert::equal($data, "This is b test");
    }

    method test_execute_args() {
        my $data := "This is a test";
        my $action := Rosella::build(Rosella::Action::Sub,
            sub($item, $a, $b) {
                $item.replace($a, $b);
            }, []
        );
        $action.execute($data, [
            Rosella::build(Rosella::Action::Argument::Instance, "a", :position(0)),
            Rosella::build(Rosella::Action::Argument::Instance, "b", :position(1))
        ]);
        Assert::equal($data, "This is b test");
    }

    method test_all() {
        my $data := "This is a test";
        my $action := Rosella::build(Rosella::Action::Sub,
            sub($item, $a, $b) {
                $item.replace($a, $b);
            }, [
                Rosella::build(Rosella::Action::Argument::Instance, "a", :position(0)),
                Rosella::build(Rosella::Action::Argument::Instance, "b", :position(1))
            ]
        );
        $action.execute($data, [
            Rosella::build(Rosella::Action::Argument::Instance, "i", :position(0)),
        ]);
        Assert::equal($data, "Thbs bs a test");
    }
}
