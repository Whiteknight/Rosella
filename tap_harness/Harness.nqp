class Rosella::Harness {
    has $!total_passed;
    has $!total_failed;
    has $!total_files;
    has %!results;
    has @!tests;
    has %!loaders;

    method BUILD() {
        %!loaders := {};
        %!loaders{"NQP"} := Rosella::build(Rosella::Harness::Loader, Rosella::Harness::TestFile::NQP);
        %!loaders{"PIR"} := Rosella::build(Rosella::Harness::Loader, Rosella::Harness::TestFile::PIR);
        self.reset_counts();
        self.setup_next_run();
    }

    method setup_next_run() {
        @!tests := [];
        for %!loaders {
            %!loaders{$_}.prepare_new_run();
        }
    }

    method reset_counts() {
        $!total_passed := 0;
        $!total_failed := 0;
        $!total_files := 0;

        %!results := {};
        %!results{"PASSED"} := [];
        %!results{"FAILED"} := [];
        %!results{"ABORTED"} := [];
        %!results{"EMPTY"} := [];
    }

    method add_test_dirs($loader, *@dirs, :$recurse = 0) {
        my @tests := %!loaders{$loader}.get_tests_from_dirs(@dirs, $recurse);
        self.add_test_objects(@tests);
    }

    method add_test_files($loader, *@files) {
        my @tests := %!loaders{$loader}.get_tests_from_files(@files);
        self.add_test_objects(@tests);
    }

    method add_test_loader($name, $loader) {
        %!loaders{$name} := $loader;
    }

    method add_test_objects(@tests) {
        for @tests {
            @!tests.push($_);
        }
    }

    method find_max_file_length() {
        my $max := 0;
        for %!loaders {
            my $length := %!loaders{$_}.max_filename_length();
            if $length > $max {
                $max := $length;
            }
        }
        return $max;
    }

    method run (:$run_inline = 0, :$line_length = 0) {
        $!total_files := $!total_files + +@!tests;
        my $max_length := self.find_max_file_length();
        $max_length := $line_length if $line_length > $max_length;
        for @!tests {
            my $test := $_;
            $test.print_filename($max_length);
            $test.run($run_inline);
            $test.print_result();
            my $status := $test.status();
            %!results{$status}.push($test);
            if $status ne "ABORTED" {
                $!total_passed := $!total_passed + $test.passed_tests();
                $!total_failed := $!total_failed + $test.failed_tests();
            }
            self.reset_test_environment();
        }
        self.setup_next_run();
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

    method aborted_test_files() { %!results{"ABORTED"}; }
    method failed_test_files() { %!results{"FAILED"}; }
    method passed_test_files() { %!results{"PASSED"}; }
    method num_failed_tests() { $!total_failed; }
    method num_passed_tests() { $!total_passed; }
    method num_test_files() { $!total_files; }

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

