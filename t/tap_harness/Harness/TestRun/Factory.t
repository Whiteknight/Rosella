// Automatically generated test for Class Rosella.Harness.TestRun.Factory
class Test_Rosella_Harness_TestRun_Factory
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.Harness.TestRun.Factory();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestRun.Factory);
    }


    function Factory()
    {
        self.status.verify("Test Rosella.Harness.TestRun.Factory.Factory()");
        var obj = new Rosella.Harness.TestRun.Factory();

        var result = obj.Factory();
    }

    function create_typed()
    {
        self.status.verify("Test Rosella.Harness.TestRun.Factory.create_typed()");
        var obj = new Rosella.Harness.TestRun.Factory();

        var arg_0 = null;
        var result = obj.create_typed(arg_0);
    }

    function add_test_dirs()
    {
        self.status.verify("Test Rosella.Harness.TestRun.Factory.add_test_dirs()");
        var obj = new Rosella.Harness.TestRun.Factory();

        var arg_0 = null;
        var result = obj.add_test_dirs(arg_0);
    }

    function add_test_files()
    {
        self.status.verify("Test Rosella.Harness.TestRun.Factory.add_test_files()");
        var obj = new Rosella.Harness.TestRun.Factory();

        var arg_0 = null;
        var result = obj.add_test_files(arg_0);
    }

    function add_testfile_type()
    {
        self.status.verify("Test Rosella.Harness.TestRun.Factory.add_testfile_type()");
        var obj = new Rosella.Harness.TestRun.Factory();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.add_testfile_type(arg_0, arg_1);
    }

    function get_testfile_type()
    {
        self.status.verify("Test Rosella.Harness.TestRun.Factory.get_testfile_type()");
        var obj = new Rosella.Harness.TestRun.Factory();

        var arg_0 = null;
        var result = obj.get_testfile_type(arg_0);
    }

    function get_sort_routine()
    {
        self.status.verify("Test Rosella.Harness.TestRun.Factory.get_sort_routine()");
        var obj = new Rosella.Harness.TestRun.Factory();

        var arg_0 = null;
        var result = obj.get_sort_routine(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestRun_Factory);
}
