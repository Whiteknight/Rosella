INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/event.pbc");
}

Rosella::Test::test(EventManagerTest);

class EventManagerTest is Rosella::Test::Testcase {
    method test_BUILD() {
        my $em := Rosella::build(Rosella::EventManager);
    }

    method test_register_event() {
        my $em := Rosella::build(Rosella::EventManager);
        my $count := 0;
        $em.register_event("Test",
            Rosella::build(Rosella::Event,
                :first(
                    Rosella::build(Rosella::Action::Sub,
                        sub($event) {
                            $count := $count + 1;
                        }
                    )
                )
            )
        );
        Assert::equal($count, 0, "not equal");
        $em.raise_event("Test");
        Assert::equal($count, 1, "not equal");
        $em.raise_event("Test");
        Assert::equal($count, 2, "not equal");
    }

    method test_register_event_multi() {
        my $em := Rosella::build(Rosella::EventManager);
        my $count := 0;
        $em.register_event("Test",
            Rosella::build(Rosella::Event,
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
            )
        );
        Assert::equal($count, 0, "not equal");
        $em.raise_event("Test");
        Assert::equal($count, 6, "not equal");
    }

    method test_register_event_payload() {
        my $em := Rosella::build(Rosella::EventManager);
        my $data := "Hello";
        $em.register_event("Test2",
            Rosella::build(Rosella::Event,
                :first(
                    Rosella::build(Rosella::Action::Sub,
                        sub($event) {
                            $data := $data ~ $event[0];
                        }
                    )
                )
            )
        );
        Assert::equal($data, "Hello", "not equal");
        $em.raise_event("Test2", " World!");
        Assert::equal($data, "Hello World!", "not equal");
    }

    method test_register_event_namedpayload() {
        my $em := Rosella::build(Rosella::EventManager);
        my $data := "Hello";
        $em.register_event("Test2",
            Rosella::build(Rosella::Event,
                :first(
                    Rosella::build(Rosella::Action::Sub,
                        sub($event) {
                            $data := $data ~ $event{"arg"};
                        }
                    )
                )
            )
        );
        Assert::equal($data, "Hello", "not equal");
        $em.raise_event("Test2", :arg(" World!"));
        Assert::equal($data, "Hello World!", "not equal");
    }
}
