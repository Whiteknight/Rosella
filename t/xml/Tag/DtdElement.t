// Automatically generated test for Class Rosella.Xml.Tag.DtdElement
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Xml.Tag.DtdElement(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Xml_Tag_DtdElement
{
    function test_new()
    {
        self.status.unimplemented("TODO");
    }

    function add_child_type()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdElement.add_child_type()");
        self.status.unimplemented("TODO");
    }

    function add_attribute()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdElement.add_attribute()");
        self.status.unimplemented("TODO");
    }

    function set_child_rule()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdElement.set_child_rule()");
        self.status.unimplemented("TODO");
    }

    function to_xml_sb()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdElement.to_xml_sb()");
        self.status.unimplemented("TODO");
    }

    function validate_attribute()
    {
        self.status.verify("Test Rosella.Xml.Tag.DtdElement.validate_attribute()");
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
    var(Rosella.Test.test)(class Test_Rosella_Xml_Tag_DtdElement, initialize_test:[named("initialize")]);
}
