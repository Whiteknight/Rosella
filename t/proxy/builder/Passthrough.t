INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/proxy.pbc");
}

class My::Foo {
    has $!test_data;

    method test_a($v) { $!test_data := $v };
    method test_b() { return $!test_data; }
}

Rosella::Test::test(Proxy::Builder::Passthrough::Test);
class Proxy::Builder::Passthrough::Test {
    method test_passthrough() {
        my $f := Rosella::construct(Rosella::Proxy::Factory, My::Foo, [
            Rosella::construct(Rosella::Proxy::Builder::Passthrough),
        ]);
        my $target := My::Foo.new();
        $target.test_a(5);
        my $result := $target.test_b();
        $!assert.equal($result, 5);
        my $null := pir::null__P();
        my $p := $f.create($null, $target);
        $p.test_a(7);
        $result := $p.test_b();
        $!assert.equal($result, 7);
    }
}
