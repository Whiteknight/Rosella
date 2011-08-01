class Test_Rosella_Template_Node_Factory
{
    function test_new() {
        var obj = new Rosella.Template.Node.Factory();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Factory);
    }

    function register_type() {
        self.status.verify("Test Rosella.Template.Node.Factory.register_type()");
        var obj = new Rosella.Template.Node.Factory();

        var arg_0 = "test";
        var arg_1 = class Rosella.Template.Node;
        obj.register_type(arg_0, arg_1);
    }

    function create() {
        self.status.verify("Test Rosella.Template.Node.Factory.create()");
        var obj = new Rosella.Template.Node.Factory();
        obj.register_type("Baz", class Rosella.Template.Node);

        var arg_0 = new Rosella.String.Tokenizer.Token("Foo", "Bar", "Baz");
        var result = obj.create(arg_0);
        self.assert.instance_of(result, class Rosella.Template.Node);
    }

    function create_typed() {
        self.status.verify("Test Rosella.Template.Node.Factory.create_typed()");
        var obj = new Rosella.Template.Node.Factory();

        var arg_0 = new Rosella.String.Tokenizer.Token("Foo", "Bar", "Baz");
        var result = obj.create_typed(class Rosella.Template.Node, arg_0);
        self.assert.instance_of(result, class Rosella.Template.Node);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Factory);
}
