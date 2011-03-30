INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(AssertionTest);

class AssertionTest {

    # META TEST TESTS
    # Each of these tests is going to test one of the meta-tests: expect_pass
    # or expect_fail.

    method test_pass_pass() {
        Assert::expect_pass({
            Assert::equal(0, 0);
        });
    }

    method test_pass_fail() {
        Assert::expect_fail({
            Assert::expect_pass({
                Assert::equal(0, 1);
            })
        });
    }

    method test_fail_pass() {
        Assert::expect_fail({
            Assert::expect_fail(sub() {
                Assert::equal(0, 0);
            })
        });
    }

    method test_fail_fail() {
        Assert::expect_fail({
            Assert::equal(0, 1);
        });
    }

    # TESTS FOR output_is
    # These tests use the meta-tests defined above to test the
    # Assert::output_is assertion

    method test_output_is_pass() {
        Assert::expect_pass({
            Assert::output_is({
                pir::say("This is a test");
            }, "This is a test\n");
        });
    }

    method test_output_is_fail_mismatch() {
        Assert::expect_fail({
            Assert::output_is({
                pir::say("This is a test");
            }, "This is NOT a test\n");
        });
    }

    method test_output_is_fail_trailing_whitespace() {
        Assert::expect_fail({
            Assert::output_is({
                pir::say("This is a test");
            }, "This is a test");
        });
    }

    method test_output_is_pass_stderr() {
        Assert::expect_pass({
            Assert::output_is({
                my $interp := pir::getinterp__P();
                my $stderr := $interp.stderr_handle();
                pir::say("This is a test");
                pir::print__vPS($stderr, "This is an error");
            }, "This is a test\n", erroutput => "This is an error");
        });
    }

    method test_output_is_fail_stderr_mismatch() {
        Assert::expect_fail({
            Assert::output_is({
                my $interp := pir::getinterp__P();
                my $stderr := $interp.stderr_handle();
                pir::say("This is a test");
                pir::print__vPS($stderr, "This is an error");
            }, "This is a test\n", erroutput => "This is NOT an error");
        });
    }
}
