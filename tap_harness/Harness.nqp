class ParrotTest::Harness {
    has $!total_passed;
    has $!total_failed;
    has $!total_files;
    has @!aborted_files;
    has %!results;
    has @!tests;
    has $!max_length;
    has %!loaders;

    sub new_hash(*%hash) { %hash; }

    method initialize() {
        $!total_passed := 0;
        $!total_failed := 0;
        @!aborted_files := [];
        @!tests := [];
        $!total_files := 0;
        %!results := new_hash();
        %!results{"PASSED"} := [];
        %!results{"FAILED"} := [];
        %!results{"ABORTED"} := [];
        $!max_length := 0;
        %!loaders := new_hash();
        %!loaders{"NQP"} := ParrotTest::Harness::Loader::NQP.new;
        %!loaders{"PIR"} := ParrotTest::Harness::Loader::PIR.new;
    }

    method add_nqp_test_dirs(*@dirs, $recurse := 0) {
        my @tests := %!loaders{"NQP"}.get_tests_from_dirs(@dirs, $recurse);
        self.add_test_objects(@tests);
    }

    method add_nqp_test_files(*@files) {
        my @tests := %!loaders{"NQP"}.get_tests_from_files(@files);
        self.add_test_objects(@tests);
    }

    method add_pir_test_dirs(*@dirs, $recurse := 0) {
        my @tests := %!loaders{"PIR"}.get_tests_from_dirs(@dirs, $recurse);
        self.add_test_objects(@tests);
    }

    method add_pir_test_files(*@files) {
        my @tests := %!loaders{"PIR"}.get_tests_from_files(@files);
        self.add_test_objects(@tests);
    }

    method add_test_objects(@tests) {
        for @tests {
            @!tests.push($_);
        }
    }

    sub new_hash(*%hash) { %hash; }

    method run () {
        $!total_files := +@!tests;
        $!max_length := $!nqp_loader.max_filename_length();
        for @!tests {
            my $test := $_;
            $test.setup();
            $test.print_filename($!max_length);
            $test.run();
            $test.print_result();
            my $status := $test.status();
            %!results{$status}.push($test);
            if $status ne "ABORTED" {
                $!total_passed := $!total_passed + $test.passed_tests();
                $!total_failed := $!total_failed + $test.failed_tests();
            }
            self.reset_test_environment();
        }
    }

    method run_was_success() {
        my $aborted := +%!results{"ABORTED"};
        if $aborted || $!total_failed {
            return 0;
        }
        else {
            return 1;
        }
    }

    # TODO: Refactor this out to a separate reporter class. Not everybody is
    #       going to want such a verbose report
    method show_results() {
        my $aborted := +%!results{"ABORTED"};
        if $aborted || $!total_failed {
            self.print("Result: FAILED");
        } else {
            self.print(
                "Result: PASSED",
                "\tPassed $!total_passed tests in $!total_files files"
            );
        }
        if $aborted {
            self.print(
                "\tFailed $aborted files due to premature exit",
                "\tList of failed files:"
            );
            for %!results{"ABORTED"} {
                my $abort := $_.get_filename();
                self.print("\t\t$abort");
            }
        }
        if $!total_failed {
            self.print(
                "\tFailed $!total_failed tests in " ~ +(%!results{"FAILED"}) ~ " files",
                "\tPassed $!total_passed tests in $!total_files files",
                "",
                "\tList of failed tests:"
            );
            for %!results{"FAILED"} {
                my $test := $_;
                pir::say("\t\t" ~ $test.get_filename());
                for $test.list_of_failures() {
                    my $failure := $_;
                    pir::say("\t\t\t$failure");
                }
            }
        }
    }

    method print(*@lines) {
        for @lines {
            pir::say($_);
        }
    }

    method reset_test_environment() {
        # TODO: This is an evil hack. Test::Builder doesn't clean up it's environment
        #       so when I try to run multiple tests in a single program instance
        #       it breaks. When Test::Builder gets fixed, remove this nonsense
        Q:PIR {
            $P0 = new "Undef"
            set_hll_global [ 'Test'; 'Builder'; '_singleton' ], 'singleton', $P0
        };
    }
}

# TAP grammar in ABNF
# http://testanything.org/wiki/index.php/TAP_at_IETF:_Draft_Standard#Grammar

