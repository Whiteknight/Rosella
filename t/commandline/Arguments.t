// Automatically generated test for Class Rosella.CommandLine.Arguments
function create_new(var p_args [slurpy])
{
    return new Rosella.CommandLine.Arguments(null, p_args);
}

class Test_Rosella_CommandLine_Arguments
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.CommandLine.Arguments(null, []);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.CommandLine.Arguments);
    }

    function program_name()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.program_name()");
        var p = new Rosella.CommandLine.Program("foo");
        var obj = new Rosella.CommandLine.Arguments(p, []);

        string result = obj.program_name();
        self.assert.equal(result, "foo");
    }

    function presort()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.presort()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.presort(arg_0);
    }

    function fetch_flag()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.fetch_flag()");
        var obj = create_new();

        string arg_0 = "";
        int arg_1 = 0;
        var result = obj.fetch_flag(arg_0, arg_1);
    }

    function fetch_scalar()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.fetch_scalar()");
        var obj = create_new();

        string arg_0 = "";
        int arg_1 = 0;
        var result = obj.fetch_scalar(arg_0, arg_1);
    }

    function fetch_scalar_list()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.fetch_scalar_list()");
        var obj = create_new();

        string arg_0 = "";
        int arg_1 = 0;
        var result = obj.fetch_scalar_list(arg_0, arg_1);
    }

    function fetch_pair()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.fetch_pair()");
        var obj = create_new();

        string arg_0 = "foo";
        int arg_1 = 0;
        var result = obj.fetch_pair(arg_0, arg_1);
    }

    function fetch_pair_hash()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.fetch_pair_hash()");
        var obj = create_new();

        string arg_0 = "";
        int arg_1 = 0;
        var result = obj.fetch_pair_hash(arg_0, arg_1);
    }

    function fetch_unparsed()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.fetch_unparsed()");
        var obj = create_new();

        string arg_0 = "";
        var arg_1 = 0;
        var result = obj.fetch_unparsed(arg_0, arg_1);
    }

    function fetch_value()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.fetch_value()");
        var obj = create_new();

        string arg_0 = "";
        var result = obj.fetch_value(arg_0);
    }

    function fetch_positional()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.fetch_positional()");
        var obj = create_new();

        string arg_0 = "";
        int arg_1 = 0;
        var result = obj.fetch_positional(arg_0, arg_1);
    }

    function remainder()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.remainder()");
        var obj = create_new();

        var result = obj.remainder();
    }

    function raw_args()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.raw_args()");
        var obj = create_new();

        var result = obj.raw_args();
    }

    function has_unparsed_args()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.has_unparsed_args()");
        var obj = create_new();

        var result = obj.has_unparsed_args();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/commandline.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_CommandLine_Arguments);
}

