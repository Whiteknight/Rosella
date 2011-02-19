# Copyright (C) 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Rosella::Suite {
    has @!members;
    has $!num_tests;
    has $!name;

    our method BUILD() {
        $!num_tests := 0;
        @!members := [ ];
    }

    our method name($value?) { pir::defined__IP($value) ?? ($!name := $value) !! $!name; }

    our method add_test($test) {
        @!members := @!members.push($test);
        $!num_tests := $!num_tests + $test.__num_tests;
        self;
    }

    my method default_result() {
        my $result := Rosella::build(Rosella::Result);
        $result.add_listener: Rosella::build(Rosella::Listener::TAP);
        return $result;
    }

    our method run($result = self.default_result) {
        $result.plan_tests($!num_tests);

        for @!members {
            unless $result.should_stop {
                self.run_test($_, $result);
            }
        }

        $result;
    }

    our method run_test($test, $result) {
        $result.start_test($test);
        my $exception;

        try {
            $test.__set_up();
            self.run_test_method($test);

            CATCH {
                $exception := $!;
                #$!.handled(1);
            }
        };

        try {
            $test.__tear_down();

            CATCH {
                pir::say("Caught exception while tearing down test " ~ pir::typeof__SP($test));
                pir::say($!);
                # TODO: We should set a "suite-related error" message on the Result
            }
        };

        if pir::defined__iP($exception) {
            $result.add_failure($test, $exception);
        }
        else {
            $result.end_test($test);
        }

        $result;
    }

    our method run_test_method($test) {
        my $method_name := $test.__name;
        my $object := $test;
        Q:PIR {
            .local pmc object, meth
            object = find_lex '$object'
            meth = find_lex '$method_name'

            $I0 = isa meth, 'Sub'
            unless $I0 goto call_string

            object.meth()

          call_string:
            $S0 = meth
            object.$S0()
        };
    }

    sub sort_cmp($a, $b) {
        $a.name lt $b.name ?? -1 !! 1;
    }

    our method sort() {
        @!members.sort(Rosella::Suite::sort_cmp);
        self;
    }

    our method suite() {
        self;
    }
}

