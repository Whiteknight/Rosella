// Automatically generated test for Class Rosella.Harness.TestRun
class Test_Rosella_Harness_TestRun
{
    function test_new()
    {
        var obj = new Rosella.Harness.TestRun([]);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestRun);
    }

    function tests()
    {
        self.status.verify("Test Rosella.Harness.TestRun.tests()");
        var arg_0 = "Test";
        var obj = new Rosella.Harness.TestRun(arg_0);

        var result = obj.tests();
        self.assert.same(result, arg_0);
    }

    function max_file_length()
    {
        self.status.verify("Test Rosella.Harness.TestRun.max_file_length()");
        var obj = new Rosella.Harness.TestRun(["foo", "foobar", "foobarbaz"]);

        int arg_0 = 0;
        var result = obj.max_file_length(arg_0);
        self.assert.equal(result, 9);

        arg_0 = 10;
        result = obj.max_file_length(arg_0);
        self.assert.equal(result, 10);

        arg_0 = 8;
        result = obj.max_file_length(arg_0);
        self.assert.equal(result, 9);
    }

    function run_was_success()
    {
        self.status.verify("Test Rosella.Harness.TestRun.run_was_success()");
        var obj = new Rosella.Harness.TestRun([]);

        var result = obj.run_was_success();
        self.assert.is_true(result);
    }

    function files_by_status()
    {
        self.status.verify("Test Rosella.Harness.TestRun.files_by_status()");
        var obj = new Rosella.Harness.TestRun([]);

        var arg_0 = "Foo";
        var result = obj.files_by_status(arg_0);
        self.assert.equal(result.count(), 0);
    }

    function files_by_status_with_files()
    {
        self.status.verify("Test Rosella.Harness.TestRun.files_by_status()");
        self.status.unimplemented("Need a test with actual files");
        //var obj = new Rosella.Harness.TestRun([]);

        //var arg_0 = "Foo";
        //var result = obj.files_by_status(arg_0);
        //self.assert.equal(elements(result), 0);
    }

    function num_files_by_status()
    {
        self.status.verify("Test Rosella.Harness.TestRun.num_files_by_status()");
        var obj = new Rosella.Harness.TestRun([]);

        var arg_0 = "Foo";
        int result = obj.num_files_by_status(arg_0);
        self.assert.equal(result, 0);
    }

    function num_tests_by_status()
    {
        self.status.verify("Test Rosella.Harness.TestRun.num_tests_by_status()");
        var obj = new Rosella.Harness.TestRun([]);

        var arg_0 = "Foo";
        var result = obj.num_tests_by_status(arg_0);
    }

    function num_files()
    {
        self.status.verify("Test Rosella.Harness.TestRun.num_files()");
        var obj = new Rosella.Harness.TestRun([]);

        int result = obj.num_files();
        self.assert.equal(result, 0);
    }

    function mark_completed()
    {
        self.status.verify("Test Rosella.Harness.TestRun.mark_completed()");
        var obj = new Rosella.Harness.TestRun([]);

        obj.mark_completed();
    }

    function is_complete()
    {
        self.status.verify("Test Rosella.Harness.TestRun.is_complete()");
        var obj = new Rosella.Harness.TestRun([]);

        int result = obj.is_complete();
        self.assert.equal(result, false);

        obj.mark_completed();
        result = obj.is_complete();
        self.assert.equal(result, true);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestRun);
}
