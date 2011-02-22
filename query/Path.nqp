class Rosella::Query::Path {
    has $!seperator;

    method BUILD($seperator?) {
        $!seperator := $seperator // ".";
    }

    method get($obj, $name) {
        if !pir::defined($name) || $name eq "" {
            #pir::say("Get: Found");
            return $obj;
        }
        #pir::say("Get: $name");
        if pir::does($obj, "hash") {
            my $result := self.try_get_hash($obj, $name);
            if !pir::isnull($result) && pir::defined($result) {
                return $result;
            }
        }
        return self.try_get_attribute($obj, $name);
    }

    sub hash_contains(%hash, $key) {
        return Q:PIR {
            $P0 = find_lex "%hash"
            $P1 = find_lex "$key"
            $I0 = exists $P0[$P1]
            %r = box $I0
        }
    }

    method try_get_hash(%obj, $name) {
        #pir::say("try_get_hash: $name");
        if hash_contains(%obj, $name) {
            #pir::say("try_get_hash: Found directly");
            return %obj{$name};
        }
        my $search := $name;
        my $remainder := "";
        my $idx := $name.reverse_index($!seperator, 0);
        while $idx != -1 {
            $search := pir::substr($search, 0, $idx);
            $remainder := pir::substr($name, $idx + 1);
            #pir::say("try_get_hash: searching $idx, $search, $remainder");
            if hash_contains(%obj, $search) {
                my $result := self.get(%obj{$search}, $remainder);
                if !pir::isnull($result) && pir::defined($result) {
                    return $result;
                }
            }
            $idx := $search.reverse_index($!seperator, 0);
        }
        return pir::new__PS("Undef");
    }

    method try_get_attribute($obj, $name) {
        #pir::say("try_get_attribute: $name");
        my $idx := pir::index__ISS($name, $!seperator);
        if $idx == -1 {
            return self.try_get_attribute_internal($obj, $name);
        }
        while $idx != -1 {
            my $attr := pir::substr($name, 0, $idx - 1);
            my $result := self.try_get_attribute_internal($obj, $attr);
            if !pir::isnull($result) && pir::defined($result) {
                return self.get($result, pir::substr($name, $idx));
            }
            $idx := pir::index__ISSI($name, $!seperator, $idx + 1);
        }
        return pir::new__PS("Undef");
    }

    method try_get_attribute_internal($obj, $name) {
        try {
            return pir::getattribute__PPS($obj, $name);
            CATCH {}
        }
        return pir::new__PS("Undef");
    }
}
