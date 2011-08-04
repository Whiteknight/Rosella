class Test_Rosella_Template_Node_Data
{
    function test_new() {
        var token = new Rosella.String.Tokenizer.Token("Foo", "Bar", "Baz");
        var obj = new Rosella.Template.Node.Data(token);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Data);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Node.Data.render()");
        self.status.unimplemented("Find a way to test this");

        var token = new Rosella.String.Tokenizer.Token("Foo", "Bar", "Baz");
        var obj = new Rosella.Template.Node.Data();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.render(arg_0, arg_1, arg_2);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Data);
}
