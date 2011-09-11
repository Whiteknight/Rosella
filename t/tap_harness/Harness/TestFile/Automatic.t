// Automatically generated test for Class Rosella.Harness.TestFile.Automatic
class Test_Rosella_Harness_TestFile_Automatic
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.Harness.TestFile.Automatic();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestFile.Automatic);
    }


    function Automatic()
    {
        self.status.verify("Test Rosella.Harness.TestFile.Automatic.Automatic()");
        var obj = new Rosella.Harness.TestFile.Automatic();

        var result = obj.Automatic();
    }

    function get_spawn_command()
    {
        self.status.verify("Test Rosella.Harness.TestFile.Automatic.get_spawn_command()");
        var obj = new Rosella.Harness.TestFile.Automatic();

        var arg_0 = null;
        var result = obj.get_spawn_command(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestFile_Automatic);
}
