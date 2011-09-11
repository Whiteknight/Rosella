// Automatically generated test for Class Rosella.Harness
class Test_Rosella_Harness
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.Harness();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness);
    }


    function Harness()
    {
        self.status.verify("Test Rosella.Harness.Harness()");
        var obj = new Rosella.Harness();

        var result = obj.Harness();
    }

    function add_testfile_type()
    {
        self.status.verify("Test Rosella.Harness.add_testfile_type()");
        var obj = new Rosella.Harness();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.add_testfile_type(arg_0, arg_1);
    }

    function add_test_dirs()
    {
        self.status.verify("Test Rosella.Harness.add_test_dirs()");
        var obj = new Rosella.Harness();

        var arg_0 = null;
        var result = obj.add_test_dirs(arg_0);
    }

    function add_test_files()
    {
        self.status.verify("Test Rosella.Harness.add_test_files()");
        var obj = new Rosella.Harness();

        var arg_0 = null;
        var result = obj.add_test_files(arg_0);
    }

    function setup_test_run()
    {
        self.status.verify("Test Rosella.Harness.setup_test_run()");
        var obj = new Rosella.Harness();

        var result = obj.setup_test_run();
    }

    function default_view()
    {
        self.status.verify("Test Rosella.Harness.default_view()");
        var obj = new Rosella.Harness();

        var result = obj.default_view();
    }

    function run()
    {
        self.status.verify("Test Rosella.Harness.run()");
        var obj = new Rosella.Harness();

        var result = obj.run();
    }

    function run_internal()
    {
        self.status.verify("Test Rosella.Harness.run_internal()");
        var obj = new Rosella.Harness();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var arg_3 = null;
        var result = obj.run_internal(arg_0, arg_1, arg_2, arg_3);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness);
}
