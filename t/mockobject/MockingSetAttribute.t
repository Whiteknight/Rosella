INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(Mocking::SetAttribute::Test);
class Mocking::SetAttribute::Test {
    method test_one_set_pass() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_set("test").once().with_args(2);
            my $m := $c.mock();
            pir::setattribute__vPSP($m, "test", 2);
            $c.verify();
        });
    }
}
