// Automatically generated test for Class Rosella.Harness.TestFile.PIR
class Test_Rosella_Harness_TestFile_PIR
{
    function test_new()
    {
        var obj = new Rosella.Harness.TestFile.PIR("foo.pir");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestFile.PIR);
    }

    function compile_test()
    {
        self.status.unimplemented("Find a way to test .compile_test()");
        self.status.verify("Test Rosella.Harness.TestFile.PIR.compile_test()");
        var obj = new Rosella.Harness.TestFile.PIR();

        var result = obj.compile_test();
    }

    function get_spawn_command()
    {
        self.status.verify("Test Rosella.Harness.TestFile.PIR.get_spawn_command()");
        var obj = new Rosella.Harness.TestFile.PIR("foo.pir");

        var arg_0 = "foo.pir";
        string result = obj.get_spawn_command(arg_0);
        self.assert.equal(result, "parrot foo.pir");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestFile_PIR);
}
