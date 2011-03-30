INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/harness.pbc");
}

Rosella::Test::test(Harness::View::Test);

class Harness::View::Test {
    method test_BUILD() {
        $!context.unimplemented("Do this");
    }

    method add_run() {
        $!context.unimplemented("Do this");
    }

    method start_test() {
        $!context.unimplemented("Do this");
    }

    method end_test() {
        $!context.unimplemented("Do this");
    }

    method test_run_complete() {
        $!context.unimplemented("Do this");
    }

    method show_results() {
        $!context.unimplemented("Do this");
    }

    method show_error_detail() {
        $!context.unimplemented("Do this");
    }

    method show_failure_detail() {
        $!context.unimplemented("Do this");
    }

    method show_result_headline() {
        $!context.unimplemented("Do this");
    }

    method get_all_files_by_status() {
        $!context.unimplemented("Do this");
    }
}
