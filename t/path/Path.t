INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/path.pbc");
}

Rosella::Test::test(PathTest);

class PathTest {

    sub new_hash(*%h) { return %h; }

    method test_hash_search() {
        my $q := Rosella::build(Rosella::Path);
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
        $!assert.equal($result, "bar");
    }

    method test_attr_search() {
        my $q := Rosella::build(Rosella::Path);
        my $result := $q.get($q, 'separator');
        $!assert.equal($result, ".");
    }

    method test_hash_attr_search() {
        my $q := Rosella::build(Rosella::Path);
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
        $!assert.equal($result, ".");
    }

    method test_attr_hash_search() {
        $!status.unimplemented("Implement this");
    }

    method test_longest_key_hash_search() {
        my $q := Rosella::build(Rosella::Path);
        my %a := new_hash(
            :d("h")
        );
        %a{"d.e"} := new_hash(:f("g"));

        my $result := $q.get(%a, 'd.e.f');
        $!assert.equal($result, "g");
    }

    method test_longest_key_hash_search_2() {
        my $q := Rosella::build(Rosella::Path);
        my %a := new_hash(
            :d(new_hash(
                :e(new_hash(
                    :h("i")
                ))
            ))
        );
        %a{"d.e"} := new_hash(:f("g"));

        my $result := $q.get(%a, 'd.e.f');
        $!assert.equal($result, "g");
        #$result := $q.get(%a, 'd.e.h');
        #$!assert.equal($result, 'i');
    }
}
