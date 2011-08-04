INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "action");
}

Rosella::Test::test(ActionSubTest);

class ActionSubTest {
    method test_BUILD() {
        my $action := Rosella::construct(Rosella::Action::Sub, sub($item){}, []);
        $!assert.instance_of($action, Rosella::Action::Sub, "Is not an Action");
    }

    method test_execute() {
        my $data := "This is a test";
        my $action := Rosella::construct(Rosella::Action::Sub,
            sub($item) {
                $item.replace("This", "That");
            }, []
        );
        $action.execute($data);
        $!assert.equal($data, "That is a test");
    }

    method test_BUILD_with_ActionArgs() {
        my $data := "This is a test";
        my $action := Rosella::construct(Rosella::Action::Sub,
            sub($item, $a, $b) {
                $item.replace($a, $b);
            }, [
                Rosella::construct(Rosella::Action::Argument::Instance, "a", :position(0)),
                Rosella::construct(Rosella::Action::Argument::Instance, "b", :position(1))
            ]
        );
        $action.execute($data);
        $!assert.equal($data, "This is b test");
    }

    method test_execute_args() {
        my $data := "This is a test";
        my $action := Rosella::construct(Rosella::Action::Sub,
            sub($item, $a, $b) {
                $item.replace($a, $b);
            }, []
        );
        $action.execute($data, [
            Rosella::construct(Rosella::Action::Argument::Instance, "a", :position(0)),
            Rosella::construct(Rosella::Action::Argument::Instance, "b", :position(1))
        ]);
        $!assert.equal($data, "This is b test");
    }

    method test_all() {
        my $data := "This is a test";
        my $action := Rosella::construct(Rosella::Action::Sub,
            sub($item, $a, $b) {
                $item.replace($a, $b);
            }, [
                Rosella::construct(Rosella::Action::Argument::Instance, "a", :position(0)),
                Rosella::construct(Rosella::Action::Argument::Instance, "b", :position(1))
            ]
        );
        $action.execute($data, [
            Rosella::construct(Rosella::Action::Argument::Instance, "i", :position(0)),
        ]);
        $!assert.equal($data, "Thbs bs a test");
    }
}
