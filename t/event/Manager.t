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
        $em.register_event("Foo", Rosella::construct(Rosella::Event));
        $!assert.equal($em.count_events, 1);
        $em.remove_event("Foo");
        $!assert.equal($em.count_events, 0);
    }

    method count_events() {
        my $em := Rosella::construct(Rosella::Event::Manager);
        $!assert.equal($em.count_events, 0);
    }

    method get_event() {
        $!status.unimplemented("Do this");
    }

    method create_event() {
        $!status.unimplemented("Do this");
    }

    method get_pmc_keyed() {
        $!status.unimplemented("Do this");
    }

    method set_pmc_keyed() {
        $!status.unimplemented("Do this");
    }

    method elements() {
        $!status.unimplemented("Do this");
    }

    method delete_keyed() {
        $!status.unimplemented("Do this");
    }

    method exists_keyed() {
        $!status.unimplemented("Do this");
    }
}
