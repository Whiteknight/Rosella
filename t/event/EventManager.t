INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/event.pbc");
}

Rosella::Test::test(Event::EventManager::Test);

class MyTestClass {
    our method test_subscribe($event?) { pir::say("test_subscribe fired"); }
}

class Event::EventManager::Test {
    method test_BUILD() {
        my $em := Rosella::build(Rosella::Event::Manager);
        Assert::not_null($em);
        Assert::instance_of($em, Rosella::Event::Manager);
    }

    method test_register_event() {
        my $em := Rosella::build(Rosella::Event::Manager);
        my $count := 0;
        $em.register_event("Test",
            Rosella::build(Rosella::Event, 0,
                :first(
                    Rosella::build(Rosella::Action::Sub,
                        sub($event) {
                            $count := $count + 1;
                        }
                    )
                )
            ), 0
        );
        Assert::equal($count, 0, "not equal");
        $em.raise_event("Test");
        Assert::equal($count, 1, "not equal");
        $em.raise_event("Test");
        Assert::equal($count, 2, "not equal");
    }

    method test_register_event_multi() {
        my $em := Rosella::build(Rosella::Event::Manager);
        my $count := 0;
        $em.register_event("Test",
            Rosella::build(Rosella::Event, 0,
                :first(
                    Rosella::build(Rosella::Action::Sub,
                        sub($event) {
                            $count := $count + 1;
                        }
                    )
                ),
                :second(
                    Rosella::build(Rosella::Action::Sub,
                        sub($event) {
                            $count := $count + 2;
                        }
                    )
                ),
                :third(
                    Rosella::build(Rosella::Action::Sub,
                        sub($event) {
                            $count := $count + 3;
                        }
                    )
                )
            ), 0
        );
        Assert::equal($count, 0, "not equal");
        $em.raise_event("Test");
        Assert::equal($count, 6, "not equal");
    }

    method test_register_event_payload() {
        my $em := Rosella::build(Rosella::Event::Manager);
        my $data := "Hello";
        $em.register_event("Test2",
            Rosella::build(Rosella::Event, 0,
                :first(
                    Rosella::build(Rosella::Action::Sub,
                        sub($event) {
                            $data := $data ~ $event[0];
                        }
                    )
                )
            ), 0
        );
        Assert::equal($data, "Hello", "not equal");
        $em.raise_event("Test2", " World!");
        Assert::equal($data, "Hello World!", "not equal");
    }

    method test_register_event_namedpayload() {
        my $em := Rosella::build(Rosella::Event::Manager);
        my $data := "Hello";
        $em.register_event("Test2",
            Rosella::build(Rosella::Event, 0,
                :first(
                    Rosella::build(Rosella::Action::Sub,
                        sub($event) {
                            $data := $data ~ $event{"arg"};
                        }
                    )
                )
            ), 0
        );
        Assert::equal($data, "Hello", "not equal");
        $em.raise_event("Test2", :arg(" World!"));
        Assert::equal($data, "Hello World!", "not equal");
    }

    method register_event_nonevent() {
        my $em := Rosella::build(Rosella::Event::Manager);
        Assert::throws({
            $em.register_event("foo", "foo", 0);
        });
    }

    method remove_event() {
        my $em := Rosella::build(Rosella::Event::Manager);
        my $data := "Hello";
        Assert::equal($em.count_events, 0);
        $em.register_event("Foo", Rosella::build(Rosella::Event, 0), 0);
        Assert::equal($em.count_events, 1);
        $em.remove_event("Foo");
        Assert::equal($em.count_events, 0);
    }

    method count_events() {
        my $em := Rosella::build(Rosella::Event::Manager);
        Assert::equal($em.count_events, 0);
    }

    method subscribe_object() {
        my $em := Rosella::build(Rosella::Event::Manager);
        my $data := MyTestClass.new();
        $em.subscribe_object("Foo", $data, "test_subscribe");
        Assert::output_is({
            $em.raise_event("Foo");
        }, "test_subscribe fired\n");
    }

    method subscribe_action() {
        my $em := Rosella::build(Rosella::Event::Manager);
        my $method := MyTestClass::test_subscribe;
        $em.subscribe_action("Foo",
            Rosella::build(Rosella::Action::Method, $method)
        );
        Assert::output_is({
            $em.raise_event("Foo");
        }, "test_subscribe fired\n");
    }

    method unsubscribe() {
        my $em := Rosella::build(Rosella::Event::Manager);
        my $method := MyTestClass::test_subscribe;
        my $id := $em.subscribe_action("Foo",
            Rosella::build(Rosella::Action::Method, $method)
        );
        $em.unsubscribe("Foo", $id);
        Assert::output_is({
            $em.raise_event("Foo");
        }, "");
    }

    method raise_event() {
        # Nothing should happen. I don't know how to test a negative like
        # that.
        my $em := Rosella::build(Rosella::Event::Manager);
        $em.raise_event("Foo");
    }
}
