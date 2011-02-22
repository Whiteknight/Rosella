class Rosella::Query::Provider::Hash is Rosella::Query::Provider {
    method map(%data, &mapper) {
        my %new_data := {};
        for %data {
            %new_data{$_} := &mapper(%data{$_});
        }
        return %new_data;
    }

    method filter(%data, &func, :$limit?) {
        if ! pir::defined($limit) {
            $limit := pir::elements(%data);
        }
        my %new_data := {};
        my $count := 0;
        for %data {
            my $name := $_;
            my $item := %data{$name};
            if &func($item) {
                %new_data{$name} := $item;
                $count := $count + 1;
                if $count > $limit {
                    return %new_data;
                }
            }
        }
        return %new_data;
    }

    # There really isn't a good way to do this in pure nqp if we want to
    # reuse the iterator
    method fold($seed, %data, &func) {
        return Q:PIR {
            .local pmc seed, data, func
            seed = find_lex "$seed"
            data = find_lex "%data"
            func = find_lex "&func"

            .local pmc h_iter, result
            h_iter = iter data
            if h_iter goto have_data
            .return(seed)

          have_data:
            $I0 = defined seed
            if $I0 goto have_seed
            seed = shift h_iter
          have_seed:
            if h_iter goto have_data_and_seed
            .return(seed)

          have_data_and_seed:
            result = seed

          loop_top:
            $P0 = shift h_iter
            result = func(result, $P0)
            if h_iter goto loop_top
            %r = result
        };
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
            my $key := &key_func($_, $value_b);
            Q:PIR {
                .local pmc new_data, key, conflict
                new_data = find_lex "%new_data"
                key = find_lex "$key"
                conflict = find_lex "$conflict"
                $I0 = exists new_data [key]
                conflict = $I0
            };
            if $conflict {
                %new_data{$key} := &dispute($key, %a{$_}, $value_b);
            } else {
                %new_data{$key} := $value_b;
            }
        }
        return %new_data;
    }
}
