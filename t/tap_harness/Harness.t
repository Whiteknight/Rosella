INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/tap_harness.pbc");
}

Rosella::Test::test(Harness::Test);

class Harness::Test {
    method default_view() {
        my $harness := Rosella::build(Rosella::Harness);
        my $view := $harness.default_view();
        Assert::instance_of($view, Rosella::Harness::View);
    }

    method run() {
        $!context.unimplemented("Test Harness.run()");
    }

    method run_internal() {
        $!context.unimplemented("Test Harness.run_internal()");
    }
}
