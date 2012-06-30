// Automatically generated test for Class Rosella.Xml.Document
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Xml.Document(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Xml_Document
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Xml.Document();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Xml.Document);
    }

    function add_header()
    {
        self.status.verify("Test Rosella.Xml.Document.add_header()");
        string x = <<:
<?xml version="1.0"?>
<!DOCTYPE foo>
<foo/>
:>>
;
        var d = Rosella.Xml.read_string(x);
        self.assert.equal(d.xml_header.attributes["version"], "1.0");
        self.assert.equal(d.dtd_header.doctype, "foo");
    }

    function set_root()
    {
        self.status.verify("Test Rosella.Xml.Document.set_root()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.set_root(arg_0);
    }

    function get_document_root()
    {
        self.status.verify("Test Rosella.Xml.Document.get_document_root()");
        string x = <<:
<foo>Test</foo>
:>>
;
        var d = Rosella.Xml.read_string(x);
        self.assert.equal(d.get_document_root().name, "foo");
        self.assert.equal(d.get_document_root().get_inner_xml(), "Test");
    }

    function to_xml()
    {
        self.status.verify("Test Rosella.Xml.Document.to_xml()");
        self.status.unimplemented("TODO");
    }

    function write_to_file()
    {
        self.status.verify("Test Rosella.Xml.Document.write_to_file()");
        self.status.unimplemented("TODO");
    }

    function read_from_file()
    {
        self.status.verify("Test Rosella.Xml.Document.read_from_file()");
        self.status.unimplemented("TODO");
    }


    // TODO: We might want to move all validation tests into a separate test file

    function validate()
    {
        self.status.verify("Test Rosella.Xml.Document.validate()");
        self.status.unimplemented("TODO");
    }

    function is_validated()
    {
        self.status.verify("Test Rosella.Xml.Document.is_validated()");
        self.status.unimplemented("TODO");
    }

    function is_valid()
    {
        self.status.verify("Test Rosella.Xml.Document.is_valid()");
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
    var(Rosella.Test.test)(class Test_Rosella_Xml_Document, initialize_test:[named("initialize")]);
}
