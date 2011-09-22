// Automatically generated test for Class Rosella.CommandLine.ProgramMode
class Test_Rosella_CommandLine_ProgramMode
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.CommandLine.ProgramMode();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.CommandLine.ProgramMode);
    }


    function ProgramMode()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.ProgramMode()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var result = obj.ProgramMode(arg_0);
    }

    function set_function()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.set_function()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var result = obj.set_function(arg_0);
    }

    function set_flag()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.set_flag()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var result = obj.set_flag(arg_0);
    }

    function require_positional()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.require_positional()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.require_positional(arg_0, arg_1);
    }

    function require_args()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.require_args()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var result = obj.require_args(arg_0);
    }

    function optional_args()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.optional_args()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var result = obj.optional_args(arg_0);
    }

    function can_accept()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.can_accept()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var result = obj.can_accept(arg_0);
    }

    function match_positionals()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.match_positionals()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.match_positionals(arg_0, arg_1);
    }

    function match_args()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.match_args()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.match_args(arg_0, arg_1, arg_2);
    }

    function fetch_all_args()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.fetch_all_args()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var arg_0 = null;
        var result = obj.fetch_all_args(arg_0);
    }

    function main_function()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.main_function()");
        var obj = new Rosella.CommandLine.ProgramMode();

        var result = obj.main_function();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/commandline.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_CommandLine_ProgramMode);
}
