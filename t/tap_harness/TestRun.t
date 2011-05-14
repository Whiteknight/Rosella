INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/harness.pbc");
}

Rosella::Test::test(Harness::TestRun::Test);

class Harness::TestRun::Test {
    method test_BUILD() {
        my $testrun := Rosella::construct(Rosella::Harness::TestRun, []);
        $!assert.instance_of($testrun, Rosella::Harness::TestRun);
    }

    method test_tests() {
        $!status.unimplemented("This!");
    }

    method max_file_length() {
        $!status.unimplemented("This!");
    }

    method run_was_success() {
        $!status.unimplemented("This!");
    }

    method run_was_success_default() {
        my $testrun := Rosella::construct(Rosella::Harness::TestRun, []);
        $!assert.equal($testrun.run_was_success(), 1);
    }

    method files_by_status() {
        $!status.unimplemented("This!");
    }

    method num_files_by_status() {
        $!status.unimplemented("This!");
    }

    method num_files_empty() {
        my $testrun := Rosella::construct(Rosella::Harness::TestRun, []);
        $!assert.equal($testrun.num_files(), 0);
    }

    method num_files() {
        my $testrun := Rosella::construct(Rosella::Harness::TestRun, ["a", "b", "c"]);
        $!assert.equal($testrun.num_files(), 3);
    }

    method mark_completed() {
        my $testrun := Rosella::construct(Rosella::Harness::TestRun, []);
        $testrun.mark_completed();
        $!assert.equal($testrun.is_complete(), 1);
    }

    method is_complete() {
        my $testrun := Rosella::construct(Rosella::Harness::TestRun, []);
        $!assert.equal($testrun.is_complete(), 0);
        $testrun.mark_completed();
        $!assert.equal($testrun.is_complete(), 1);
    }
}
