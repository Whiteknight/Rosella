// Automatically generated test for Class Rosella.Harness.TestExecutor
class Test_Rosella_Harness_TestExecutor
{
    function test_new()
    {
        var obj = new Rosella.Harness.TestExecutor(new Rosella.Harness.TapParser());
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestExecutor);
    }

    function run()
    {
        self.status.unimplemented("Find a way to test .run()");
        self.status.verify("Test Rosella.Harness.TestExecutor.run()");
        var obj = new Rosella.Harness.TestExecutor();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var arg_3 = null;
        //var result = obj.run(arg_0, arg_1, arg_2, arg_3);
    }

    function compile_and_execute()
    {
        self.status.unimplemented("Find a way to test .compile_and_execute()");
        self.status.verify("Test Rosella.Harness.TestExecutor.compile_and_execute()");
        var obj = new Rosella.Harness.TestExecutor();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.compile_and_execute(arg_0, arg_1);
    }

    function close_stream()
    {
        self.status.unimplemented("Find a way to test .close_stream()");
        self.status.verify("Test Rosella.Harness.TestExecutor.close_stream()");
        var obj = new Rosella.Harness.TestExecutor();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.close_stream(arg_0, arg_1);
    }

    function open_pipe_stream()
    {
        self.status.unimplemented("Find a way to test .open_pipe_stream()");
        self.status.verify("Test Rosella.Harness.TestExecutor.open_pipe_stream()");
        var obj = new Rosella.Harness.TestExecutor();

        var arg_0 = null;
        var result = obj.open_pipe_stream(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestExecutor);
}
