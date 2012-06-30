function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test", "xml");
    Rosella.Test.test_vector(
        function(var self, string data) {
            var doc = new Rosella.Xml.Document();
            doc.read_from_string(data, false);  // Do not validate here, we are testing
                                                // The parser, not the validator
            self.assert.not_null(doc);
            self.assert.instance_of(doc, class Rosella.Xml.Document);
        }, __test_data()
    );
}

function __test_data() { return {
    // Tests for basic tag structures
    "Basic" : "<foo><bar><baz></baz></bar></foo>",
    "contained tag" : "<foo><bar><baz/></bar></foo>",
    "one tag" : "<foo></foo>",
    "one contained tag" : "<foo/>",

    // Tests for headers and frontmatter
    "xml header" : "<?xml version='1.0'?><foo></foo>",
    "simple dtd header" : "<!DOCTYPE foo>",
    "dtd header" : "<!DOCTYPE foo SYSTEM 'foo.dtd'><foo></foo>",
    "two headers" : "<?xml version='1.0'?><!DOCTYPE foo SYSTEM 'foo.dtd'><foo></foo>",
    "comments between headers" : "<!--test--><?xml version='1.0'?><!--test2--><!DOCTYPE foo SYSTEM 'foo.dtd'><!--test3--><foo></foo>",

    // Tests for whitespace
    "whitespace" : <<:
<foo>
    <   bar>
        <   baz  />
    </bar   >
</foo  >


:>>
,

    // Tests for namespaces
    "namespaces" : "<foo:bar></foo:bar>",

    // Tests for comments
    "comments" : "<!--test-->",
    "comments with dashes" : "<!-- - test -- test2 -> -->",

    // Tests for various attribute syntaxes
    "attribute" : "<foo bar='baz'></foo>",
    "attribute unquoted" : "<foo bar=baz></foo>",
    "attribute boolean" : "<foo bar></foo>",
    "attribute quoted escapes" : "<foo bar='blahblah\\'blahblah'></foo>",
    "attribute with colon" : "<foo xmlns:bar='blahblahblah'></foo>",

    // Tests for !DOCTYPE and children
    "!DOCTYPE with scope and inlines" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo SYSTEM "foo.dtd" [
    <!ELEMENT foo (bar)>
    <!ATTLIST foo id CDATA "0">
]>
<foo>
    <bar/>
</foo>
:>>
,
    "!ELEMENT and !ATTLIST" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo (bar)>
    <!ATTLIST foo id CDATA "0">
]>
<foo>
    <bar/>
</foo>
:>>
,
    "!ELEMENT with multiple children" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo (#CDATA, bar, baz)>
    <!ELEMENT bar (#CDATA)>
    <!ELEMENT baz (#CDATA)>
]>
<foo><bar/><baz/></foo>
:>>
,
    "!ATTLIST with #REQUIRED" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo (bar)>
    <!ATTLIST foo id CDATA #REQUIRED>
]>
<foo><bar/></foo>
:>>
,
    "!ATTLIST with #IMPLIED" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo (bar)>
    <!ATTLIST foo id CDATA #IMPLIED>
]>
<foo><bar/></foo>
:>>
,
    "!ATTLIST with #FIXED" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo (bar)>
    <!ATTLIST foo id CDATA #FIXED "baz">
]>
<foo><bar/></foo>
:>>
,
    "!ELEMENT with ANY" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo ANY>
]>
<foo/>
:>>
,
    "!ELEMENT with EMPTY" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo EMPTY>
]>
<foo/>
:>>
,
    "!ELEMENT with #PCDATA" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo (#PCDATA)>
]>
<foo/>
:>>
,
    "!ELEMENT with #CDATA" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo (#CDATA)>
]>
<foo/>
:>>
,
    "!ATTLIST with multiple attributes" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo (#PCDATA)>
    <!ATTLIST foo bar CDATA #IMPLIED baz CDATA #FIXED "value">
]>
<foo></foo>
:>>
,
    "Multiple !ATTLISTs for a single element" : <<:
<?xml version='1.0'?>
<!DOCTYPE foo [
    <!ELEMENT foo (#PCDATA, baz)>
    <!ATTLIST foo
                bar CDATA #IMPLIED
                baz CDATA #FIXED "value">
    <!ATTLIST foo fie CDATA #REQUIRED>
]>
<bar></bar>
:>>
,


    // The empty string (Keep this one last)
    "Empty string" : ""
};}
