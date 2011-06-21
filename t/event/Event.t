INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/event.pbc");
}

Rosella::Test::test(Event::Test);

class MyTestClass {
    method test_method($event) { pir::say("test_method fired"); }
    method test_method_pos_args($event) {
        pir::say(pir::sprintf__SSP("%s,%s,%s", [$event[0], $event[1], $event[2]]));
    }
}

class Event::Test {
    method test_BUILD() {
        my $m := Rosella::construct(Rosella::Event, 0);
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

