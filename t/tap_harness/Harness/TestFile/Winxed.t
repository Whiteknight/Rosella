// Automatically generated test for Class Rosella.Harness.TestFile.Winxed
class Test_Rosella_Harness_TestFile_Winxed
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.Harness.TestFile.Winxed();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestFile.Winxed);
    }


    function Winxed()
    {
        self.status.verify("Test Rosella.Harness.TestFile.Winxed.Winxed()");
        var obj = new Rosella.Harness.TestFile.Winxed();

        var result = obj.Winxed();
    }

    function compile_test()
    {
        self.status.verify("Test Rosella.Harness.TestFile.Winxed.compile_test()");
        var obj = new Rosella.Harness.TestFile.Winxed();

        var result = obj.compile_test();
    }

    function get_spawn_command()
    {
        self.status.verify("Test Rosella.Harness.TestFile.Winxed.get_spawn_command()");
        var obj = new Rosella.Harness.TestFile.Winxed();

        var arg_0 = null;
        var result = obj.get_spawn_command(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestFile_Winxed);
}
