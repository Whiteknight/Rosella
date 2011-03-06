INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::Testcase::Test);

class Test::Testcase::Test is Rosella::Test::Testcase {
}
