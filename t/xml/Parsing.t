function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test", "xml");
    Rosella.Test.test_vector(
        function(var self, string data) {
            var doc = Rosella.Xml.read_string(data);
            self.assert.not_null(doc);
            self.assert.instance_of(doc, class Rosella.Xml.Document);
        }, __test_data()
    );
}

function __test_data() { return {
    "Basic" : "<foo><bar><baz></baz></bar></foo>",
    "contained tag" : "<foo><bar><baz/></bar></foo>",
    "one tag" : "<foo></foo>",
    "one contained tag" : "<foo/>",
    "xml header" : "<?xml version='1.0'?><foo></foo>",
    "dtd header" : "<!DOCTYPE foo SYSTEM 'foo.dtd'><foo></foo>",
    "two headers" : "<?xml version='1.0'?><!DOCTYPE foo SYSTEM 'foo.dtd'><foo></foo>",
    "comments between headers" : "<!--test--><?xml version='1.0'?><!--test2--><!DOCTYPE foo SYSTEM 'foo.dtd'><!--test3--><foo></foo>",
    "whitespace" : <<:
<foo>
    <   bar>
        <   baz  />
    </bar   >
</foo  >


:>>
,
    "namespaces" : "<foo:bar></foo:bar>"
};}
