// Automatically generated test for Class Rosella.CommandLine.Arguments
function create_new(var p_args [slurpy])
{
    return new Rosella.CommandLine.Arguments(null);
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
        self.status.unimplemented("TODO");
    }

    function get_argument_string()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.get_argument_string()");
        var obj = create_new();
        self.status.unimplemented("TODO");
    }

    function get_argument_definitions()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.get_argument_definitions()");
        var obj = create_new();
        self.status.unimplemented("TODO");
    }

    function remainder()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.remainder()");
        var obj = create_new();
        self.status.unimplemented("TODO");
    }

    function raw_args()
    {
        self.status.verify("Test Rosella.CommandLine.Arguments.get_argument_string()");
        var obj = create_new();
        self.status.unimplemented("TODO");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/commandline.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_CommandLine_Arguments);
}

