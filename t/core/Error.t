#! parrot-nqp
INIT {
    my $core := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::debug(1);
Rosella::Test::test(ErrorTest);

class ErrorTest {
    method throw_error() {
        $!assert.throws({
            Rosella::Error::throw_error("test");
        });
    }

    method ooopsie_doopsies()
    {
        $!assert.equal(0, 1);
    }

    # TODO: We need an Asserter method for matching error messages to test
    #       other stuff.
}
