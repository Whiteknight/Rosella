// Automatically generated test for Class Rosella.Harness.TestRun
class Test_Rosella_Harness_TestRun
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.Harness.TestRun();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestRun);
    }


    function TestRun()
    {
        self.status.verify("Test Rosella.Harness.TestRun.TestRun()");
        var obj = new Rosella.Harness.TestRun();

        var arg_0 = null;
        var result = obj.TestRun(arg_0);
    }

    function tests()
    {
        self.status.verify("Test Rosella.Harness.TestRun.tests()");
        var obj = new Rosella.Harness.TestRun();

        var result = obj.tests();
    }

    function max_file_length()
    {
        self.status.verify("Test Rosella.Harness.TestRun.max_file_length()");
        var obj = new Rosella.Harness.TestRun();

        var arg_0 = null;
        var result = obj.max_file_length(arg_0);
    }

    function run_was_success()
    {
        self.status.verify("Test Rosella.Harness.TestRun.run_was_success()");
        var obj = new Rosella.Harness.TestRun();

        var result = obj.run_was_success();
    }

    function files_by_status()
    {
        self.status.verify("Test Rosella.Harness.TestRun.files_by_status()");
        var obj = new Rosella.Harness.TestRun();

        var arg_0 = null;
        var result = obj.files_by_status(arg_0);
    }

    function num_files_by_status()
    {
        self.status.verify("Test Rosella.Harness.TestRun.num_files_by_status()");
        var obj = new Rosella.Harness.TestRun();

        var arg_0 = null;
        var result = obj.num_files_by_status(arg_0);
    }

    function num_tests_by_status()
    {
        self.status.verify("Test Rosella.Harness.TestRun.num_tests_by_status()");
        var obj = new Rosella.Harness.TestRun();

        var arg_0 = null;
        var result = obj.num_tests_by_status(arg_0);
    }

    function num_files()
    {
        self.status.verify("Test Rosella.Harness.TestRun.num_files()");
        var obj = new Rosella.Harness.TestRun();

        var result = obj.num_files();
    }

    function mark_completed()
    {
        self.status.verify("Test Rosella.Harness.TestRun.mark_completed()");
        var obj = new Rosella.Harness.TestRun();

        var result = obj.mark_completed();
    }

    function is_complete()
    {
        self.status.verify("Test Rosella.Harness.TestRun.is_complete()");
        var obj = new Rosella.Harness.TestRun();

        var result = obj.is_complete();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestRun);
}
