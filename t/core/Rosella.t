INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(RosellaTest);

class My::Test::Class {
    method sum($a, $b) { return $a + $b; }
    method value() { return -3; }
}

class My::Test::With::BUILD {
    has $!value;
    method BUILD($num) { $!value := $num + 5; }
    method value() { $!value // -1; } #/
}

class My::Test::With::Constructor {
    has $!value;
    method Constructor($num) { $!value := $num + 7; }
    method value() { $!value // -2; } #/
}

class RosellaTest {
    method alloc() {
        my $item := Rosella::alloc(My::Test::With::Constructor);
        $!assert.instance_of($item, My::Test::With::Constructor);
        $!assert.equal($item.value, -2);
    }

    method build() {
        my $item := Rosella::construct(My::Test::Class);
        $!assert.instance_of($item, My::Test::Class);
    }

    method build_BUILD_args() {
        my $item := Rosella::build(My::Test::With::BUILD, 3);
        $!assert.equal($item.value, 8);
    }

    method build_without_BUILD() {
        my $item := Rosella::build(My::Test::With::Constructor, 3);
        $!assert.equal($item.value, -2);
    }

    method construct_args() {
        my $item := Rosella::construct(My::Test::With::Constructor, 4);
        $!assert.equal($item.value, 11);
    }

    method construct_without_constructor() {
        my $item := Rosella::construct(My::Test::Class, 5);
        $!assert.equal($item.value, -3);
    }

    method get_type_name() {
        my $name := Rosella::get_type_name(My::Test::Class);
        $!assert.equal($name, "parrot;My;Test;Class");
    }

    method get_type_class() {
        my $class := Rosella::get_type_class(My::Test::With::Constructor);
        $!assert.instance_of($class, "Class");
        $!assert.equal($class.name, "Constructor");
    }

    method isa_type() {
        my $item := Rosella::construct(My::Test::Class);
        $!assert.is_true(Rosella::isa_type(My::Test::Class, $item));
        $!assert.is_false(Rosella::isa_type(My::Test::With::Constructor, $item));
    }

    method initialize_rosella() {
        $!status.unimplemented("this");
    }

    method load_rosella_library() {
        $!status.unimplemented("this");
    }

    method load_bytecode_file() {
        $!status.unimplemented("this");
    }

    method init_bytecode() {
        $!status.unimplemented("this");
    }

    method find_named_method() {
        my $item := Rosella::alloc(My::Test::Class);
        my $meth := Rosella::find_named_method($item, "value");
        $!assert.not_null($meth);
        $meth := Rosella::find_named_method($item, "foo");
        $!assert.is_null($meth);
    }

    method invoke_method() {
        my $item := Rosella::alloc(My::Test::Class);
        my $result := Rosella::invoke_method($item, "sum", [2, 3], {});
        $!assert.equal($result, 5);
    }

    method invoke_method_FAIL() {
        my $item := Rosella::alloc(My::Test::Class);
        $!assert.throws: {
            my $result := Rosella::invoke_method($item, "foo", [], {});
        };
    }

    method get_unique_count() {
        my $a := Rosella::get_unique_count();
        my $b := Rosella::get_unique_count();
        $!assert.not_equal($a, $b);
    }
}
