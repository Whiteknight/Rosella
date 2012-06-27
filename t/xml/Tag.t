class Test_Xml_Tag
{
    function get_children_named()
    {
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
        self.assert.equal(elements(c.tags), 2);
        self.assert.equal(Rosella.String.trim(c.tags[0].get_inner_xml()), "Test A");
        self.assert.equal(Rosella.String.trim(c.tags[1].get_inner_xml()), "Test D");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test", "xml", "string");
    Rosella.Test.test(class Test_Xml_Tag);
}
