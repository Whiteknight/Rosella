// Automatically generated test for Class Rosella.Harness.FileResult
class Test_Rosella_Harness_FileResult
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.Harness.FileResult();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.FileResult);
    }


    function FileResult()
    {
        self.status.verify("Test Rosella.Harness.FileResult.FileResult()");
        var obj = new Rosella.Harness.FileResult();

        var arg_0 = null;
        var result = obj.FileResult(arg_0);
    }

    function total_tests()
    {
        self.status.verify("Test Rosella.Harness.FileResult.total_tests()");
        var obj = new Rosella.Harness.FileResult();

        var result = obj.total_tests();
    }

    function passed_tests()
    {
        self.status.verify("Test Rosella.Harness.FileResult.passed_tests()");
        var obj = new Rosella.Harness.FileResult();

        var result = obj.passed_tests();
    }

    function list_of_failures()
    {
        self.status.verify("Test Rosella.Harness.FileResult.list_of_failures()");
        var obj = new Rosella.Harness.FileResult();

        var result = obj.list_of_failures();
    }

    function list_of_todo_passed()
    {
        self.status.verify("Test Rosella.Harness.FileResult.list_of_todo_passed()");
        var obj = new Rosella.Harness.FileResult();

        var result = obj.list_of_todo_passed();
    }

    function status()
    {
        self.status.verify("Test Rosella.Harness.FileResult.status()");
        var obj = new Rosella.Harness.FileResult();

        var result = obj.status();
    }

    function error_details()
    {
        self.status.verify("Test Rosella.Harness.FileResult.error_details()");
        var obj = new Rosella.Harness.FileResult();

        var result = obj.error_details();
    }

    function get_string()
    {
        self.status.verify("Test Rosella.Harness.FileResult.get_string()");
        var obj = new Rosella.Harness.FileResult();

        var result = obj.get_string();
    }

    function mark_test_abort()
    {
        self.status.verify("Test Rosella.Harness.FileResult.mark_test_abort()");
        var obj = new Rosella.Harness.FileResult();

        var arg_0 = null;
        var result = obj.mark_test_abort(arg_0);
    }

    function mark_test_empty()
    {
        self.status.verify("Test Rosella.Harness.FileResult.mark_test_empty()");
        var obj = new Rosella.Harness.FileResult();

        var result = obj.mark_test_empty();
    }

    function add_pass()
    {
        self.status.verify("Test Rosella.Harness.FileResult.add_pass()");
        var obj = new Rosella.Harness.FileResult();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.add_pass(arg_0, arg_1, arg_2);
    }

    function add_fail()
    {
        self.status.verify("Test Rosella.Harness.FileResult.add_fail()");
        var obj = new Rosella.Harness.FileResult();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.add_fail(arg_0, arg_1, arg_2);
    }

    function set_plan()
    {
        self.status.verify("Test Rosella.Harness.FileResult.set_plan()");
        var obj = new Rosella.Harness.FileResult();

        var arg_0 = null;
        var result = obj.set_plan(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_FileResult);
}
