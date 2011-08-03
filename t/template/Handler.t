class Test_Rosella_Template_Handler
{
    function test_new() {
        var obj = new Rosella.Template.Handler();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler);
    }

    function add_child() {
        self.status.verify("Test Rosella.Template.Handler.add_child()");
        var obj = new Rosella.Template.Handler();

        self.assert.throws(function() {
            var arg_0 = null;
            var result = obj.add_child(arg_0);
        });
    }

    function render() {
        self.status.verify("Test Rosella.Template.Handler.render()");
        var obj = new Rosella.Template.Handler();

        self.assert.throws(function() {
            var arg_0 = null;
            var arg_1 = null;
            var arg_2 = null;
            var result = obj.render(arg_0, arg_1, arg_2);
        });
    }

    function can_have_children() {
        self.status.verify("Test Rosella.Template.Handler.can_have_children()");
        var obj = new Rosella.Template.Handler();

        var result = obj.can_have_children();
        self.assert.is_false(result);
    }

    function __save_ctx_values() {
        var obj = new Rosella.Template.Handler();
        var ctx = new Rosella.Template.Context({"Foo" : "bar", "Baz" : "fie"});
        obj.__save_ctx_values(function() {
            ctx.set_temporary("Foo", "a");
            ctx.set_temporary("Bar", "b");
        }, ctx, "Foo");
        self.assert.equal(ctx["Foo"], "bar");
        self.assert.equal(ctx["Bar"], "b");
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Handler);
}
