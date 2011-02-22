module Rosella::Query {
    sub err_unknown_type($op, $data) {
        pir::die("Query: Don't know how to $op a " ~ pir::typeof__SP($data));
    }

    sub err_no_provider($data) {
        pir::die("Query: Can not find provider for " ~ pir::typeof__SP($data));
    }

    sub get_provider($data, $provider) {
        pir::say(pir::typeof__SP($data));
        if pir::defined($provider) {
            pir::say("A");
            return $provider;
        }
        if pir::does($data, "array") {
            pir::say("B");
            return Rosella::build(Rosella::Query::Provider::Array);
        }
        if pir::does($data, "hash") {
            pir::say("C");
            return Rosella::build(Rosella::Query::Provider::Hash);
        }
        pir::say("D");
    }

    our sub map($data, &mapper, :$provider?) {
        pir::say(pir::typeof__SP($data));
        $provider := get_provider($data, $provider);
        pir::say(pir::typeof__SP($provider));
        return $provider.map($data, &mapper);
    }

    our sub filter($data, &func, :$provider?) {
        $provider := get_provider($data, $provider);
        return $provider.filter($data, &func);
    }

    our sub fold($data, &func, :$seed?, :$provider?) {
        $provider := get_provider($data, $provider);
        return $provider.fold($data, &func);
    }
}
