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
    "Eval Empty" : ["A<% %>B", {}, "AB"],
    "Eval Return" : ["A<% return 'foo'; %>B", {}, "AfooB"],
    "Eval Returns" : ["A<% return 'foo', 'bar', 'baz'; %>B", {}, "AfoobarbazB"],
    "Eval outputter" : ["A<% push(output, 'foo'); %>B", {}, "AfooB"],
    "Eval context" : ["A<% return context['foo.bar']; %>B", { "foo" : { "bar" : "baz" }}, "AbazB"]
};}
