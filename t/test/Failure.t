INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::Failure::Test);

class Test::Failure::Test {
    method test_throw() {
        Assert::expect_fail({
            my $failure := Rosella::build(Rosella::Test::Failure, "whoops", 0);
            $failure.throw();
        });
    }
}
