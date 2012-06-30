// Automatically generated test for Class Rosella.Xml.Tag
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Xml.Tag(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Xml_Tag
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Xml.Tag(0, "foo", "bar");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Xml.Tag);
    }

    function add_attribute()
    {
        self.status.verify("Test Rosella.Xml.Tag.add_attribute()");
        var obj = create_new(0, "foo", "bar");

        var arg_0 = "foo";
        var arg_1 = "bar";
        var arg_2 = "baz";
        var result = obj.add_attribute(arg_0, arg_1, arg_2);
    }

    function add_child()
    {
        self.status.verify("Test Rosella.Xml.Tag.add_child()");
        var obj = create_new(0, "foo", "bar");

        var arg_0 = null;
        var result = obj.add_child(arg_0);
    }

    function add_child_text()
    {
        self.status.verify("Test Rosella.Xml.Tag.add_child_text()");
        var obj = create_new(0, "foo", "bar");

        string arg_0 = "test";
        var result = obj.add_child_text(arg_0);
    }

    function set_end()
    {
        self.status.verify("Test Rosella.Xml.Tag.set_end()");
        var obj = create_new(0, "foo", "bar");

        var arg_0 = null;
        var result = obj.set_end(arg_0);
    }

    function to_xml()
    {
        self.status.verify("Test Rosella.Xml.Tag.to_xml()");
        var obj = create_new(0, "foo", "bar");

        var result = obj.to_xml();
    }

    function get_inner_xml()
    {
        self.status.verify("Test Rosella.Xml.Tag.get_inner_xml()");
        var obj = create_new(0, "foo", "bar");

        var result = obj.get_inner_xml();
    }

    function get_children()
    {
        self.status.verify("Test Rosella.Xml.Tag.get_children()");
        var obj = create_new(0, "foo", "bar");

        var result = obj.get_children();
    }

    function get_children_collection()
    {
        self.status.verify("Test Rosella.Xml.Tag.get_children_collection()");
        var obj = create_new(0, "foo", "bar");

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.get_children_collection(arg_0, arg_1);
    }

    function get_children_named()
    {
        self.status.verify("Test Rosella.Xml.Tag.get_children_named()");
        string x = <<:
<html>
    <div>
        <p type='Foo'>Test A</p>
        <p>Text B</p>
    </div>
    <div>
        <p>Test C</p>
        <p type='Foo'>Test D</p>
    </div>
</html>
:>>
;
        var d = Rosella.Xml.read_string(x);
        var c = d
            .get_document_root()
            .get_children_named("div")
            .get_children_named("p", "Foo":[named('type')]);
        self.assert.equal(elements(c.data), 2);
        self.assert.equal(Rosella.String.trim(c.data[0].get_inner_xml()), "Test A");
        self.assert.equal(Rosella.String.trim(c.data[1].get_inner_xml()), "Test D");
    }

    function get_children_by_attr()
    {
        self.status.verify("Test Rosella.Xml.Tag.get_children_by_attr()");
        var obj = create_new(0, "foo", "bar");

        var arg_0 = null;
        var result = obj.get_children_by_attr(arg_0);
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
    var(Rosella.Test.test)(class Test_Rosella_Xml_Tag, initialize_test:[named("initialize")]);
}
