INIT { pir::load_bytecode("rosella/_xunit.pbc"); }

MyTest1.suite.run();

class MyTest1 is Rosella::Testcase {
    method test_first() {
        Assert::equal(1,0,"oops");
    };

    method test_second() { };
    method test_third() { };
}
