// Automatically generated test for Class Rosella.Harness.TestFile.NQP
class Test_Rosella_Harness_TestFile_NQP
{
    function test_new()
    {
        var obj = new Rosella.Harness.TestFile.NQP("foo.nqp");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestFile.NQP);
    }

    function compile_test()
    {
        self.status.unimplemented("Find a way to test .compile_test()");
        self.status.verify("Test Rosella.Harness.TestFile.NQP.compile_test()");
        var obj = new Rosella.Harness.TestFile.NQP();

        var result = obj.compile_test();
    }

    function get_spawn_command()
    {
        self.status.verify("Test Rosella.Harness.TestFile.NQP.get_spawn_command()");
        var obj = new Rosella.Harness.TestFile.NQP("foo.nqp");

        var arg_0 = "foo.nqp";
        string result = obj.get_spawn_command(arg_0);
        self.assert.equal(result, "parrot-nqp foo.nqp");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestFile_NQP);
}
