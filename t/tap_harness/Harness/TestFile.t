// Automatically generated test for Class Rosella.Harness.TestFile
class Test_Rosella_Harness_TestFile
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.Harness.TestFile();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestFile);
    }


    function TestFile()
    {
        self.status.verify("Test Rosella.Harness.TestFile.TestFile()");
        var obj = new Rosella.Harness.TestFile();

        var arg_0 = null;
        var result = obj.TestFile(arg_0);
    }

    function get_string()
    {
        self.status.verify("Test Rosella.Harness.TestFile.get_string()");
        var obj = new Rosella.Harness.TestFile();

        var result = obj.get_string();
    }

    function set_result()
    {
        self.status.verify("Test Rosella.Harness.TestFile.set_result()");
        var obj = new Rosella.Harness.TestFile();

        var arg_0 = null;
        var result = obj.set_result(arg_0);
    }

    function compile_test()
    {
        self.status.verify("Test Rosella.Harness.TestFile.compile_test()");
        var obj = new Rosella.Harness.TestFile();

        var arg_0 = null;
        var result = obj.compile_test(arg_0);
    }

    function setup_spawn()
    {
        self.status.verify("Test Rosella.Harness.TestFile.setup_spawn()");
        var obj = new Rosella.Harness.TestFile();

        var result = obj.setup_spawn();
    }

    function get_spawn_command()
    {
        self.status.verify("Test Rosella.Harness.TestFile.get_spawn_command()");
        var obj = new Rosella.Harness.TestFile();

        var result = obj.get_spawn_command();
    }

    function cleanup_spawn()
    {
        self.status.verify("Test Rosella.Harness.TestFile.cleanup_spawn()");
        var obj = new Rosella.Harness.TestFile();

        var result = obj.cleanup_spawn();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestFile);
}
