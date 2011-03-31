INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/harness.pbc");
}

Rosella::Test::test(Harness::View::Test);

class Harness::View::Test {
    method test_BUILD() {
        $!status.unimplemented("Do this");
    }

    method add_run() {
        $!status.unimplemented("Do this");
    }

    method start_test() {
        $!status.unimplemented("Do this");
    }

    method end_test() {
        $!status.unimplemented("Do this");
    }

    method test_run_complete() {
        $!status.unimplemented("Do this");
    }

    method show_results() {
        $!status.unimplemented("Do this");
    }

    method show_error_detail() {
        $!status.unimplemented("Do this");
    }

    method show_failure_detail() {
        $!status.unimplemented("Do this");
    }

    method show_result_headline() {
        $!status.unimplemented("Do this");
    }

    method get_all_files_by_status() {
        $!status.unimplemented("Do this");
    }
}
