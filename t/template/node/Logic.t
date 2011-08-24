class Test_Rosella_Template_Node_Logic
{
    function test_new() {
        self.status.todo("Figure out how to test this correctly");
        var factory = new Rosella.Template.Handler.Factory({"Foo" : class Rosella.Template.Handler});
        var obj = new Rosella.Template.Node.Logic("Foo", "bar", factory);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Logic);
    }

    function parse() {
        self.status.verify("Test Rosella.Template.Node.Logic.parse()");
        var obj = new Rosella.Template.Node.Logic; // don't initialize, for this test /

        var arg_0 = "a b c d";
        var result = obj.parse(arg_0);
        self.assert.not_null(result);
        self.assert.does(result, "array");
        self.assert.equal(elements(result), 4);
    }

    function logic_name() {
        self.status.verify("Test Rosella.Template.Node.Logic.logic_name()");
        var obj = new Rosella.Template.Node.Logic;

        var result = obj.logic_name();
    }

    function logic_end_name() {
        self.status.verify("Test Rosella.Template.Node.Logic.logic_end_name()");
        var obj = new Rosella.Template.Node.Logic;
        obj.logic_name = "foo";

        var result = obj.logic_end_name();
        self.assert.equal(result, "endfoo");
    }

    function is_logic_end() {
        self.status.verify("Test Rosella.Template.Node.Logic.is_logic_end()");
        var obj = new Rosella.Template.Node.Logic;
        obj.logic_name = "endfoo";

        var result = obj.is_logic_end();
        self.assert.is_true(result);

        obj.logic_name = "foo";
        result = obj.is_logic_end();
        self.assert.is_false(result);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Logic);
}
