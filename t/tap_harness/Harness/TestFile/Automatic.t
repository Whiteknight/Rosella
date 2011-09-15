// Automatically generated test for Class Rosella.Harness.TestFile.Automatic
class Test_Rosella_Harness_TestFile_Automatic
{
    function test_new()
    {
        var obj = new Rosella.Harness.TestFile.Automatic("foo.t");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestFile.Automatic);
    }

    function get_spawn_command()
    {
        self.status.unimplemented("Find a way to test .get_spawn_command()");
        self.status.verify("Test Rosella.Harness.TestFile.Automatic.get_spawn_command()");
        var obj = new Rosella.Harness.TestFile.Automatic();

        var arg_0 = "foo.t";
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
