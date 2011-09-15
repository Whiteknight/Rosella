function test_fileresult(var s, var f)
{
    var tf = Rosella.MockObject.default_mock_factory().create_typed(class Rosella.Harness.TestFile);
    tf.expect_method("set_result").with_any_args();
    var fr = new Rosella.Harness.FileResult(tf.mock());
    if (s != null)
        s(tf);
    f(fr);
    tf.verify();
}

class Test_Rosella_Harness_FileResult
{
    function test_new()
    {
        test_fileresult(function(tf) {
        }, function(obj) {
            self.assert.not_null(obj);
            self.assert.instance_of(obj, class Rosella.Harness.FileResult);
        });
    }

    function total_tests()
    {
        self.status.verify("Test Rosella.Harness.FileResult.total_tests()");
        test_fileresult(function(tf) {
        }, function(obj) {
            int result = obj.total_tests();
            self.assert.equal(result, 0);
        });
    }

    // TODO: Need tests where we actually add tests to the fileresult

    function passed_tests()
    {
        self.status.verify("Test Rosella.Harness.FileResult.passed_tests()");
        test_fileresult(function(tf) {
        }, function(obj) {
            var result = obj.passed_tests();
            self.assert.equal(elements(result), 0);
        });
    }

    function list_of_failures()
    {
        self.status.verify("Test Rosella.Harness.FileResult.list_of_failures()");
        test_fileresult(function(tf) {
        }, function(obj) {
            var result = obj.list_of_failures();
            self.assert.equal(elements(result), 0);
        });
    }

    function list_of_todo_passed()
    {
        self.status.verify("Test Rosella.Harness.FileResult.list_of_todo_passed()");
        test_fileresult(function(tf) {
        }, function(obj) {
            var result = obj.list_of_todo_passed();
            self.assert.equal(elements(result), 0);
        });
    }

    function status()
    {
        self.status.verify("Test Rosella.Harness.FileResult.status()");
        test_fileresult(function(tf) {
        }, function(obj) {
            string result = obj.status();
            self.assert.equal(result, "PASSED");
        });
    }

    function error_details()
    {
        self.status.verify("Test Rosella.Harness.FileResult.error_details()");
        test_fileresult(function(tf) {
        }, function(obj) {
            var result = obj.error_details();
            self.assert.is_null(result);
        });
    }

    function get_string()
    {
        self.status.unimplemented("Mocks don't support get_string yet");
        self.status.verify("Test Rosella.Harness.FileResult.get_string()");
        test_fileresult(function(tf) {
        }, function(obj) {
            string result = obj.get_string();
        });
    }

    function mark_test_abort()
    {
        self.status.verify("Test Rosella.Harness.FileResult.mark_test_abort()");
        test_fileresult(function(tf) {
        }, function(obj) {
            var arg_0 = "Test";
            obj.mark_test_abort(arg_0);
            self.assert.equal(obj.error_details(), "Test");
            self.assert.equal(obj.status(), "ABORTED");
        });
    }

    function mark_test_empty()
    {
        self.status.verify("Test Rosella.Harness.FileResult.mark_test_empty()");
        test_fileresult(function(tf) {
        }, function(obj) {
            obj.mark_test_empty();
            self.assert.equal(obj.status(), "EMPTY");
        });
    }

    function add_pass()
    {
        self.status.verify("Test Rosella.Harness.FileResult.add_pass()");
        test_fileresult(function(tf) {
        }, function(obj) {
            string arg_0 = "Test";
            int arg_1 = 1;
            int arg_2 = 0;
            obj.add_pass(arg_0, arg_1, arg_2);
        });
    }

    function add_fail()
    {
        self.status.verify("Test Rosella.Harness.FileResult.add_fail()");
        test_fileresult(function(tf) {
        }, function(obj) {
            string arg_0 = "Test";
            int arg_1 = 1;
            int arg_2 = 0;
            obj.add_fail(arg_0, arg_1, arg_2);
            self.assert.equal(obj.status(), "FAILED");
        });
    }

    function set_plan()
    {
        self.status.verify("Test Rosella.Harness.FileResult.set_plan()");
        test_fileresult(function(tf) {
        }, function(obj) {
            int arg_0 = 1;
            obj.set_plan(arg_0);
            self.assert.equal(obj.total_tests(), 1);
        });
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test", "mockobject");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_FileResult);
}
