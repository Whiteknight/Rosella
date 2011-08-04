INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "mockobject");
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
