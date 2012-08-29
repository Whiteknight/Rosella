// Automatically generated test for Class Rosella.CommandLine.ProgramMode
class Test_Rosella_CommandLine_ProgramMode
{
    function test_new()
    {
        var obj = new Rosella.CommandLine.ProgramMode("");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.CommandLine.ProgramMode);
    }

    function set_function()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.set_function()");
        var obj = new Rosella.CommandLine.ProgramMode("");

        var arg_0 = function(var args) { };
        var result = obj.set_function(arg_0);
    }

    function set_usage()
    {
        // TODO: This is very fragile, I don't like matching exact strings, especially
        // when there's whitespace involved.
        var obj = new Rosella.CommandLine.ProgramMode("foo");
        obj.set_usage("This is a test");
        string usage = obj.get_usage("foo");
        self.assert.str_equal(usage, "       foo This is a test\n");
    }

    function get_usage()
    {
        self.status.unimplemented("Need to set up some conditions to test with");
    }

    function can_accept()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.can_accept()");
        var obj = new Rosella.CommandLine.ProgramMode("");

        var arg_0 = null;
        var result = obj.can_accept(arg_0);
    }

    function main_function()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.main_function()");
        var obj = new Rosella.CommandLine.ProgramMode("");

        var result = obj.main_function();
    }

    function require_flag()
    {
        self.status.unimplemented("This");
    }

    function require_value()
    {
        self.status.unimplemented("This");
    }

    function require_condition()
    {
        self.status.unimplemented("This");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/commandline.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_CommandLine_ProgramMode);
}
