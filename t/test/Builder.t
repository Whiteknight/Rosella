INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::Builder::Test);

class Test::Builder::Test {
    method test_BUILD() {
        my $builder := Rosella::build(Rosella::Test::Builder);
        Assert::instance_of($builder, Rosella::Test::Builder);
    }

    method test_todo() {
        $!context.unimplemented("Find a way to test this.\n" ~
            "Either Test::Builder should take a handle, " ~
            "or an Assert:: should be able to capture output"
        );
    }

    method test_ok() {
        $!context.unimplemented("Find a way to test this.\n" ~
            "Either Test::Builder should take a handle, " ~
            "or an Assert:: should be able to capture output"
        );
    }

    method test_diag() {
        $!context.unimplemented("Find a way to test this.\n" ~
            "Either Test::Builder should take a handle, " ~
            "or an Assert:: should be able to capture output"
        );
    }

    method test_plan() {
        $!context.unimplemented("Find a way to test this.\n" ~
            "Either Test::Builder should take a handle, " ~
            "or an Assert:: should be able to capture output"
        );
    }
}
