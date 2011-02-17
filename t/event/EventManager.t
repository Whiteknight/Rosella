INIT {
    pir::load_bytecode("parrot_test_xunit.pbc");
    pir::load_bytecode("parrot_container_action.pbc");
    pir::load_bytecode("parrot_container_event.pbc");
}

EventManagerTest.suite.run();

class EventManagerTest is ParrotTest::Testcase {
    method test_BUILD() {
        my $em := ParrotContainer::build(ParrotContainer::EventManager);
    }

    method test_register_event() {
        my $em := ParrotContainer::build(ParrotContainer::EventManager);
        my $count := 0;
        $em.register_event("Test",
            ParrotContainer::build(ParrotContainer::Event,
                :first(
                    ParrotContainer::build(ParrotContainer::Action::Sub,
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
        my $em := ParrotContainer::build(ParrotContainer::EventManager);
        my $count := 0;
        $em.register_event("Test",
            ParrotContainer::build(ParrotContainer::Event,
                :first(
                    ParrotContainer::build(ParrotContainer::Action::Sub,
                        sub($event) {
                            $count := $count + 1;
                        }
                    )
                ),
                :second(
                    ParrotContainer::build(ParrotContainer::Action::Sub,
                        sub($event) {
                            $count := $count + 2;
                        }
                    )
                ),
                :third(
                    ParrotContainer::build(ParrotContainer::Action::Sub,
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
        my $em := ParrotContainer::build(ParrotContainer::EventManager);
        my $data := "Hello";
        $em.register_event("Test2",
            ParrotContainer::build(ParrotContainer::Event,
                :first(
                    ParrotContainer::build(ParrotContainer::Action::Sub,
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
        my $em := ParrotContainer::build(ParrotContainer::EventManager);
        my $data := "Hello";
        $em.register_event("Test2",
            ParrotContainer::build(ParrotContainer::Event,
                :first(
                    ParrotContainer::build(ParrotContainer::Action::Sub,
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
