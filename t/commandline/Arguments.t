// Automatically generated test for Class Rosella.CommandLine.Arguments
function create_new(var p_args [slurpy])
{
    return new Rosella.CommandLine.Arguments(null);
}

function create_arg_defs()
{
    var raw_arg_defs = {
        "A"      : "The A flag",
        "B=s"    : "The B scalar",
        "C=[]"   : "The C list",
        "D={}"   : "The D hash",
        "fff"    : "The F flag",
        "ggg=s"  : "The G scalar",
        "hhh=[]" : "The H list",
        "iii={}" : "The I hash"
    };
    return new Rosella.CommandLine.ArgumentDef(raw_arg_defs);
}

class Test_Rosella_CommandLine_Arguments
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.CommandLine.Arguments(null);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.CommandLine.Arguments);
    }

    function program()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.program()");
        var p = new Rosella.CommandLine.Program("foo");
        var obj = new Rosella.CommandLine.Arguments(p);

        var result = obj.program();
        self.assert.same(result, p);
    }

    function parse()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.parse()");
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-A",
            "--",
            "Aye", "Bee", "Cee"
        ];

        // We test parsed results in other methods. Here, just prove that it
        // doesn't error out.
        self.assert.throws_nothing(function() {
            obj.parse(raw_args, arg_defs);
        });
    }

    function remainder()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.remainder()");
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-A",
            "--",
            "Aye", "Bee", "Cee"
        ];

        obj.parse(raw_args, arg_defs);
        self.assert.is_match(obj.remainder(), ["Aye", "Bee", "Cee"]);
    }

    function raw_args()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.get_argument_string()");
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-A",
            "--",
            "Aye", "Bee", "Cee"
        ];

        obj.parse(raw_args, arg_defs);
        self.assert.same(obj.raw_args(), raw_args);
    }

    function get_integer_keyed()
    {
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-A"
        ];

        obj.parse(raw_args, arg_defs);
        self.assert.equal(int(obj["-A"]), true);
        self.assert.equal(int(obj["--fff"]), false);
    }

    function get_string_keyed()
    {
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-B",
            "foo",
            "--ggg",
            "bar"
        ];

        obj.parse(raw_args, arg_defs);
        self.assert.equal(string(obj["-B"]), "foo");
        self.assert.equal(string(obj["--ggg"]), "bar");
    }

    function get_pmc_keyed()
    {
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-C", "foo",
            "-C", "bar",
            "--hhh", "baz",
            "--hhh", "fie"
        ];

        obj.parse(raw_args, arg_defs);
        self.assert.is_match(obj["-C"], ["foo", "bar"]);
        self.assert.is_match(obj["--hhh"], ["baz", "fie"]);
    }

    function get_string_keyed_int()
    {
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "foo", "bar", "baz"
        ];

        obj.parse(raw_args, arg_defs);
        self.assert.equal(string(obj[0]), "foo");
        self.assert.equal(string(obj[1]), "bar");
        self.assert.equal(string(obj[2]), "baz");
    }

    function get_pmc_keyed_int()
    {
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "foo", "bar", "baz"
        ];

        obj.parse(raw_args, arg_defs);
        self.assert.equal(obj[0], "foo");
        self.assert.equal(obj[1], "bar");
        self.assert.equal(obj[2], "baz");
    }

    function get_flag()
    {
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-A"
        ];

        obj.parse(raw_args, arg_defs);
        self.assert.equal(int(obj["-A"]), true);
        self.assert.equal(int(obj["--fff"]), false);
        self.assert.equal(int(obj["--does-not-exist"]), false);
    }

    function get_scalar()
    {
        var obj = create_new();
        var arg_defs = create_arg_defs();

        //"-B foo" and "--ggg bar"
        string raw_args[] = [
            "-B", "foo",
            "--ggg", "bar"
        ];
        obj.parse(raw_args, arg_defs);
        self.assert.equal(obj["-B"], "foo");
        self.assert.equal(obj["--ggg"], "bar");
        self.assert.is_null(obj["--does-not-exist"]);

        // "-Bfoo"
        raw_args = [
            "-Bfoo"
        ];
        obj = create_new();
        obj.parse(raw_args, arg_defs);
        self.assert.equal(obj["-B"], "foo");

        // "-B:foo" and "--ggg:bar"
        raw_args = [
            "-B:foo",
            "--ggg:bar"
        ];
        obj = create_new();
        obj.parse(raw_args, arg_defs);
        self.assert.equal(obj["-B"], "foo");
        self.assert.equal(obj["--ggg"], "bar");
    }

    function get_list()
    {
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-C", "foo",
            "-Cbar",
            "-C:baz",
            "--hhh", "FOO",
            "--hhh:BAR"
        ];

        obj.parse(raw_args, arg_defs);
        self.assert.is_match(obj["-C"], ["foo", "bar", "baz"]);
        self.assert.is_match(obj["--hhh"], ["FOO", "BAR"]);
        self.assert.is_null(obj["--does-not-exist"]);
    }

    function get_hash()
    {
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-D", "foo=A",
            "-Dbar=B",
            "-D:baz=C",
            "--iii", "FOO=A",
            "--iii:BAR=B"
        ];
        obj.parse(raw_args, arg_defs);
        self.assert.is_match(obj["-D"], {"foo":"A", "bar":"B", "baz":"C"});
        self.assert.equal(obj["--iii"], {"FOO":"A", "BAR":"B"});
        self.assert.is_null(obj["--does-not-exist"]);
    }

    function argument_order()
    {
        self.status.verify("Parse flags and positionals in any order");
        var obj = create_new();
        var arg_defs = create_arg_defs();

        string raw_args[] = [
            "-A",
            "foo"
        ];
        obj.parse(raw_args, arg_defs);
        self.assert.equal(int(obj["-A"]), true);
        self.assert.equal(int(obj["--fff"]), false);
        self.assert.equal(obj[0], "foo");

        raw_args = [
            "foo",
            "-A",
            "--fff",
            "bar"
        ];
        obj = create_new();
        obj.parse(raw_args, arg_defs);
        self.assert.equal(int(obj["-A"]), true);
        self.assert.equal(int(obj["--fff"]), true);
        self.assert.equal(obj[0], "foo");
        self.assert.equal(obj[1], "bar");

        raw_args = [
            "foo",
            "bar",
            "-A",
            "--fff"
        ];
        obj = create_new();
        obj.parse(raw_args, arg_defs);
        self.assert.equal(int(obj["-A"]), true);
        self.assert.equal(int(obj["--fff"]), true);
        self.assert.equal(obj[0], "foo");
        self.assert.equal(obj[1], "bar");
    }

    function combination_args()
    {
        var obj = create_new();
        var arg_defs = new Rosella.CommandLine.ArgumentDef({
            "A" : "A",
            "B" : "B",
            "C" : "C",
            "D" : "D"
        });

        obj.parse(["-A", "-BC"], arg_defs);
        self.assert.equal(int(obj["-A"]), true);
        self.assert.equal(int(obj["-B"]), true);
        self.assert.equal(int(obj["-C"]), true);
        self.assert.equal(int(obj["-D"]), false);

        obj = create_new();
        obj.parse(["-ABCD"], arg_defs);
        self.assert.equal(int(obj["-A"]), true);
        self.assert.equal(int(obj["-B"]), true);
        self.assert.equal(int(obj["-C"]), true);
        self.assert.equal(int(obj["-D"]), true);

        obj = create_new();
        obj.parse(["-AD"], arg_defs);
        self.assert.equal(int(obj["-A"]), true);
        self.assert.equal(int(obj["-B"]), false);
        self.assert.equal(int(obj["-C"]), false);
        self.assert.equal(int(obj["-D"]), true);

        obj = create_new();
        obj.parse(["-BCD"], arg_defs);
        self.assert.equal(int(obj["-A"]), false);
        self.assert.equal(int(obj["-B"]), true);
        self.assert.equal(int(obj["-C"]), true);
        self.assert.equal(int(obj["-D"]), true);
    }

    function unknown_args()
    {
        var obj = create_new();
        var arg_defs = new Rosella.CommandLine.ArgumentDef({
            "A" : "A",
            "B" : "B",
            "C" : "C",
            "D" : "D"
        });

        self.assert.throws(function() {
            obj.parse(["-A", "-BC", "-X"], arg_defs);
        });
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/commandline.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_CommandLine_Arguments);
}

