# Copyright (C) 2009-2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Exception::UnitTestFailure {
    has $!exception;

    our method message(*@value) {
        my $msg := pir::join(" ", @value);
        if !pir::defined__IP($!exception) {
            $!exception := Q:PIR { %r = new ["Exception"] };
        }
        my $ex := $!exception;
        Q:PIR {
            $P0 = find_lex "$ex"
            $P1 = find_lex "$msg"
            setattribute $P0, "message", $P1
        }
    }

    our method throw() {
        my $ex := $!exception;
        Q:PIR {
            $P0 = find_lex "$ex"
            throw $P0
        }
    }
}

class UnitTest::Testcase is UnitTest::Standalone;

has $!todo;
has $!verify;

my method default_loader() {
    UnitTest::Loader.new;
}

my method default_result() {
    my $result := UnitTest::Result.new;
    $result.add_listener: UnitTest::Listener::TAP.new;
    return $result;
}

our sub fail($why) {
    my $ex := Exception::UnitTestFailure.new();
    $ex.message($why);
    $ex.throw();
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
        # TODO: Error reporting
        Q:PIR {
            $P0 = find_lex '$exception'
            $S0 = $P0["message"]
            say $S0
        };
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

our sub TEST_MAIN(:$namespace = Parrot::caller_namespace()) {
    my $parent_nsp := $namespace.get_parent;
    my $namespace_name := ~ $namespace;
    my $proto_obj := $parent_nsp.get_sym: $namespace_name;

    # FIXME: This blind-calls obj.MAIN, which does not allow for a sub (not method)
    # named MAIN in the namespace. Not sure if there are any other interactions with
    # hidden methods change.
    if ! pir::isnull__IP($proto_obj) && pir::isa__IP($proto_obj, 'P6protoobject') {
        $proto_obj.MAIN();
    }
    elsif $namespace.contains: 'MAIN' {
        if ! pir::isnull__IP( $proto_obj ) {
            $namespace<MAIN>($proto_obj);
        }
        else {
            $namespace<MAIN>();
        }
    }
    else {
        my $ns_name := $namespace.string_name;
        pir::die( "Could not locate proto-object for namespace $ns_name. Could not find 'MAIN()' in namespace. Nothing to do." );
    }
}

method todo_test( *@text ) {
    $!todo := @text.join;
}

method verify_that(*@text) {
    $!verify := @text.join;
}
