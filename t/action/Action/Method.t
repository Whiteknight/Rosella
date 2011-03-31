INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

Rosella::Test::test(ActionMethodTest);

class MyTargetType { method test() { } }

class ActionMethodTest {
    method test_BUILD() {
        my $action := Rosella::build(Rosella::Action::Method, "test");
        Assert::instance_of($action, Rosella::Action::Method, "Is not a Method");
    }

    method execute() {
        my $action := Rosella::build(Rosella::Action::Method, "test");
        my $mockfactory := Rosella::build(Rosella::MockObject::Factory);
        my $controller := $mockfactory.create_typed(MyTargetType);
        $controller.expect_method("test").once.with_no_args;
        my $target := $controller.mock;
        $action.execute($target);
        $controller.verify;
    }

    method execute_initializer() {
        my $action := Rosella::build(Rosella::Action::Method, "test");
        my $mockfactory := Rosella::build(Rosella::MockObject::Factory);
        my $controller := $mockfactory.create_typed(MyTargetType);
        $controller.expect_method("test").once.with_no_args;
        my $target := $controller.mock;
        $action.execute_initializer($target, [], {});
        $controller.verify;
    }

    method execute_initializer_args() {
        my $action := Rosella::build(Rosella::Action::Method, "test");
        my $mockfactory := Rosella::build(Rosella::MockObject::Factory);
        my $controller := $mockfactory.create_typed(MyTargetType);
        $controller.expect_method("test").once.with_args(1, 2, 3, :foo("A"), :bar("B"));
        my $target := $controller.mock;
        my %named := {};
        %named{"foo"} := "A";
        %named{"bar"} := "B";
        $action.execute_initializer($target, [1, 2, 3], %named);
        $controller.verify;
    }
}
