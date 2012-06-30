// Automatically generated test for Class Rosella.Xml.Tag.Collection
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Xml.Tag.Collection(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Xml_Tag_Collection
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Xml.Tag.Collection();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Xml.Tag.Collection);
    }

    function add_tag()
    {
        self.status.verify("Test Rosella.Xml.Tag.Collection.add_tag()");
        self.status.unimplemented("TODO");
    }

    function tags()
    {
        self.status.verify("Test Rosella.Xml.Tag.Collection.tags()");
        self.status.unimplemented("TODO");
    }

    function get_children_named()
    {
        self.status.verify("Test Rosella.Xml.Tag.Collection.get_children_named()");
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
    var(Rosella.Test.test)(class Test_Rosella_Xml_Tag_Collection, initialize_test:[named("initialize")]);
}
