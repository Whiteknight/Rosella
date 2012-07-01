INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "string");
}

Rosella::Test::test(Test::String::FormatPrinter);

class Test::String::FormatPrinter {
    method format_array() {
        my $value := Rosella::String::format('{0} worl{1}', "hello,", "d!");
        $!assert.equal($value, "hello, world!");
    }

    method format_array_brace() {
        my $value := Rosella::String::format('{{}{{}');
        $!assert.equal($value, '{}{}');
    }

    method format() {
        $!status.unimplemented("TODO");
    }

    method format_hash() {
        my %hash;
        %hash<foo> := "FOO";
        %hash<bar> := "BAR";
        %hash<baz> := "BAZ";

        my $value := Rosella::String::format_obj('X{foo}Y{bar}Z{baz}W', %hash);
        $!assert.equal($value, "XFOOYBARZBAZW");
    }

    method format_subformats() {
        my %hash;
        %hash<foo> := 1;
        %hash<bar> := 2;
        %hash<baz> := 3;

        my $value := Rosella::String::format_obj('{foo:02d}-{bar:04d}-{baz:4s}', %hash);
        $!assert.equal($value, "01-0002-   3");
    }
}
