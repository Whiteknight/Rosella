INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(Mocking::Invoke::Test);
class Mocking::Invoke::Test is Rosella::Test::Testcase {
    method test_one_invoke_args_return_pass() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass, :allow_invoke(1));
            $c.expect().once().invoke().with_args(1, 2, 3).will_return(4);
            my $m := $c.mock();
            my $result := $m(1, 2, 3);
            Assert::equal($result, 4);
            $c.verify();
        });
    }
}
