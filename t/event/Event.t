INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "event");
}

sub hash(*%h) { %h }

Rosella::Test::test(Test::Event);
class Test::Event {
    method test_BUILD() {
        my $m := Rosella::construct(Rosella::Event);
        $!assert.not_null($m);
        $!assert.instance_of($m, Rosella::Event);
    }

    method get_pmc_keyed() {
        my $m := Rosella::construct(Rosella::Event);
        my %a := hash(:a("a"), :b("b"), :c("c"));
        $m.prepare_to_publish([], %a);
        $!assert.equal($m{"a"}, "a");
        $!assert.equal($m{"b"}, "b");
        $!assert.equal($m{"c"}, "c");
    }

    method get_pmc_keyed_int() {
        my $m := Rosella::construct(Rosella::Event);
        $m.prepare_to_publish([1, 2, 3, 4], {});
        $!assert.equal($m[0], 1);
        $!assert.equal($m[1], 2);
        $!assert.equal($m[2], 3);
        $!assert.equal($m[3], 4);
    }

    method positional_payload() {
        my $m := Rosella::construct(Rosella::Event);
        my $a := [1, 2, 3, 4];
        $m.prepare_to_publish($a, {});
        $!assert.same($m.positional_payload, $a);
    }

    method named_payload() {
        my $m := Rosella::construct(Rosella::Event);
        my $a := {};
        $m.prepare_to_publish([], $a);
        $!assert.same($m.named_payload, $a);
    }

    method prepare_to_publish() {
        my $m := Rosella::construct(Rosella::Event);
        $m.prepare_to_publish([], {});
    }

    method subscribe() {
        $!status.unimplemented("Implement this");
    }

    method unsubscribe() {
        $!status.unimplemented("Implement this");
    }

    method publish() {
        $!status.unimplemented("Implement this");
    }

}

