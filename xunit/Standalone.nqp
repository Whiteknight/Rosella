# Copyright (C) 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

# Parent class of both Testcase and Suite, this class has a name, and a MAIN/main routine
# to invoke when running as a standalone test program.
class UnitTest::Standalone;

has $!name;

our method MAIN() {
    unless our $_Already_running {
        # Prevent loaded testcases from running themselves automatically.
        $_Already_running := 1;
        self.main();
    }
}

our method main() {
    # TODO: Should be a Program here. Need to process args, in case I want to run just
    # a few of the test cases.
    self.suite.run();
}

our method name($value?) { pir::defined__IP($value) ?? ($!name := $value) !! $!name; }

our method run($result?) {
    unless pir::defined__IP($result) {
        $result := self.default_result;
    }

    $result.plan_tests(self.num_tests);

    for self.members {
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
    self.members.sort(UnitTest::Suite::sort_cmp);
    self;
}

our method suite() {
    self;
}
