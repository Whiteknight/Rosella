// Automatically generated test for Class Rosella.Xml.Tag.DtdHeader
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Xml.Tag.DtdHeader(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Xml_Tag_DtdHeader
{
    function get_dtd_document()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdHeader.get_dtd_document()");
        self.status.unimplemented("TODO");
    }

    function set_scope()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdHeader.set_scope()");
        self.status.unimplemented("TODO");
    }

    function to_xml_sb()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdHeader.to_xml_sb()");
        self.status.unimplemented("TODO");
    }

    function add_child()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdHeader.add_child()");
        self.status.unimplemented("TODO");
    }

    function add_child_text()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdHeader.add_child_text()");
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
    var(Rosella.Test.test)(class Test_Rosella_Xml_Tag_DtdHeader, initialize_test:[named("initialize")]);
}
