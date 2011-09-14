function view_test(var f)
{
    var handle = new 'StringHandle';
    handle.open("foo.txt", "rw");
    var obj = new Rosella.Harness.View(handle);
    f(obj);
    return handle.readall();
}

class Test_Rosella_Harness_View
{
    function test_new()
    {
        var obj = new Rosella.Harness.View();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.View);
    }

    function add_run()
    {
        self.status.unimplemented("Need tests for .add_run()");
        self.status.verify("Test Rosella.Harness.View.add_run()");
        view_test(function(obj) {
            var arg_0 = null;
            var arg_1 = null;
            var result = obj.add_run(arg_0, arg_1);
        });
    }

    function start_test()
    {
        self.status.unimplemented("Need tests for .start_test()");
        self.status.verify("Test Rosella.Harness.View.start_test()");
        view_test(function(obj) {
            string arg_0 = "Test";
            obj.start_test(arg_0);
        });
    }

    function end_test()
    {
        self.status.unimplemented("Need tests for .end_test()");
        self.status.verify("Test Rosella.Harness.View.end_test()");
        view_test(function(obj) {
            var arg_0 = null;
            var result = obj.end_test(arg_0);
        });
    }

    function get_result_status()
    {
        self.status.unimplemented("Need tests for .get_result_status()");
        self.status.verify("Test Rosella.Harness.View.get_result_status()");
        view_test(function(obj) {
            var arg_0 = null;
            var result = obj.get_result_status(arg_0);
        });
    }

    function test_run_complete()
    {
        self.status.unimplemented("Need tests for .test_run_complete()");
        self.status.verify("Test Rosella.Harness.View.test_run_complete()");
        view_test(function(obj) {
            var arg_0 = null;
            var result = obj.test_run_complete(arg_0);
        });
    }

    function show_results()
    {
        self.status.verify("Test Rosella.Harness.View.show_results()");
        view_test(function(obj) {
            var result = obj.show_results();
        });
    }

    function show_results_summary()
    {
        self.status.verify("Test Rosella.Harness.View.show_results_summary()");
        view_test(function(obj) {
            var result = obj.show_results_summary();
        });
    }

    function show_error_detail()
    {
        self.status.verify("Test Rosella.Harness.View.show_error_detail()");
        view_test(function(obj) {
            var result = obj.show_error_detail();
        });
    }

    function show_current_test_progress()
    {
        self.status.verify("Test Rosella.Harness.View.show_current_test_progress()");
        view_test(function(obj) {
            int arg_0 = 1;
            int arg_1 = 2;
            var result = obj.show_current_test_progress(arg_0, arg_1);
        });
    }

    function show_failure_detail()
    {
        self.status.verify("Test Rosella.Harness.View.show_failure_detail()");
        view_test(function(obj) {
            var result = obj.show_failure_detail();
        });
    }

    function show_result_headline()
    {
        self.status.verify("Test Rosella.Harness.View.show_result_headline()");
        view_test(function(obj) {
            var arg_0 = "Test";
            obj.show_result_headline(arg_0);
        });
    }

    function get_all_files_by_status()
    {
        self.status.verify("Test Rosella.Harness.View.get_all_files_by_status()");
        view_test(function(obj) {
            var arg_0 = "Foo";
            var result = obj.get_all_files_by_status(arg_0);
            self.assert.equal(elements(result), 0);
        });
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_View);
}
