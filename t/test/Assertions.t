INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(AssertionTest);

class AssertionTest {

    # META TEST TESTS
    # Each of these tests is going to test one of the meta-tests: expect_pass
    # or expect_fail.

    method test_pass_pass() {
        $!assert.expect_pass({
            $!assert.equal(0, 0);
        });
    }

    method test_pass_fail() {
        $!assert.expect_fail({
            $!assert.expect_pass({
                $!assert.equal(0, 1);
            })
        });
    }

    method test_fail_pass() {
        $!assert.expect_fail({
            $!assert.expect_fail(sub() {
                $!assert.equal(0, 0);
            })
        });
    }

    method test_fail_fail() {
        $!assert.expect_fail({
            $!assert.equal(0, 1);
        });
    }

    # TESTS FOR output_is
    # These tests use the meta-tests defined above to test the
    # $!assert.output_is assertion

    method test_output_is_pass() {
        $!assert.expect_pass({
            $!assert.output_is({
                pir::say("This is a test");
            }, "This is a test\n");
        });
    }

    method test_output_is_fail_mismatch() {
        $!assert.expect_fail({
            $!assert.output_is({
                pir::say("This is a test");
            }, "This is NOT a test\n");
        });
    }

    method test_output_is_fail_trailing_whitespace() {
        $!assert.expect_fail({
            $!assert.output_is({
                pir::say("This is a test");
            }, "This is a test");
        });
    }

    method test_output_is_pass_stderr() {
        $!assert.expect_pass({
            $!assert.output_is({
                my $interp := pir::getinterp__P();
                my $stderr := $interp.stderr_handle();
                pir::say("This is a test");
                pir::print__vPS($stderr, "This is an error");
            }, "This is a test\n", erroutput => "This is an error");
        });
    }

    method test_output_is_fail_stderr_mismatch() {
        $!assert.expect_fail({
            $!assert.output_is({
                my $interp := pir::getinterp__P();
                my $stderr := $interp.stderr_handle();
                pir::say("This is a test");
                pir::print__vPS($stderr, "This is an error");
            }, "This is a test\n", erroutput => "This is NOT an error");
        });
    }

    # .throws() and .throws_nothing()

    method test_throws_pass() {
        $!assert.expect_pass({
            $!assert.throws({
                die("Expected exception");
            });
        });
    }

    method test_throws_fail() {
        $!assert.expect_fail({
            $!assert.throws({
                my $x := 5;
            });
        });
    }

    method test_throws_nothing_pass() {
        $!assert.expect_pass({
            $!assert.throws_nothing({
                my $x := 5;
            });
        });
    }

    method test_throws_nothing_fail() {
        $!assert.expect_fail({
            $!assert.throws_nothing({
                die("Unexpected exception");
            });
        });
    }

    # Matchers

    method is_match_arrays() {
        $!assert.expect_pass({
            my @m := [1, 2, 3, 4];
            my @n := [1, 2, 3, 4];
            $!assert.is_match(@m, @n);
        });
        $!assert.expect_fail({
            my @m := [1, 2, 3, 4];
            my @n := [1, 2, 3, 4, 5];
            $!assert.is_match(@m, @n);
        });
        $!assert.expect_fail({
            my @m := [1, 2, 3, 4];
            my @n := [5, 6, 7, 8];
            $!assert.is_match(@m, @n);
        });
        $!assert.expect_fail({
            my @m := [1, 2, 3, 4];
            my $n := "1234";
            $!assert.is_match(@m, $n);
        });
    }

    method is_not_match_arrays() {
        $!assert.expect_fail({
            my @m := [1, 2, 3, 4];
            my @n := [1, 2, 3, 4];
            $!assert.is_not_match(@m, @n);
        });
        $!assert.expect_pass({
            my @m := [1, 2, 3, 4];
            my @n := [1, 2, 3, 4, 5];
            $!assert.is_not_match(@m, @n);
        });
        $!assert.expect_pass({
            my @m := [1, 2, 3, 4];
            my @n := [5, 6, 7, 8];
            $!assert.is_not_match(@m, @n);
        });
        $!assert.expect_pass({
            my @m := [1, 2, 3, 4];
            my $n := "1234";
            $!assert.is_not_match(@m, $n);
        });
    }

    method is_match_hashes() {
        $!assert.expect_pass({
            my %m := {};
            %m{"foo"} := 1;
            %m{"bar"} := 2;
            %m{"baz"} := 3;
            my %n := {};
            %n{"foo"} := 1;
            %n{"bar"} := 2;
            %n{"baz"} := 3;
            $!assert.is_match(%m, %n);
        });
        $!assert.expect_fail({
            my %m := {};
            %m{"foo"} := 1;
            %m{"bar"} := 2;
            %m{"baz"} := 3;
            my %n := {};
            %n{"foo"} := 1;
            %n{"bar"} := 2;
            %n{"baz"} := 3;
            %n{"fie"} := 4;
            $!assert.is_match(%m, %n);
        });
        $!assert.expect_fail({
            my %m := {};
            %m{"foo"} := 1;
            %m{"bar"} := 2;
            %m{"baz"} := 3;
            my %n := {};
            %n{"foo"} := 4;
            %n{"bar"} := 5;
            %n{"baz"} := 6;
            $!assert.is_match(%m, %n);
        });
        $!assert.expect_fail({
            my %m := {};
            %m{"foo"} := 1;
            %m{"bar"} := 2;
            %m{"baz"} := 3;
            my $n := "123";
            $!assert.is_match(%m, $n);
        });
    }

    method is_not_match_hashes() {
        $!assert.expect_fail({
            my %m := {};
            %m{"foo"} := 1;
            %m{"bar"} := 2;
            %m{"baz"} := 3;
            my %n := {};
            %n{"foo"} := 1;
            %n{"bar"} := 2;
            %n{"baz"} := 3;
            $!assert.is_not_match(%m, %n);
        });
        $!assert.expect_pass({
            my %m := {};
            %m{"foo"} := 1;
            %m{"bar"} := 2;
            %m{"baz"} := 3;
            my %n := {};
            %n{"foo"} := 1;
            %n{"bar"} := 2;
            %n{"baz"} := 3;
            %n{"fie"} := 4;
            $!assert.is_not_match(%m, %n);
        });
        $!assert.expect_pass({
            my %m := {};
            %m{"foo"} := 1;
            %m{"bar"} := 2;
            %m{"baz"} := 3;
            my %n := {};
            %n{"foo"} := 4;
            %n{"bar"} := 5;
            %n{"baz"} := 6;
            $!assert.is_not_match(%m, %n);
        });
        $!assert.expect_pass({
            my %m := {};
            %m{"foo"} := 1;
            %m{"bar"} := 2;
            %m{"baz"} := 3;
            my $n := "123";
            $!assert.is_not_match(%m, $n);
        });
    }

    # Other Assertions

    method exists_keyed_str() {
        $!assert.expect_pass({
            my %m := {};
            %m{"test"} := 1;
            $!assert.exists_keyed_str(%m, "test");
        });
        $!assert.expect_fail({
            my %m := {};
            %m{"test"} := 1;
            $!assert.exists_keyed_str(%m, "no test");
        });
    }

    method not_exists_keyed_str() {
        $!assert.expect_pass({
            my %m := {};
            %m{"test"} := 1;
            $!assert.not_exists_keyed_str(%m, "no test");
        });
        $!assert.expect_fail({
            my %m := {};
            %m{"test"} := 1;
            $!assert.not_exists_keyed_str(%m, "test");
        });
    }
}
