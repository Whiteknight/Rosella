INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/query.pbc");
}

Rosella::Test::test(PathTest);

class PathTest {

    sub new_hash(*%h) { return %h; }

    method test_hash_search() {
        my $q := Rosella::build(Rosella::Query::Path);
        my %a := new_hash(
            :b(new_hash(
                :foo("bar")
            )),
            :c(new_hash(
                :baz("fie")
            )),
            :d("h")
        );
        my $result := $q.get(%a, 'b.foo');
        Assert::equal($result, "bar");
    }

    method test_attr_search() {
        my $q := Rosella::build(Rosella::Query::Path);
        my $result := $q.get($q, 'separator');
        Assert::equal($result, ".");
    }

    method test_hash_attr_search() {
        my $q := Rosella::build(Rosella::Query::Path);
        my %a := new_hash(
            :b(new_hash(
                :foo($q)
            )),
            :c(new_hash(
                :baz("fie")
            )),
            :d("h")
        );
        my $result := $q.get(%a, 'b.foo.separator');
        Assert::equal($result, ".");
    }

    method test_attr_hash_search() {
        $!context.unimplemented("Implement this");
    }

    method test_longest_key_hash_search() {
        my $q := Rosella::build(Rosella::Query::Path);
        my %a := new_hash(
            :d("h")
        );
        %a{"d.e"} := new_hash(:f("g"));

        my $result := $q.get(%a, 'd.e.f');
        Assert::equal($result, "g");
    }

    method test_longest_key_hash_search_2() {
        my $q := Rosella::build(Rosella::Query::Path);
        my %a := new_hash(
            :d(new_hash(
                :e(new_hash(
                    :h("i")
                ))
            ))
        );
        %a{"d.e"} := new_hash(:f("g"));

        my $result := $q.get(%a, 'd.e.f');
        Assert::equal($result, "g");
        $result := $q.get(%a, 'd.e.h');
        Assert::equal($result, 'i');
    }
}
