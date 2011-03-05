INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(AssertionTest);

class AssertionTest is Rosella::Test::Testcase {
    method test_pass_pass() {
        Assert::expect_pass(sub() {
            Assert::equal(0, 0);
        });
    }

    method test_pass_fail() {
        Assert::expect_fail(sub() {
            Assert::expect_pass(sub() {
                Assert::equal(0, 1);
            })
        });
    }

    method test_fail_pass() {
        Assert::expect_fail(sub() {
            Assert::expect_fail(sub() {
                Assert::equal(0, 0);
            })
        });
    }

    method test_fail_fail() {
        Assert::expect_fail(sub() {
            Assert::equal(0, 1);
        });
    }
}
