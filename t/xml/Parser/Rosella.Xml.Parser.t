// Automatically generated test for NameSpace Rosella.Xml.Parser
class Test_Rosella_Xml_Parser
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Initialize the context, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/xml.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Xml_Parser, initialize_test:[named("initialize")]);
}
