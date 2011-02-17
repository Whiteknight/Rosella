# Copyright (C) 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class UnitTest::Suite {
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
        $!num_tests := $!num_tests + $test.num_tests;
        self;
    }

    my method default_result() {
        my $result := UnitTest::Result.new();
        $result.add_listener(UnitTest::Listener::TAP.new);
        $result;
    }

    our method run($result = self.default_result) {
        $result.plan_tests($!num_tests);

        for @!members {
            unless $result.should_stop {
                $_.run($result);
            }
        }

        $result;
    }

    sub sort_cmp($a, $b) {
        $a.name lt $b.name ?? -1 !! 1;
    }

    our method sort() {
        @!members.sort(UnitTest::Suite::sort_cmp);
        self;
    }

    our method suite() {
        self;
    }
}

