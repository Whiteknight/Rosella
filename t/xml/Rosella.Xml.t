// Automatically generated test for NameSpace Rosella.Xml
class Test_Rosella_Xml
{
    function read_file()
    {
        self.status.verify("Test Rosella.Xml.read_file()");
        self.status.unimplemented("TODO");
    }

    function read_string()
    {
        self.status.verify("Test Rosella.Xml.read_string()");
        self.status.unimplemented("TODO");
    }

    function read_dtd_string()
    {
        self.status.verify("Test Rosella.Xml.read_dtd_string()");
        self.status.unimplemented("TODO");
    }

    function read_dtd_file()
    {
        self.status.verify("Test Rosella.Xml.read_dtd_file()");
        self.status.unimplemented("TODO");
    }

    function parse()
    {
        self.status.verify("Test Rosella.Xml.parse()");
        self.status.unimplemented("TODO");
    }

    function parse_dtd()
    {
        self.status.verify("Test Rosella.Xml.parse_dtd()");
        self.status.unimplemented("TODO");
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
    var(Rosella.Test.test)(class Test_Rosella_Xml, initialize_test:[named("initialize")]);
}
