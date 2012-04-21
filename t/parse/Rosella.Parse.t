// Automatically generated test for NameSpace Rosella.Parse
class Test_Rosella_Parse
{
    function setup_parse()
    {
        self.status.verify("Test Rosella.Parse.setup_parse()");
        using Rosella.Parse.setup_parse;

        string arg_0 = "foo";
        :(string str, var s, var b, int len) = setup_parse(arg_0);
        self.assert.equal(arg_0, str);
        self.assert.instance_of(s, 'ResizableIntegerArray');
        self.assert.equal(elements(s), 0);
        self.assert.instance_of(b, 'StringIterator');
        self.assert.is_true(b);
        self.assert.equal(len, 3);
    }

    function parse_quoted()
    {
        self.status.verify("Test Rosella.Parse.parse_quoted()");
        using Rosella.Parse.parse_quoted;

        string str = "foo'bar";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = ord("'");
        var arg_1 = str;
        var arg_2 = s;
        var arg_3 = b;
        var arg_4 = len;
        string result = parse_quoted(arg_0, arg_1, arg_2, arg_3, arg_4);
        self.assert.equal(result, "foo");
    }

    function parse_string()
    {
        self.status.verify("Test Rosella.Parse.parse_string()");
        using Rosella.Parse.parse_string;

        string str = "foo'bar";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = ord("'");
        var arg_1 = str;
        var arg_2 = s;
        var arg_3 = b;
        var arg_4 = len;
        string result = parse_string(arg_0, arg_1, arg_2, arg_3, arg_4);
        self.assert.equal(result, "foo");
    }

    function parse_string_escapes()
    {
        self.status.verify("Test Rosella.Parse.parse_string() with escapes");
        self.status.unimplemented("Test parse_string with escapes");
    }

    function parse_alphanumeric()
    {
        self.status.verify("Test Rosella.Parse.parse_alphanumeric()");
        using Rosella.Parse.parse_alphanumeric;

        string str = "f1o2o3+bar+baz";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        string result = parse_alphanumeric(arg_0, arg_1, arg_2, arg_3);
        self.assert.equal(result, "f1o2o3");
    }

    function parse_alpha()
    {
        self.status.verify("Test Rosella.Parse.parse_alpha()");
        using Rosella.Parse.parse_alpha;

        string str = "foo3+bar+baz";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        string result = parse_alpha(arg_0, arg_1, arg_2, arg_3);
        self.assert.equal(result, "foo");
    }

    function parse_number()
    {
        self.status.verify("Test Rosella.Parse.parse_number()");
        using Rosella.Parse.parse_number;

        string str = "234";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = ord("1");
        var arg_1 = str;
        var arg_2 = s;
        var arg_3 = b;
        var arg_4 = len;
        int result = parse_number(arg_0, arg_1, arg_2, arg_3, arg_4);
        self.assert.equal(result, 1234);
    }

    function parse_hexadecimal()
    {
        self.status.verify("Test Rosella.Parse.parse_hexadecimal()");
        using Rosella.Parse.parse_hexadecimal;

        string str = "feGARBANZO";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        int result = parse_hexadecimal(arg_0, arg_1, arg_2, arg_3);
        self.assert.equal(result, 254);
    }

    function parse_integer()
    {
        self.status.verify("Test Rosella.Parse.parse_integer()");
        using Rosella.Parse.parse_integer;

        string str = "123+456+789";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        int result = parse_integer(arg_0, arg_1, arg_2, arg_3);
        self.assert.equal(result, 123);
    }

    function parse_octal()
    {
        self.status.verify("Test Rosella.Parse.parse_octal()");
        using Rosella.Parse.parse_octal;

        string str = "755+bar+baz";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        int result = parse_octal(arg_0, arg_1, arg_2, arg_3);
        self.assert.equal(result, 493);
    }

    function error_unknown_char()
    {
        self.status.verify("Test Rosella.Parse.error_unknown_char()");
        using Rosella.Parse.error_unknown_char;

        self.assert.throws(function() {
            var arg_0 = ord('A');
            var arg_1 = "foo";
            var arg_2 = 123;
            error_unknown_char(arg_0, arg_1, arg_2);
        });
    }

    function parse_until()
    {
        self.status.verify("Test Rosella.Parse.parse_until()");
        using Rosella.Parse.parse_until;

        string str = "alphaNUMB3R+!@#?FooBarBaz";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        var arg_4 = ord("?");
        :(string results, int resulti) = parse_until(arg_0, arg_1, arg_2, arg_3, arg_4);
        self.assert.equal(results, "alphaNUMB3R+!@#");
        self.assert.equal(resulti, ord("?"));
    }

    function parse_until__null()
    {
        self.status.verify("Test Rosella.Parse.parse_until() with end-of-string");
        using Rosella.Parse.parse_until;

        string str = "alphaNUMB3R+!@#?FooBarBaz";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        var arg_4 = ord(">"); // Not in the string
        :(string results, int resulti) = parse_until(arg_0, arg_1, arg_2, arg_3, arg_4);
        self.assert.equal(results, "alphaNUMB3R+!@#?FooBarBaz");
        self.assert.equal(resulti, 0);
    }

    function parse_until_either()
    {
        self.status.verify("Test Rosella.Parse.parse_until_either()");
        using Rosella.Parse.parse_until_either;

        string str = "alphaNUMB3R+!@#?FooBarBaz";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        var arg_4 = ord("?");
        var arg_5 = ord("N");
        :(string results, int resulti) = parse_until_either(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5);
        self.assert.equal(results, "alpha");
        self.assert.equal(resulti, ord("N"));
    }

    function parse_until_either__null()
    {
        self.status.verify("Test Rosella.Parse.parse_until_either() with end-of-string");
        using Rosella.Parse.parse_until_either;

        string str = "alphaNUMB3R+!@#?FooBarBaz";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        var arg_4 = ord(">");
        var arg_5 = ord("<");
        :(string results, int resulti) = parse_until_either(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5);
        self.assert.equal(results, "alphaNUMB3R+!@#?FooBarBaz");
        self.assert.equal(resulti, 0);
    }

    function parse_remainder()
    {
        self.status.verify("Test Rosella.Parse.parse_remainder()");
        using Rosella.Parse.parse_remainder;

        string str = "FooBarBaz";
        :(str, var s, var b, int len) = Rosella.Parse.setup_parse(str);

        var arg_0 = str;
        var arg_1 = s;
        var arg_2 = b;
        var arg_3 = len;
        string result = parse_remainder(arg_0, arg_1, arg_2, arg_3);
        self.assert.equal(result, "FooBarBaz");
    }

    function parse_repeat()
    {
        self.status.verify("Test Rosella.Parse.parse_repeat()");
        self.status.unimplemented("Test for parse_repeat");
        using Rosella.Parse.parse_repeat;

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var arg_3 = null;
        var arg_4 = null;
        var result = parse_repeat(arg_0, arg_1, arg_2, arg_3, arg_4);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Initialize the context, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/parse.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Parse, initialize_test:[named("initialize")]);
}
