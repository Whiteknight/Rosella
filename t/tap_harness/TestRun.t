INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/harness.pbc");
}

Rosella::Test::test(Harness::TestRun::Test);

class Harness::TestRun::Test {
    method test_BUILD() {
        my $testrun := Rosella::build(Rosella::Harness::TestRun, []);
        Assert::instance_of($testrun, Rosella::Harness::TestRun);
    }

    method test_tests() {
        $!context.unimplemented("This!");
    }

    method max_file_length() {
        $!context.unimplemented("This!");
    }

    method run_was_success() {
        $!context.unimplemented("This!");
    }

    method run_was_success_default() {
        my $testrun := Rosella::build(Rosella::Harness::TestRun, []);
        Assert::equal($testrun.run_was_success(), 1);
    }

    method files_by_status() {
        $!context.unimplemented("This!");
    }

    method num_files_by_status() {
        $!context.unimplemented("This!");
    }

    method num_files_empty() {
        my $testrun := Rosella::build(Rosella::Harness::TestRun, []);
        Assert::equal($testrun.num_files(), 0);
    }

    method num_files() {
        my $testrun := Rosella::build(Rosella::Harness::TestRun, ["a", "b", "c"]);
        Assert::equal($testrun.num_files(), 3);
    }

    method mark_completed() {
        my $testrun := Rosella::build(Rosella::Harness::TestRun, []);
        $testrun.mark_completed();
        Assert::equal($testrun.is_complete(), 1);
    }

    method is_complete() {
        my $testrun := Rosella::build(Rosella::Harness::TestRun, []);
        Assert::equal($testrun.is_complete(), 0);
        $testrun.mark_completed();
        Assert::equal($testrun.is_complete(), 1);
    }
}
