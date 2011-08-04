INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "event", "mockobject");
}

Rosella::Test::test(Test::Event::Manager);

class MyTestClass {
    our method test_subscribe($event?) { pir::say("test_subscribe fired"); }
}

class Test::Event::Manager {
    method test_BUILD() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $!assert.not_null($em);
        $!assert.instance_of($em, Rosella::Event::Manager);
    }

    method register_event() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        my $count := 0;
        $em.register_event("Test", Rosella::construct(Rosella::Event));
        $em.subscribe_action("Test", Rosella::construct(Rosella::Action::Sub,
            sub($event) {
                $count := $count + 1;
            }
        ));
        $!assert.equal($count, 0, "not equal");
        $em.raise_event("Test");
        $!assert.equal($count, 1, "not equal");
        $em.raise_event("Test");
        $!assert.equal($count, 2, "not equal");
    }

    method register_event_multi() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        my $count := 0;
        $em.register_event("Test", Rosella::construct(Rosella::Event));
        $em.subscribe_action("Test", Rosella::construct(Rosella::Action::Sub,
            sub($event) {
                $count := $count + 1;
            }
        ));
        $em.subscribe_action("Test", Rosella::construct(Rosella::Action::Sub,
            sub($event) {
                $count := $count + 2;
            }
        ));
        $em.subscribe_action("Test", Rosella::construct(Rosella::Action::Sub,
            sub($event) {
                $count := $count + 3;
            }
        ));
        $!assert.equal($count, 0, "not equal");
        $em.raise_event("Test");
        $!assert.equal($count, 6, "not equal");
    }

    method register_event_payload() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        my $data := "Hello";
        $em.register_event("Test2", Rosella::construct(Rosella::Event));
        $em.subscribe_action("Test2", Rosella::construct(Rosella::Action::Sub,
            sub($event) {
                $data := $data ~ $event[0];
            }
        ));
        $!assert.equal($data, "Hello", "not equal");
        $em.raise_event("Test2", " World!");
        $!assert.equal($data, "Hello World!", "not equal");
    }

    method register_event_namedpayload() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        my $data := "Hello";
        $em.register_event("Test2", Rosella::construct(Rosella::Event));
        $em.subscribe_action("Test2", Rosella::construct(Rosella::Action::Sub,
            sub($event) {
                $data := $data ~ $event{"arg"};
            }
        ));
        $!assert.equal($data, "Hello", "not equal");
        $em.raise_event("Test2", :arg(" World!"));
        $!assert.equal($data, "Hello World!", "not equal");
    }

    method register_event_nonevent() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $!assert.throws({
            $em.register_event("foo", "foo");
        });
    }

    method remove_event() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        my $data := "Hello";
        $!assert.equal($em.count_events, 0);
        $em.register_event("Foo", Rosella::construct(Rosella::Event), 0);
        $!assert.equal($em.count_events, 1);
        $em.remove_event("Foo");
        $!assert.equal($em.count_events, 0);
    }

    method count_events() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $!assert.equal($em.count_events, 0);
    }

    method subscribe_object() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        my $data := MyTestClass.new();
        $em.subscribe_object("Foo", $data, "test_subscribe");
        $!assert.output_is({
            $em.raise_event("Foo");
        }, "test_subscribe fired\n");
    }

    method subscribe_action() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        my $method := MyTestClass::test_subscribe;
        $em.subscribe_action("Foo",
            Rosella::construct(Rosella::Action::Method, $method)
        );
        $!assert.output_is({
            $em.raise_event("Foo");
        }, "test_subscribe fired\n");
    }

    method unsubscribe() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        my $method := MyTestClass::test_subscribe;
        my $id := $em.subscribe_action("Foo",
            Rosella::construct(Rosella::Action::Method, $method)
        );
        $em.unsubscribe("Foo", $id);
        $!assert.output_is({
            $em.raise_event("Foo");
        }, "");
    }

    method add_queue() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $em.add_queue("Test");
    }

    method add_queue_default() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $!assert.is_true($em.toggle_queue(pir::null__S()));
        $em.add_queue(pir::null__S());
        $!assert.is_true($em.toggle_queue(pir::null__S()));
    }

    method remove_queue() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $em.add_queue("Test");
        $em.remove_queue("Test");
    }

    method remove_queue_default() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $!assert.is_true($em.toggle_queue(pir::null__S()));
        $em.remove_queue(pir::null__S());
        $!assert.is_false($em.toggle_queue(pir::null__S()));
    }

    method queue_accept_rule() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        my $accept := sub() {};
        my $c := Rosella::construct(Rosella::MockObject::Factory).create_typed(Rosella::Event::Queue);
        $c.expect_method("set_accept_func").once.with_args($accept);
        my $q := $c.mock;
        $em.add_queue("Test", $q);
        $em.queue_accept_rule("Test", $accept);
        $c.verify;
    }

    method toggle_queue() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $em.add_queue("Test");
        $!assert.is_true($em.toggle_queue("Test"));
        $em.toggle_queue("Test", 1);
        $!assert.is_true($em.toggle_queue("Test"));
        $em.toggle_queue("Test", 0);
        $!assert.is_false($em.toggle_queue("Test"));
        $em.toggle_queue("Test", 1);
        $!assert.is_true($em.toggle_queue("Test"));

    }

    method toggle_queue_default() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $!assert.is_true($em.toggle_queue(pir::null__S()));
        $em.toggle_queue(pir::null__S(), 1);
        $!assert.is_true($em.toggle_queue(pir::null__S()));
        $em.toggle_queue(pir::null__S(), 0);
        $!assert.is_false($em.toggle_queue(pir::null__S()));
        $em.toggle_queue(pir::null__S(), 1);
        $!assert.is_true($em.toggle_queue(pir::null__S()));
    }

    method toggle_queue_autocreate() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $em.toggle_queue("Test1", 1);
        $!assert.is_true($em.toggle_queue("Test1"));
        $em.toggle_queue("Test2", 0);
        $!assert.is_false($em.toggle_queue("Test2"));
    }

    method raise_event() {
        my $event := Rosella::construct(Rosella::Event);
        my $em := Rosella::construct(Rosella::Event::Manager);
        $em.register_event("Test", $event);

        my $cqueue := Rosella::construct(Rosella::MockObject::Factory).create_typed(Rosella::Event::Queue);
        # TODO: We need a matcher functionality to mockObject to be able to specify whether
        # args to be matched need to be .equal or .same.
        $cqueue.expect_method("can_raise").once.with_any_args.will_return(1);
        $cqueue.expect_method("raise_event").once.with_any_args();
        $em.add_queue("Foo", $cqueue.mock);
        $em.raise_event("Test");

        $cqueue.verify;
    }

    method raise_event_queue() {
        my $event := Rosella::construct(Rosella::Event);
        my $em := Rosella::construct(Rosella::Event::Manager);
        $em.register_event("Test", $event);

        my $cqueue := Rosella::construct(Rosella::MockObject::Factory).create_typed(Rosella::Event::Queue);
        # TODO: We need a matcher functionality to mockObject to be able to specify whether
        # args to be matched need to be .equal or .same.
        $cqueue.expect_method("can_raise").once.with_any_args.will_return(1);
        $cqueue.expect_method("raise_event").once.with_any_args();
        $em.add_queue("Foo", $cqueue.mock);
        $em.raise_event_queue("Test", "Foo");

        $cqueue.verify;
    }
}
