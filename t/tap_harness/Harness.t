function get_mock_testrun_factory(var harness)
{
    var f = Rosella.MockObject.default_mock_factory();
    var c = f.create_typed(class Rosella.Harness.TestRun.Factory);
    harness.set_testrun_factory(c.mock());
    return c;
}

class Test_Rosella_Harness
{
    /* Tests for Harness namespace helper routines
    */

    function default_testexecutor_factory()
    {
        using Rosella.Harness.default_testexecutor_factory;
        var f = default_testexecutor_factory();
        self.assert.not_null(f);
        self.assert.instance_of(f, class Rosella.ObjectFactory);
        var e = f.create(0);
        self.assert.not_null(e);
        self.assert.instance_of(e, class Rosella.Harness.TestExecutor);
    }

    function set_testexecutor_factory()
    {
        using Rosella.Harness.default_testexecutor_factory;
        using Rosella.Harness.set_testexecutor_factory;
        var f = "Test";
        set_testexecutor_factory(f);
        var g = default_testexecutor_factory();
        self.assert.same(f, g);
    }

    function default_tapparser_factory()
    {
        using Rosella.Harness.default_tapparser_factory;
        var f = default_tapparser_factory();
        self.assert.not_null(f);
        self.assert.instance_of(f, class Rosella.ObjectFactory);
        var e = f.create();
        self.assert.not_null(e);
        self.assert.instance_of(e, class Rosella.Harness.TapParser);
    }

    function set_tapparser_factory()
    {
        using Rosella.Harness.default_tapparser_factory;
        using Rosella.Harness.set_tapparser_factory;
        var f = "Test";
        set_tapparser_factory(f);
        var g = default_tapparser_factory();
        self.assert.same(f, g);
    }

    function default_fileresult_factory()
    {
        using Rosella.Harness.default_fileresult_factory;
        var f = default_fileresult_factory();
        self.assert.not_null(f);
        self.assert.instance_of(f, class Rosella.ObjectFactory);
        //var e = f.create();
        //self.assert.not_null(e);
        //self.assert.instance_of(e, class Rosella.Harness.FileResult);
    }

    function set_fileresult_factory()
    {
        using Rosella.Harness.default_fileresult_factory;
        using Rosella.Harness.set_fileresult_factory;
        var f = "Test";
        set_fileresult_factory(f);
        var g = default_fileresult_factory();
        self.assert.same(f, g);
    }

    /* Tests for Harness class
    */

    function test_new()
    {
        var obj = new Rosella.Harness();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness);
    }

    function set_testrun_factory()
    {
        self.status.verify("Test Rosella.Harness.set_testrun_factory()");
        var obj = new Rosella.Harness();

        var arg_0 = "hello";
        obj.set_testrun_factory(arg_0);
        self.assert.same(arg_0, obj.testrun_factory);
    }

    function add_testfile_type()
    {
        self.status.verify("Test Rosella.Harness.add_testfile_type()");
        var obj = new Rosella.Harness();

        string arg_0 = "Test";
        var arg_1 = "TestFileType";

        var c = get_mock_testrun_factory(obj);
        c.expect_method("add_testfile_type").once().with_args(arg_0, arg_1);

        var result = obj.add_testfile_type(arg_0, arg_1);

        c.verify();
    }

    function view()
    {
        self.status.verify("Test Rosella.Harness.view()");
        var obj = new Rosella.Harness();

        var arg_0 = "Test";
        var result = obj.view(arg_0);
        self.assert.equal(arg_0, result);
        result = obj.view();
        self.assert.equal(arg_0, result);
    }

    function add_test_dirs()
    {
        self.status.verify("Test Rosella.Harness.add_test_dirs()");
        var obj = new Rosella.Harness();

        string arg_0 = "Test";
        string arg_1 = "Foo";
        string arg_2 = "Bar";

        var c = get_mock_testrun_factory(obj);
        c.expect_method("add_test_dirs").once().with_args(arg_0, arg_1, arg_2);

        var result = obj.add_test_dirs(arg_0, arg_1, arg_2);
        self.assert.same(obj, result);
        c.verify();
    }

    function add_test_files()
    {
        self.status.verify("Test Rosella.Harness.add_test_files()");
        var obj = new Rosella.Harness();

        string arg_0 = "Test";
        string arg_1 = "Foo";
        string arg_2 = "Bar";

        var c = get_mock_testrun_factory(obj);
        c.expect_method("add_test_files").once().with_args(arg_0, arg_1, arg_2);

        var result = obj.add_test_files(arg_0, arg_1, arg_2);
        self.assert.same(obj, result);
        c.verify();
    }

    function setup_test_run()
    {
        self.status.verify("Test Rosella.Harness.setup_test_run()");
        var obj = new Rosella.Harness();

        var result = obj.setup_test_run();
        self.assert.not_null(result);
        self.assert.instance_of(result, class Rosella.Harness.TestRun);
    }

    function run()
    {
        self.status.verify("Test Rosella.Harness.run()");
        var obj = new Rosella.Harness();

        self.status.unimplemented("Harness.run is not testable");
        //var result = obj.run();
    }

    function show_results()
    {
        self.status.verify("Test Rosella.Harness.show_results()");
        var obj = new Rosella.Harness();

        var c = Rosella.MockObject.default_mock_factory().create_typed(class Rosella.Harness.TestRun.Factory);
        obj.view(c.mock());
        c.expect_method("show_results").once().with_no_args().will_return(true);

        obj.show_results();
        c.verify();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test", "mockobject");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness);
}
