INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/memoize.pbc");
}

Rosella::Test::test(Test::Memoize::Cache::Item);

class Test::Memoize::Cache::Item {
    method test_BUILD() {
        my $item := Rosella::construct(Rosella::Memoize::Cache::Item, "test_key");
        $!assert.not_null($item);
        $!assert.is_false($item.has_value());
    }

    method test_BUILD() {
        my $item := Rosella::construct(Rosella::Memoize::Cache::Item, "test_key", 6);
        $!assert.not_null($item);
        $!assert.is_true($item.has_value());
        $!assert.equal($item.get_value(), 6);
    }

    method has_value() {
        my $item := Rosella::construct(Rosella::Memoize::Cache::Item, "test_key");
        $!assert.not_null($item);
        $!assert.is_false($item.has_value());
        $item.update_value(7);
        $!assert.is_true($item.has_value());
    }

    method update_value() {
        my $item := Rosella::construct(Rosella::Memoize::Cache::Item, "test_key", 6);
        $!assert.equal($item.get_value(), 6);
        $item.update_value(7);
        $!assert.equal($item.get_value(), 7);
    }

    method get_value() {
        my $item := Rosella::construct(Rosella::Memoize::Cache::Item, "test_key", 6);
        $!assert.equal($item.get_value(), 6);
    }
}
