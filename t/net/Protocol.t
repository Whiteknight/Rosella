// Automatically generated test for Class Rosella.Net.Protocol
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.Protocol(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_Protocol
{
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Set options on the Suite, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/net.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Net_Protocol, initialize_test:[named("initialize")]);
}
