INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/memoize.pbc");
}

Rosella::Test::test(Test::Memoize);

sub test_foo(&f, $a) {
    pir::say(pir::sprintf__SSP('foo(%d) : %s', [$a, &f($a)]));
}

sub foo($a) {
    say("in foo");
    return $a + 2;
}

sub add_two($a) { return $a + 2; }

sub add_three($a) { return $a + 3; }

class TestClass {
    method test_method($a) {
        pir::say("test_method: $a");
        return $a + 5;
    }
    method get_string() is pirflags<:vtable> { return "TestClass"; }
}

class Test::Memoize {
    method test_memoize() {
        # First, set up the comparison
        $!assert.output_is({
            test_foo(foo, 3);
            test_foo(foo, 3);
            test_foo(foo, 4);
            test_foo(foo, 4);
        }, "in foo\nfoo(3) : 5\nin foo\nfoo(3) : 5\nin foo\nfoo(4) : 6\nin foo\nfoo(4) : 6\n");

        # Now show that we get the same results, but without calling foo as much
        $!assert.output_is({
            my &mem := Rosella::Memoize::memoize(foo);

            test_foo(&mem, 3);
            test_foo(&mem, 3);
            test_foo(&mem, 4);
            test_foo(&mem, 4);
        }, "in foo\nfoo(3) : 5\nfoo(3) : 5\nin foo\nfoo(4) : 6\nfoo(4) : 6\n");
    }

    method test_Y() {
        # fib(50) using the naive recursive declaration would take a VERY long
        # time to compute on any hardware. The fact that this test gives us
        # an answer in a short amount of time proves that we're properly
        # memoizing. See also the fib benchmark
        my $answer := (Rosella::Memoize::Y(sub($g) {
            return sub($n) {
                if ($n <= 1) { return $n; }
                return $g(+$n - 1) + $g(+$n - 2);
            };
        }))(50);
        $!assert.equal($answer, 12586269025);
    }

    method memoize_proxy() {
        # First, set up the comparison
        $!assert.output_is({
            test_foo(foo, 3);
            test_foo(foo, 3);
            test_foo(foo, 4);
            test_foo(foo, 4);
        }, "in foo\nfoo(3) : 5\nin foo\nfoo(3) : 5\nin foo\nfoo(4) : 6\nin foo\nfoo(4) : 6\n");

        # Now show that we get the same results, but without calling foo as much
        $!assert.output_is({
            my &mem := Rosella::Memoize::memoize_proxy(foo);

            test_foo(&mem, 3);
            test_foo(&mem, 3);
            test_foo(&mem, 4);
            test_foo(&mem, 4);
        }, "in foo\nfoo(3) : 5\nfoo(3) : 5\nin foo\nfoo(4) : 6\nfoo(4) : 6\n");
    }

    method is_memoize_proxy() {
        $!assert.is_false(Rosella::Memoize::is_memoize_proxy(foo));
        my &mem := Rosella::Memoize::memoize_proxy(foo);
        $!assert.is_true(Rosella::Memoize::is_memoize_proxy(&mem));
    }

    method memoize_method() {
        $!assert.output_is({
            my $a := TestClass.new();
            $a.test_method(5);
            $a.test_method(5);
            $a.test_method(6);
            $a.test_method(6);
        }, "test_method: 5\ntest_method: 5\ntest_method: 6\ntest_method: 6\n");
        Rosella::Memoize::memoize_method(TestClass, "test_method");
        $!assert.output_is({
            my $b := TestClass.new();
            $b.test_method(5);
            $b.test_method(5);
            $b.test_method(6);
            $b.test_method(6);
        }, "test_method: 5\ntest_method: 6\n");
        Rosella::Memoize::unmemoize_method(TestClass, "test_method");
    }

    method memoize_method_already_memoized() {
        $!status.unimplemented("Need test for the case where we attempt to memoize a method that is already memoized");
    }

    method unmemoize_method() {
        Rosella::Memoize::memoize_method(TestClass, "test_method");
        $!assert.output_is({
            my $b := TestClass.new();
            $b.test_method(5);
            $b.test_method(5);
            $b.test_method(6);
            $b.test_method(6);
        }, "test_method: 5\ntest_method: 6\n");
        Rosella::Memoize::unmemoize_method(TestClass, "test_method");
        $!assert.output_is({
            my $a := TestClass.new();
            $a.test_method(5);
            $a.test_method(5);
            $a.test_method(6);
            $a.test_method(6);
        }, "test_method: 5\ntest_method: 5\ntest_method: 6\ntest_method: 6\n");
    }

    method unmemoize_method_not_memoized() {
        $!status.unimplemented("Need test for the case where we attempt to unmemoize an un-memoized method");
    }

    method get_proxy_cache() {
        my &mem := Rosella::Memoize::memoize_proxy(add_two);
        my $value := &mem(2);
        $!assert.equal(+$value, 4);
        my $cache := Rosella::Memoize::proxy_cache(&mem);
        my $item := $cache.get_item([2], {});
        $item.update_value(7);
        $value := &mem(2);
        $!assert.equal(+$value, 7);
    }

    method set_proxy_cache() {
        my $cache := Rosella::construct(Rosella::Memoize::Cache::SimpleString);
        my $item := $cache.get_item([2], {});
        $item.update_value(200);
        my &mem := Rosella::Memoize::memoize_proxy(add_two, $cache);
        my $value := &mem(2);
        $!assert.equal(+$value, 200);
    }

    method get_proxy_function() {
        my &mem := Rosella::Memoize::memoize_proxy(add_two);
        my &func := Rosella::Memoize::proxy_function(&mem);
        $!assert.same(add_two, &func);
    }

    method set_proxy_function() {
        my &mem := Rosella::Memoize::memoize_proxy(add_two);
        my $value := &mem(4);
        $!assert.equal($value, 6);
        Rosella::Memoize::proxy_function(&mem, add_three);
        $value := &mem(5);
        $!assert.equal($value, 8);
        $value := &mem(4);
        $!assert.equal($value, 6);
    }
}
