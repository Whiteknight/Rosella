INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/event.pbc");
}

class MyTestClass {
    method test_method($event) { pir::say("test_method fired"); }
    method test_method_pos_args($event) {
        pir::say(pir::sprintf__SSP("%s,%s,%s", [$event[0], $event[1], $event[2]]));
    }
}

Rosella::Test::test(Test::Event::Queue);
class Test::Event::Queue {
    method test_BUILD() {
        my $q := Rosella::construct(Rosella::Event::Queue, 0);
        $!assert.not_null($q);
        $!assert.instance_of($q, Rosella::Event::Queue);
    }

    method can_raise() {
        $!status.unimplemented("Test this");
    }

    method enable() {
        $!status.unimplemented("Test this");
    }

    method set_accept_rule() {
        $!status.unimplemented("Test this");
    }

    method add_subscriber_action() {
        my $queue := Rosella::construct(Rosella::Event::Queue, 0);
        $queue.add_subscriber_action("Test", "Test", Rosella::construct(Rosella::Action::Sub, sub() {}));
    }

    method add_subscriber_object() {
        my $queue := Rosella::construct(Rosella::Event::Queue, 0);
        my $data := MyTestClass.new();
        $queue.add_subscriber_object("Test", "Foo", $data, "test_method");
    }

    method remove_subscriber() {
        my $queue := Rosella::construct(Rosella::Event::Queue, 0);
        my $data := MyTestClass.new();
        $queue.add_subscriber_object("Test", "Foo", $data, "test_method");
        $queue.remove_subscriber("Test", "Foo");
    }

    method remove_subscriber_none() {
        my $queue := Rosella::construct(Rosella::Event::Queue, 0);
        $queue.remove_subscriber("Test", "Foo");
    }

    method remove_subscribers_for_event() {
        $!status.unimplemented("Test this");
    }

    method raise_event() {
        my $queue := Rosella::construct(Rosella::Event::Queue, 0);
        my $event := Rosella::construct(Rosella::Event);
        my $data := MyTestClass.new();
        $queue.add_subscriber_object("Test", "Foo", $data, "test_method");
        $!assert.output_is({
            $queue.raise_event("Test", $event, [], {});
        }, "test_method fired\n");
    }
}
