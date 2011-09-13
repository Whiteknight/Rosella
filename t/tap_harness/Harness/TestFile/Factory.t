// Automatically generated test for Class Rosella.Harness.TestFile.Factory
class Test_Rosella_Harness_TestFile_Factory
{
    function test_new()
    {
        var obj = new Rosella.Harness.TestFile.Factory(null);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TestFile.Factory);
    }

    function create_typed()
    {
        self.status.unimplemented("Find a way to test .create_typed()");
        self.status.verify("Test Rosella.Harness.TestFile.Factory.create_typed()");
        var obj = new Rosella.Harness.TestFile.Factory(null);

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.create_typed(arg_0, arg_1);
    }

    function create_tests_from_dirs()
    {
        self.status.unimplemented("Find a way to test .create_tests_from_dirs()");
        self.status.verify("Test Rosella.Harness.TestFile.Factory.create_tests_from_dirs()");
        var obj = new Rosella.Harness.TestFile.Factory();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.create_tests_from_dirs(arg_0, arg_1, arg_2);
    }

    function create_tests_from_files()
    {
        self.status.unimplemented("Find a way to test .create_tests_from_files()");
        self.status.verify("Test Rosella.Harness.TestFile.Factory.create_tests_from_files()");
        var obj = new Rosella.Harness.TestFile.Factory();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.create_tests_from_files(arg_0, arg_1);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TestFile_Factory);
}
