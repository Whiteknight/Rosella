INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::Builder::Test);

class Test::Builder::Test {
    method test_BUILD() {
        my $builder := Rosella::construct(Rosella::Test::Builder);
        $!assert.instance_of($builder, Rosella::Test::Builder);
    }

    method test_todo() {
        $!status.unimplemented("Test this with the output test utilities");
    }

    method test_ok() {
        $!status.unimplemented("Test this with the output test utilities");
    }

    method test_diag() {
        $!status.unimplemented("Test this with the output test utilities");
    }

    method test_plan() {
        $!status.unimplemented("Test this with the output test utilities");
    }
}
