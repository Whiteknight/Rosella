class Test_Rosella_Template_Node_Data
{
    function test_new() {
        var obj = new Rosella.Template.Node.Data("Foo", "Bar");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Data);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Node.Data.render()");
        var obj = new Rosella.Template.Node.Data("foo", "");

        var arg_0 = null;
        var arg_1 = new Rosella.Template.Context({ "foo" : "FOO" });
        var arg_2 = new 'StringBuilder';
        var result = obj.render(arg_0, arg_1, arg_2);
        self.assert.equal(string(arg_2), "FOO");
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Data);
}
