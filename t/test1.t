INIT { pir::load_bytecode("parrot_test_xunit.pbc"); }

MyTest1.suite.run();

class MyTest1 is ParrotTest::Testcase {
    method test_first() {
        Assert::equal(1,0,"oops");
    };

    method test_second() { };
    method test_third() { };
}
