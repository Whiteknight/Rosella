# Copyright (C) 2009-2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class ParrotTest::Testcase {
    has $!todo;
    has $!verify;
    has $!name;

    my method default_loader() {
        ParrotTest::Loader.new;
    }

    our method name($value?) { pir::defined__IP($value) ?? ($!name := $value) !! $!name; }

    our method verify($value?) {
        if pir::defined($value) {
            $!verify := $value;
        }
        $!verify;
    }

    our method todo($value?) {
        if pir::defined($value) {
            $!todo := $value;
        }
        $!todo;
    }

    my method default_result() {
        my $result := ParrotTest::Result.new;
        $result.add_listener: ParrotTest::Listener::TAP.new;
        return $result;
    }

    our method num_tests() {
        1;
    }

    # NOTE: Don't call this directly!! Call .suite.run instead.
    our method run($result = self.default_result) {
        $result.start_test(self);
        my $exception;

        try {
            self.set_up();
            self.run_test();

            CATCH {
                $exception := $!;
                #$!.handled(1);
            }
        };

        try {
            self.tear_down();

            CATCH {
                pir::say("Caught exception while tearing down test " ~ pir::typeof__SP(self));
                pir::say($!);
                # TODO: We should set a "suite-related error" message on the Result
            }
        };

        if pir::defined__iP($exception) {
            $result.add_failure(self, $exception);
        }
        else {
            $result.end_test(self);
        }

        $result;
    }

    our method run_test() {
        my $method_name := self.name;
        my $object := self;
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

    our method set_up() { }

    our method suite() {
        my $suite := self.default_loader.load_tests_from_testcase(self);
        $suite.name: "Test suite for " ~ pir::typeof__SP(self.WHAT);
        $suite;
    }

    our method tear_down() { }

    method todo_test( *@text ) {
        $!todo := @text.join;
    }

    method verify_that(*@text) {
        $!verify := @text.join;
    }
}
