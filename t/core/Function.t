INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "assert");
}

Rosella::Test::test(Test::Rosella::Function);

class Foo {
    has $!data;
    method data($data?) {
        if ($data) { $!data := $data };
        $!data;
    }
}

class Test::Rosella::Function {
    method bind() {
        my $f := Rosella::Function::bind(-> $a, $b, $c { ~$a ~ $b ~ $c; }, "a", "B");
        my $result := $f("See");
        $!assert.equal($result, "aBSee");
    }

    method bind_method() {
        my $obj := Foo.new;
        $obj.data("Foo");

        my $f := Rosella::Function::bind_method(method($b, $c) { ~$!data ~ $b ~ $c; }, $obj, "B");
        my $result := $f("See");
        $!assert.equal($result, "FooBSee");
    }

    method wrap() {
    }

    method compose() {
    }
}
