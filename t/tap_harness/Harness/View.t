// Automatically generated test for Class Rosella.Harness.View
class Test_Rosella_Harness_View
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.Harness.View();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.View);
    }


    function View()
    {
        self.status.verify("Test Rosella.Harness.View.View()");
        var obj = new Rosella.Harness.View();

        var result = obj.View();
    }

    function add_run()
    {
        self.status.verify("Test Rosella.Harness.View.add_run()");
        var obj = new Rosella.Harness.View();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.add_run(arg_0, arg_1);
    }

    function start_test()
    {
        self.status.verify("Test Rosella.Harness.View.start_test()");
        var obj = new Rosella.Harness.View();

        var arg_0 = null;
        var result = obj.start_test(arg_0);
    }

    function end_test()
    {
        self.status.verify("Test Rosella.Harness.View.end_test()");
        var obj = new Rosella.Harness.View();

        var arg_0 = null;
        var result = obj.end_test(arg_0);
    }

    function get_result_status()
    {
        self.status.verify("Test Rosella.Harness.View.get_result_status()");
        var obj = new Rosella.Harness.View();

        var arg_0 = null;
        var result = obj.get_result_status(arg_0);
    }

    function test_run_complete()
    {
        self.status.verify("Test Rosella.Harness.View.test_run_complete()");
        var obj = new Rosella.Harness.View();

        var arg_0 = null;
        var result = obj.test_run_complete(arg_0);
    }

    function show_results()
    {
        self.status.verify("Test Rosella.Harness.View.show_results()");
        var obj = new Rosella.Harness.View();

        var result = obj.show_results();
    }

    function show_results_summary()
    {
        self.status.verify("Test Rosella.Harness.View.show_results_summary()");
        var obj = new Rosella.Harness.View();

        var result = obj.show_results_summary();
    }

    function show_error_detail()
    {
        self.status.verify("Test Rosella.Harness.View.show_error_detail()");
        var obj = new Rosella.Harness.View();

        var result = obj.show_error_detail();
    }

    function show_current_test_progress()
    {
        self.status.verify("Test Rosella.Harness.View.show_current_test_progress()");
        var obj = new Rosella.Harness.View();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.show_current_test_progress(arg_0, arg_1);
    }

    function show_failure_detail()
    {
        self.status.verify("Test Rosella.Harness.View.show_failure_detail()");
        var obj = new Rosella.Harness.View();

        var result = obj.show_failure_detail();
    }

    function debug()
    {
        self.status.verify("Test Rosella.Harness.View.debug()");
        var obj = new Rosella.Harness.View();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.debug(arg_0, arg_1);
    }

    function show_result_headline()
    {
        self.status.verify("Test Rosella.Harness.View.show_result_headline()");
        var obj = new Rosella.Harness.View();

        var arg_0 = null;
        var result = obj.show_result_headline(arg_0);
    }

    function get_all_files_by_status()
    {
        self.status.verify("Test Rosella.Harness.View.get_all_files_by_status()");
        var obj = new Rosella.Harness.View();

        var arg_0 = null;
        var result = obj.get_all_files_by_status(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_View);
}
