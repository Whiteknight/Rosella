// Automatically generated test for Class Rosella.Xml.Tag.EndTag
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Xml.Tag.EndTag(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Xml_Tag_EndTag
{
    function add_attribute()
    {
        self.status.verify("Test Rosella.Xml.Tag.EndTag.add_attribute()");
        self.status.unimplemented("TODO");
    }

    function add_child()
    {
        self.status.verify("Test Rosella.Xml.Tag.EndTag.add_child()");
        self.status.unimplemented("TODO");
    }

    function add_child_text()
    {
        self.status.verify("Test Rosella.Xml.Tag.EndTag.add_child_text()");
        self.status.unimplemented("TODO");
    }

    function set_end()
    {
        self.status.verify("Test Rosella.Xml.Tag.EndTag.set_end()");
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
    var(Rosella.Test.test)(class Test_Rosella_Xml_Tag_EndTag, initialize_test:[named("initialize")]);
}
