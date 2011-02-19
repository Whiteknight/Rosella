class Rosella::Harness::Output {
    method debug($line) { pir::die("Must use a subclass"); }
    method show_results_summary($harness) { pir::die("Must use a subclass"); }
    method show_results_detail($harness) { pir::die("Must use a subclass"); }
}

class Rosella::Harness::Output::Console {
    method debug($line) { pir::say("# $line"); }

    method show_results_summary($harness) {
        my @aborted_files := $harness.aborted_test_files;
        my $num_aborted := +@aborted_files;
        my $total_files := $harness.num_test_files;
        my $passed_tests := $harness.num_passed_tests;
        my $failed_tests := $harness.num_failed_tests;
        my @failed_files := $harness.failed_test_files;
        my $num_failed_files := +@failed_files;

        if $num_aborted || $failed_tests {
            pir::say("Result: FAILED");
            pir::say("\tPassed $passed_tests tests in $total_files files");
            if $num_aborted {
                pir::say("\tFailed $num_aborted files due to premature exit");
            }
            if $failed_tests {
                pir::say("\tFailed $failed_tests tests in $num_failed_files files");
            }
            pir::say("");
        } else {
            pir::say("Result: PASSED");
            pir::say("\tPassed $passed_tests tests in $total_files files");
        }
    }

    method show_error_detail($harness) {
        my $failed_tests := $harness.num_failed_tests;
        if $failed_tests == 0 {
            return;
        }
        my @failed_files := $harness.failed_test_files;
        my $num_failed_files := +@failed_files;
        pir::say("\tList of failed tests by file:");
        for @failed_files {
            my $test := $_;
            pir::say("\t\t" ~ $test.filename);
            for $test.list_of_failures() {
                my $failure := $_;
                pir::say("\t\t\t$failure");
            }
        }
    }

    method show_failure_detail($harness) {
        my @aborted_files := $harness.aborted_test_files;
        my $num_aborted := +@aborted_files;
        if $num_aborted {
            pir::say("\tList of files with premature exits:");
            for @aborted_files {
                # TODO: Should record and output error codes or other
                #       error info. Display some diagnostics here
                my $file := $_.filename;
                pir::say("\t\t$file");
            }
        }
    }

    method show_todo_pass_details($harness) {
    }

    method show_passed_detail($harness) {
    }
}
