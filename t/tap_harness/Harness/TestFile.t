// Automatically generated test for Class Rosella.Harness.TestFile
class Test_Rosella_Harness_TestFile
{
    function test_new()
    {
        var obj = new Rosella.Harness.TestFile("foo.t");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestFile);
    }

    function get_string()
    {
        self.status.verify("Test Rosella.Harness.TestFile.get_string()");
        var obj = new Rosella.Harness.TestFile("foo.t");

        string result = obj.get_string();
        self.assert.equal(result, "foo.t");
    }

    function set_result()
    {
        self.status.verify("Test Rosella.Harness.TestFile.set_result()");
        var obj = new Rosella.Harness.TestFile("foo.t");

        var arg_0 = "Foo";
        var result = obj.set_result(arg_0);
    }

    function setup_spawn()
    {
        self.status.verify("Test Rosella.Harness.TestFile.setup_spawn()");
        var obj = new Rosella.Harness.TestFile("foo.t");

        string result = obj.setup_spawn();
        self.assert.equal(result, "foo.t");
    }

    function cleanup_spawn()
    {
        self.status.verify("Test Rosella.Harness.TestFile.cleanup_spawn()");
        var obj = new Rosella.Harness.TestFile("foo.t");

        obj.cleanup_spawn();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestFile);
}
