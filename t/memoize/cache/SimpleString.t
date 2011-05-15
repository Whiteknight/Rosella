INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/memoize.pbc");
}

Rosella::Test::test(Test::Memoize::Cache::SimpleString);

class Test::Memoize::Cache::SimpleString {
    method test_BUILD() {
        my $cache := Rosella::construct(Rosella::Memoize::Cache::SimpleString);
        $!assert.not_null($cache);
    }

    method get_item() {
        my $cache := Rosella::construct(Rosella::Memoize::Cache::SimpleString);
        my $item := $cache.get_item([2], {});
        $!assert.instance_of($item, Rosella::Memoize::Cache::Item);
        $!assert.equal($item.has_value(), 0);
    }

    method remove_item() {
        my $cache := Rosella::construct(Rosella::Memoize::Cache::SimpleString);
        my $item := $cache.get_item([2], {});
        $item.update_value(5);
        $!assert.is_true($item.has_value());
        $cache.remove_item([2], {});
        $item := $cache.get_item([2], {});
        $!assert.is_false($item.has_value());
    }

    method clear() {
        my $cache := Rosella::construct(Rosella::Memoize::Cache::SimpleString);
        my $item := $cache.get_item([2], {});
        $item.update_value(5);
        $!assert.is_true($item.has_value());
        $cache.clear();
        $item := $cache.get_item([2], {});
        $!assert.is_false($item.has_value());
    }

    method key() {
        my $cache := Rosella::construct(Rosella::Memoize::Cache::SimpleString);
        my $key_a := $cache.key(["a"], {});
        my $key_b := $cache.key(["b"], {});
        $!assert.not_equal($key_a, $key_b);
        my $key_a2 := $cache.key(["a"], {});
        $!assert.equal($key_a, $key_a2);
    }
}
