INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "event");
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
        my $q := Rosella::construct(Rosella::Event::Queue, 0);
        $!assert.is_false($q.can_raise("Test", "Test"));
        $q.add_subscriber_action("Test", "Test", Rosella::construct(Rosella::Action::Sub, sub() {}));
        $!assert.is_true($q.can_raise("Test", "Test"));
    }

    method enable() {
        my $q := Rosella::construct(Rosella::Event::Queue, 0);
        $!assert.is_false($q.can_raise("Test", "Test"));
        $q.add_subscriber_action("Test", "Test", Rosella::construct(Rosella::Action::Sub, sub() {}));
        $!assert.is_true($q.can_raise("Test", "Test"));
        $q.enable(0);
        $!assert.is_false($q.can_raise("Test", "Test"));
        $q.enable(1);
        $!assert.is_true($q.can_raise("Test", "Test"));
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
        my $q := Rosella::construct(Rosella::Event::Queue, 0);
        $q.add_subscriber_action("Foo", "Test", Rosella::construct(Rosella::Action::Sub, sub() {}));
        $q.add_subscriber_action("Bar", "Test", Rosella::construct(Rosella::Action::Sub, sub() {}));
        $!assert.is_true($q.can_raise("Foo", "Test"));
        $!assert.is_true($q.can_raise("Bar", "Test"));
        $q.remove_subscribers_for_event("Foo");
        $!assert.is_false($q.can_raise("Foo", "Test"));
        $!assert.is_true($q.can_raise("Bar", "Test"));
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
