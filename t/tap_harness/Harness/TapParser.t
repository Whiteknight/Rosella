// Automatically generated test for Class Rosella.Harness.TapParser
class Test_Rosella_Harness_TapParser
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        var obj = new Rosella.Harness.TapParser();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Harness.TapParser);
    }


    function TapParser()
    {
        self.status.verify("Test Rosella.Harness.TapParser.TapParser()");
        var obj = new Rosella.Harness.TapParser();

        var result = obj.TapParser();
    }

    function parse()
    {
        self.status.verify("Test Rosella.Harness.TapParser.parse()");
        var obj = new Rosella.Harness.TapParser();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.parse(arg_0, arg_1, arg_2);
    }

    function get_plan()
    {
        self.status.verify("Test Rosella.Harness.TapParser.get_plan()");
        var obj = new Rosella.Harness.TapParser();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.get_plan(arg_0, arg_1);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/harness.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_Harness_TapParser);
}
