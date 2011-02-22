module Rosella::Query {
    sub err_unknown_type($op, $data) {
        pir::die("Query: Don't know how to $op a " ~ pir::typeof__SP($data));
    }

    sub err_no_provider($data) {
        pir::die("Query: Can not find provider for " ~ pir::typeof__SP($data));
    }

    sub get_provider($data, $provider) {
        if pir::defined($provider) {
            return $provider;
        }
        if pir::does($data, "array") {
            return Rosella::build(Rosella::Query::Provider::Array);
        }
        if pir::does($data, "hash") {
            return Rosella::build(Rosella::Query::Provider::Hash);
        }
        err_no_provider($data);
    }

    our sub map($data, &mapper, :$provider?) {
        $provider := get_provider($data, $provider);
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
