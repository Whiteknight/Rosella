function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test_vector;
    test_vector(
        function(var self, var data) {
            var engine = new Rosella.Template.Engine();
            string output = engine.generate(data[0], data[1]);
            //say(sprintf("'%s' == '%s'", [data[2], output]));
            self.assert.equal(data[2], output);
        }, __test_data()
    );
}

function __test_data() { return {
    "Verbatim text": ["Verbatim text", {}, "Verbatim text"],

    // if with numbers
    "if const 1"     : ["<$ if 1 $>ok<$ endif $>", {}, "ok"],
    "if const 1 == 1": ["<$ if 1 == 1 $>ok<$ endif $>", {}, "ok"],
    "if const 0"     : ["<$ if 0 $>ok<$ endif $>", {}, ""],
    "if const 1 == 0": ["<$ if 1 == 0 $>ok<$ endif $>", {}, ""],

    // if with strings
    "if const str"       : ["<$ if 'ok' $>ok<$ endif $>", {}, "ok"],
    "if const !str"      : ["<$ if '' $>ok<$ endif $>", {}, ""],
    "if const str == str": ["<$ if 'foo' == 'foo' $>ok<$ endif $>", {}, "ok"],
    "if const s_a == s_b": ["<$ if 'foo' == 'bar' $>ok<$ endif $>", {}, ""],

    // if with context variables
    "if var"       : ["<$ if foo $>ok<$ endif $>", {"foo" : 1}, "ok"],
    "if var fail"  : ["<$ if foo $>ok<$ endif $>", {"foo" : 0}, ""],
    "if var == var": ["<$ if foo == foo $>ok<$ endif $>", {"foo" : 1}, "ok"],
    "if var == str": ["<$ if foo == 'foo' $>ok<$ endif $>", {"foo" : "foo"}, "ok"],
    "if var == 1"  : ["<$ if foo == 1 $>ok<$ endif $>", {"foo" : 1}, "ok"],
    "if var == 0"  : ["<$ if foo == 0 $>ok<$ endif $>", {"foo" : 0}, "ok"],
    "if v1 == v2"  : ["<$ if foo == bar $>ok<$ endif $>", {"foo" : "a", "bar": "b"}, ""],

    // unless
    "unless const 1" : ["<$ unless 1 $>ok<$ endunless $>", {}, ""],
    "unless const 0" : ["<$ unless 0 $>ok<$ endunless $>", {}, "ok"],

    // if/else
    "if/else"      : ["<$ if 0 $>fail<$ else $>ok<$ endif $>", {"foo" : 1}, "ok"],

    // for loop with scalar
    "for scalar" : [
        "<$ for foo in bar $><# foo #><$ endfor $>",
        {"bar" : "ok"},
        "ok"
    ],
    "for scalar first/last" : [
        "<$ for foo in bar $><# __FIRST__ #><# foo #><# __LAST__ #><$ endfor $>",
        {"bar" : "ok"},
        "1ok1"
    ],
    "for scalar key" : [
        "<$ for foo in bar $><# __KEY__ #><# foo #><$ endfor $>",
        {"bar" : "ok"},
        "ok"
    ],

    // for loop with arrays
    "for array" : [
        "<$ for foo in bar $><# foo #><$ endfor $>",
        {"bar" : [1, 2, 3]},
        "123"
    ],
    "for array first/last" : [
        "<$ for foo in bar $><# __FIRST__ #><# foo #><# __LAST__ #><$ endfor $>",
        {"bar" : [4, 5, 6]},
        "140050061"
    ],
    "for array key" : [
        "<$ for foo in bar $><# __KEY__ #><# foo #><$ endfor $>",
        {"bar" : [4, 5, 6]},
        "456"
    ],

    // for loop with hashes
    "for hash" : [
        "<$ for foo in bar $><# foo #><$ endfor $>",
        {"bar" : {"a" : 1, "b" : 2, "c" : 3}},
        "123"
    ],
    "for hash first/last" : [
        "<$ for foo in bar $><# __FIRST__ #><# foo #><# __LAST__ #><$ endfor $>",
        {"bar" : {"a" : 4, "b" : 5, "c" : 6}},
        "140050061"
    ],
    "for hash key" : [
        "<$ for foo in bar $><# __KEY__ #><# foo #><$ endfor $>",
        {"bar" : {"a" : 1, "b" : 2, "c" : 3}},
        "a1b2c3"
    ],

    // Repeat
    "Repeat empty" : ["<$ repeat 1 to 1 $><# __INDEX__ #><$ endrepeat $>", {}, "1"],
    "Repeat forward" : ["<$ repeat 1 to 5 $><# __INDEX__ #><$ endrepeat $>", {}, "12345"],
    "Repeat backwards" : ["<$ repeat 5 to 1 $><# __INDEX__ #><$ endrepeat $>", {}, "54321"]
};}
