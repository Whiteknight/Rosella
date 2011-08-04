INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::Failure::Test);

class Test::Failure::Test {
    method test_throw() {
        $!assert.expect_fail({
            my $undef;
            my $failure := Rosella::construct(Rosella::Test::Failure, "whoops", $undef, 0);
            $failure.throw();
        });
    }
}
