INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/event.pbc");
}

Rosella::Test::test(Event::Test);

class Event::Test {
    method test_BUILD() {
        my $m := Rosella::build(Rosella::Event, 0);
        Assert::not_null($m);
        Assert::instance_of($m, Rosella::Event);
    }

    method add_subscriber_action() {
        $!status.unimplemented("This");
    }

    method add_subscriber_object() {
        $!status.unimplemented("This");
    }

    method remove_subscriber() {
        $!status.unimplemented("This");
    }

    method get_count() {
        $!status.unimplemented("This");
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

    method raise() {
        $!status.unimplemented("This");
    }
}
