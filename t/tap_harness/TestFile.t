INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/harness.pbc");
}

Rosella::Test::test(Harness::TestFile::Test);

class Harness::TestFile::Test {

}
