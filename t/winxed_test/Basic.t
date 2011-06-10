$load "rosella/test.pbc";

class Test_Winxed_Tests {
    function empty_test_passes() {
    }

    function basic_pass() {
        self.assert.equal(0, 0);
    }

    function basic_fail() {
        self.assert.expect_fail(function() {
            self.assert.equal(0, 1);
        });
    }
}

function main[main]() {
    using Rosella.Test.test;
    test(class Test_Winxed_Tests);
}
