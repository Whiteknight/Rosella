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
        my $m := Rosella::build(Rosella::Event, 0);
        $!assert.not_null($m);
        $!assert.instance_of($m, Rosella::Event);
    }

    method add_subscriber_action() {
        my $m := Rosella::build(Rosella::Event, 0);
        $!assert.equal($m.num_subscribers, 0);
        $m.add_subscriber_action("Foo",
            Rosella::build(Rosella::Action::Sub, sub() {})
        );
        $!assert.equal($m.num_subscribers, 1);
    }

    method add_subscriber_object() {
        my $m := Rosella::build(Rosella::Event, 0);
        my $data := MyTestClass.new();
        $!assert.equal($m.num_subscribers, 0);
        $m.add_subscriber_object("Foo", $data, "test_method");
        $!assert.equal($m.num_subscribers, 1);
    }

    method remove_subscriber() {
        my $m := Rosella::build(Rosella::Event, 0);
        my $data := MyTestClass.new();
        $!assert.equal($m.num_subscribers, 0);
        $m.add_subscriber_object("Foo", $data, "test_method");
        $!assert.equal($m.num_subscribers, 1);
        $m.remove_subscriber("Foo");
        $!assert.equal($m.num_subscribers, 0);
    }

    method remove_subscriber_none() {
        my $m := Rosella::build(Rosella::Event, 0);
        $!assert.equal($m.num_subscribers, 0);
        $m.remove_subscriber("Foo");
        $!assert.equal($m.num_subscribers, 0);
    }

    method get_count() {
        my $m := Rosella::build(Rosella::Event, 0);
        $!assert.equal($m.get_count, 0);
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
        my $m := Rosella::build(Rosella::Event, 0);
        my $data := MyTestClass.new();
        $m.add_subscriber_object("Foo", $data, "test_method");
        $!assert.output_is({
            $m.raise();
        }, "test_method fired\n");
    }

    method raise_args() {
        my $m := Rosella::build(Rosella::Event, 0);
        my $data := MyTestClass.new();
        $m.add_subscriber_object("Foo", $data, "test_method_pos_args");
        $!assert.output_is({
            $m.raise(1, 2, 3);
        }, "1,2,3\n");
    }
}
