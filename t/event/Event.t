INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/event.pbc");
}

Rosella::Test::test(Test::Event);
class Test::Event {
    method test_BUILD() {
        my $m := Rosella::construct(Rosella::Event);
        $!assert.not_null($m);
        $!assert.instance_of($m, Rosella::Event);
    }

    method get_pmc_keyed() {
        $!status.unimplemented("This");
    }

    method get_pmc_keyed_int() {
        $!status.unimplemented("This");
    }

    method positional_payload() {
        $!status.unimplemented("This");
    }

    method named_payload() {
        $!status.unimplemented("This");
    }

    method handled() {
        $!status.unimplemented("This");
    }

    method action_name() {
    }

    method prepare_to_raise() {
    }

    method set_active_subscriber() {
    }
}

