// Automatically generated test for Class Rosella.Harness.TapParser
function test_parse(var data, var setup)
{
    var s = Rosella.Query.iterable(data);
    var factory = Rosella.MockObject.default_mock_factory();
    var rcont = factory.create_typed(class Rosella.Harness.FileResult);
    var vcont = factory.create_typed(class Rosella.Harness.View);
    var obj = new Rosella.Harness.TapParser();

    setup(rcont, vcont);
    obj.parse(s, vcont.mock(), rcont.mock());
    rcont.verify();
    vcont.verify();
}

class Test_Rosella_Harness_TapParser
{
    function test_new()
    {
        var obj = new Rosella.Harness.TapParser();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TapParser);
    }

    function parse_empty()
    {
        test_parse([""], function(r, v) {
            r.expect_method("mark_test_empty").once().with_no_args();
        });
    }

    function parse_simple_success()
    {
        test_parse(["1..1", "ok 1"], function(r, v) {
            r.expect_method("set_plan").once().with_args(1);
            r.expect_get("num_tests").once().will_return(1);
            v.expect_method("show_current_test_progress").once().with_args(1, 1);
            r.expect_method("add_pass").once().with_args("", 1, 0);
        });
    }

    function parse_several_success()
    {
        test_parse(["1..3", "ok 1", "ok 2", "ok 3"], function(r, v) {
            r.expect_method("set_plan").once().with_args(3);
            r.expect_get("num_tests").exactly(3).will_return(3);
            v.expect_method("show_current_test_progress").once().with_args(1, 3);
            v.expect_method("show_current_test_progress").once().with_args(2, 3);
            v.expect_method("show_current_test_progress").once().with_args(3, 3);
            r.expect_method("add_pass").once().with_args("", 1, 0);
            r.expect_method("add_pass").once().with_args("", 2, 0);
            r.expect_method("add_pass").once().with_args("", 3, 0);
        });
    }

    function parse_simple_failure()
    {
        test_parse(["1..1", "not ok 1"], function(r, v) {
            r.expect_method("set_plan").once().with_args(1);
            r.expect_get("num_tests").once().will_return(1);
            v.expect_method("show_current_test_progress").once().with_args(1, 1);
            r.expect_method("add_fail").once().with_args("", 1, 0);
        });
    }

    function parse_several_failure()
    {
        test_parse(["1..3", "not ok 1", "not ok 2", "not ok 3"], function(r, v) {
            r.expect_method("set_plan").once().with_args(3);
            r.expect_get("num_tests").exactly(3).will_return(3);
            v.expect_method("show_current_test_progress").once().with_args(1, 3);
            v.expect_method("show_current_test_progress").once().with_args(2, 3);
            v.expect_method("show_current_test_progress").once().with_args(3, 3);
            r.expect_method("add_fail").once().with_args("", 1, 0);
            r.expect_method("add_fail").once().with_args("", 2, 0);
            r.expect_method("add_fail").once().with_args("", 3, 0);
        });
    }

    function parse_several_mixed()
    {
        test_parse(["1..4", "not ok 1", "ok 2", "not ok 3", "ok 4"], function(r, v) {
            r.expect_method("set_plan").once().with_args(4);
            r.expect_get("num_tests").exactly(4).will_return(4);
            v.expect_method("show_current_test_progress").once().with_args(1, 4);
            v.expect_method("show_current_test_progress").once().with_args(2, 4);
            v.expect_method("show_current_test_progress").once().with_args(3, 4);
            v.expect_method("show_current_test_progress").once().with_args(4, 4);
            r.expect_method("add_fail").once().with_args("", 1, 0);
            r.expect_method("add_pass").once().with_args("", 2, 0);
            r.expect_method("add_fail").once().with_args("", 3, 0);
            r.expect_method("add_pass").once().with_args("", 4, 0);
        });
    }

    function parse_todo_failure()
    {
        test_parse(["1..1", "not ok 1 # TODO"], function(r, v) {
            r.expect_method("set_plan").once().with_args(1);
            r.expect_get("num_tests").once().will_return(1);
            v.expect_method("show_current_test_progress").once().with_args(1, 1);
            r.expect_method("add_fail").once().with_args("", 1, 1);
        });
    }

    function parse_todo_pass()
    {
        test_parse(["1..1", "ok 1 # TODO"], function(r, v) {
            r.expect_method("set_plan").once().with_args(1);
            r.expect_get("num_tests").once().will_return(1);
            v.expect_method("show_current_test_progress").once().with_args(1, 1);
            r.expect_method("add_pass").once().with_args("", 1, 1);
        });
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test", "mockobject");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TapParser);
    var t = new Test_Rosella_Harness_TapParser;
}
