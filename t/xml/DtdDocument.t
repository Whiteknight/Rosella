// Automatically generated test for Class Rosella.Xml.DtdDocument
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Xml.DtdDocument(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Xml_DtdDocument
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Xml.DtdDocument();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Xml.DtdDocument);
    }

    function to_xml()
    {
        self.status.verify("Test Rosella.Xml.DtdDocument.to_xml()");
        self.status.unimplemented("TODO");
    }

    function write_to_file()
    {
        self.status.verify("Test Rosella.Xml.DtdDocument.write_to_file()");
        self.status.unimplemented("TODO");
    }

    function to_xml_sb()
    {
        self.status.verify("Test Rosella.Xml.DtdDocument.to_xml_sb()");
        self.status.unimplemented("TODO");
    }

    function validate_xml()
    {
        // TODO: We might want to move all validation logic to a separate file
        self.status.verify("Test Rosella.Xml.DtdDocument.validate_xml()");
        self.status.unimplemented("TODO");
    }

    function read_from_file()
    {
        self.status.verify("Test Rosella.Xml.DtdDocument.read_from_file()");
        self.status.unimplemented("TODO");
    }

    function read_from_string()
    {
        self.status.verify("Test Rosella.Xml.DtdDocument.read_from_string()");
        self.status.unimplemented("TODO");
    }

    function add_element_def()
    {
        self.status.verify("Test Rosella.Xml.DtdDocument.add_element_def()");
        self.status.unimplemented("TODO");
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Set options on the Suite, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/xml.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Xml_DtdDocument, initialize_test:[named("initialize")]);
}
