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
        $!status.unimplemented("Need test for this");
    }

    method memoize_method() {
        $!status.unimplemented("Need test for this");
    }

    method unmemoize_method() {
        $!status.unimplemented("Need test for this");
    }

    method get_proxy_cache() {
        $!status.unimplemented("Need test for this");
    }

    method set_proxy_cache() {
        $!status.unimplemented("Need test for this");
    }

    method get_proxy_func() {
        $!status.unimplemented("Need test for this");
    }

    method set_proxy_cache() {
        $!status.unimplemented("Need test for this");
    }
}
