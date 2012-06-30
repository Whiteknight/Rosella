INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "string");
}

Rosella::Test::test(Test::String::FormatPrinter);

class Test::String::FormatPrinter {
    method format() {
        my $value := Rosella::String::format('{0} worl{1}', "hello,", "d!");
        $!assert.equal($value, "hello, world!");
    }

    method format_obj() {
        $!status.unimplemented("TODO");
    }
}
