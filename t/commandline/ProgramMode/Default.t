// Automatically generated test for Class Rosella.CommandLine.ProgramMode.Default
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.CommandLine.ProgramMode.Default(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_CommandLine_ProgramMode_Default
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.CommandLine.ProgramMode.Default();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.CommandLine.ProgramMode.Default);
    }

    function get_usage()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.Default.get_usage()");
        self.status.unimplemented("Find a strategy for testing usage messages");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.get_usage(arg_0);
    }

    function require_flag()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.Default.require_flag()");
        var obj = create_new();

        self.assert.throws(function() {
            var result = obj.require_flag("");
        });
    }

    function require_value()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.Default.require_value()");
        var obj = create_new();

        self.assert.throws(function() {
            var result = obj.require_value("A", "B");
        });
    }

    function require_condition()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.Default.require_condition()");
        var obj = create_new();

        self.assert.throws(function() {
            var result = obj.require_condition(null);
        });
    }

    function require_positionals()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.Default.require_positionals()");
        var obj = create_new();

        self.assert.throws(function() {
            var result = obj.require_positionals(2, 2);
        });
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Set options on the Suite, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/commandline.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_CommandLine_ProgramMode_Default, initialize_test:[named("initialize")]);
}
