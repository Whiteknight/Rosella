INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(Mocking::GetAttribute::Test);
class Mocking::GetAttribute::Test {
    method test_one_get_return_pass() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_get("test").once().will_return(2);
            my $m := $c.mock();
            my $result := pir::getattribute__PPS($m, "test");
            $!assert.equal($result, 2);
            $c.verify();
        });
    }
}