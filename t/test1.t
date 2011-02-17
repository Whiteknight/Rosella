INIT { pir::load_bytecode("parrot_test_xunit.pbc"); }

class MyTest1 is UnitTest::Testcase {
    method test_first() { };
    method test_second() { };
    method test_third() { };
}
