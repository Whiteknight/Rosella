INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::Test);

sub hash(*%h) { %h }

class Test::Test {
    method test() {
        $!assert.output_is({
            Rosella::Test::test(My::Subtest);
        }, [
            "1..1",
            "ok 1 - child_test1",
            "# You passed all 1 tests",
            ""
        ]);
    }

    method test_vector() {
        $!assert.output_is({
            Rosella::Test::test_vector(method(@data) {
                $!assert.equal(@data[0], @data[1]);
            }, [
                [1, 1],
                [2, 2],
                [3, 3]
            ]);
        }, [
            "1..3",
            "ok 1 - test 1",
            "ok 2 - test 2",
            "ok 3 - test 3",
            "# You passed all 3 tests",
            ""
        ]);
    }

    method test_vector_hash() {
        $!assert.output_is({
            Rosella::Test::test_vector(method(@data) {
                $!assert.equal(@data[0], @data[1]);
            }, hash(
                :first_item([1, 1]),
                :second_item([2, 2]),
                :third_item([3, 3])
            ));
        }, [
            "1..3",
            "ok 1 - first_item",
            "ok 2 - second_item",
            "ok 3 - third_item",
            "# You passed all 3 tests",
            ""
        ]);
    }
}

class My::Subtest {
    method child_test1() {}
}
