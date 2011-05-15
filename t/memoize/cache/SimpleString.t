INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/memoize.pbc");
}

Rosella::Test::test(Test::Memoize::Cache::SimpleString);

class Test::Memoize::Cache::SimpleString {
}
