// Automatically generated test for Class Rosella.CommandLine.Program
class Test_Rosella_CommandLine_Program
{
    function test_new()
    {
        var obj = new Rosella.CommandLine.Program("");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.CommandLine.Program);
    }

    function on_error()
    {
        self.status.verify("Test Rosella.CommandLine.Program.on_error()");
        var obj = new Rosella.CommandLine.Program("test");

        var arg_0 = function(var e) { };
        var result = obj.on_error(arg_0);
    }

    function add_mode()
    {
        self.status.verify("Test Rosella.CommandLine.Program.add_mode()");
        var obj = new Rosella.CommandLine.Program("");

        string arg_0 = "test";
        var result = obj.add_mode(arg_0);
        self.assert.instance_of(result, class Rosella.CommandLine.ProgramMode);
    }

    function default_mode()
    {
        self.status.verify("Test Rosella.CommandLine.Program.default_mode()");
        var obj = new Rosella.CommandLine.Program("");

        var result = obj.default_mode();
        self.assert.instance_of(result, class Rosella.CommandLine.ProgramMode);
    }

    // TODO: We need lots of tests for running programs, including mode
    // dispatch, error recovery, etc.

    function run()
    {
        self.status.unimplemented("Test .run()");
        self.status.verify("Test Rosella.CommandLine.Program.run()");
        var obj = new Rosella.CommandLine.Program("");

        var arg_0 = null;
        var result = obj.run(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/commandline.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_CommandLine_Program);
}
