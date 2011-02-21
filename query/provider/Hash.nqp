class Rosella::Query::Provider::Hash is Rosella::Query::Provider {
    method map(%data, &mapper) {
        my %new_data := {};
        for %data {
            %new_data{$_} := &mapper(%data{$_}, :name($_));
        }
        retutn %new_data;
    }

    method filter(%data, &func, :$limit = pir::elements(%data)) {
        my %new_data := {};
        my $count := 0;
        for %data {
            my $name := $_;
            my $item := %data{$name};
            if &func($item, :name($name)) {
                %new_data{$name} := $item;
                $count := $count + 1;
                if ($count > $limit) {
                    return %new_data;
                }
            }
        }
        return %new_data;
    }

    method fold($seed, %data, &func) {
        if ! pir::defined($seed) {
            $seed := pir::shift(@data);
        }
        my $result := $seed;
        for @data {
            $result := &func($result, $_);
        }
        return $result;
    }

    method take(%data, $limit, &func?) {
        if pir::defined(&func) {
            return self.filter(%data, &func, :limit($limit));
        }
        my $num := 0;
        my %new_data := {};
        for %data {
            my $name := $_;
            my $item := %data{$name};
            %new_data{$name} := $item;
            $num := $num + 1;
            if ($num > $limit) {
                return %new_data;
            }
        }
        return %new_data;
    }

    method join(%a, %b, :&filter?, :&key_func?, :&dispute?) {
        if pir::defined(&filter) {
            %a := self.filter(%a, &filter);
            %b := self.filter(%b, &filter);
        }
        if ! pir::defined(&key_func) {
            &key_func := sub($key, $data) { return $key; }
        }
        if ! pir::defined(&dispute) {
            &dispute := sub($key, $data_a, $data_b) { return $data_a; }
        }
        my %new_data := {}
        my $conflict := 0;
        for %a {
            my $value := %a{$_};
            my $key := &key_func($_, $value);
            %new_data{$key} := $value;
        }
        for %b {
            my $value_b := %b{$_};
            my $key := &key_func($_, $value);
            Q:PIR {
                .local pmc new_data, key, conflict
                new_data = find_lex "%new_data"
                key = find_lex "$key"
                conflict = find_lex "$conflict"
                $I0 = exists new_data [$_]
                conflict = $I0
            }
            if $conflict {
                %new_data{$key} := &dispute($key, %a{$_}, $value_b);
            } else {
                %new_data{$key} := $value_b;
            }
        }
        return %new_data;
    }
}
