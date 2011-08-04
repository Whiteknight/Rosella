INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "memoize");
}

Rosella::Test::test(Test::Memoize::ProxyBased);

class Test::Memoize::ProxyBased {
    method test() {
        $!status.unimplemented("Need tests for proxy-based memoization");
    }
}
