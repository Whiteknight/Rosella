class Rosella::Query::Provider::Array is Rosella::Query::Provider {
    method map(@data, &mapper) {
        my @new_data := [];
        my $i := 0;
        while $i < pir::elements(@data) {
            @new_data[$i] := &mapper(@data[$i]);
            $i := $i + 1;
        }
        return @new_data;
    }

    method filter(@data, &func, :$limit?) {
        if ! pir::defined($limit) {
            $limit := pir::elements(@data)
        }
        my @new_data := [];
        my $count := 0;
        for @data {
            my $item := $_;
            if &func($item) {
                pir::push(@new_data, $item);
                $count := $count + 1;
                if $count > $limit {
                    return @new_data;
                }
            }
        }
        return @new_data;
    }

    method fold($seed, @data, &func) {
        if ! pir::defined($seed) {
            $seed := pir::shift(@data);
        }
        my $result := $seed;
        for @data {
            $result := &func($result, $_);
        }
        return $result;
    }

    method take(@data, $limit, &func?) {
        if pir::defined(&func) {
            return self.filter(@data, &func, :limit($limit));
        }
        my $count := 0;
        my @new_data := [];
        for @data {
            my $item := $_;
            pir::push(@new_data, $item);
            $count := $count + 1;
            if $count > $limit {
                return @new_data;
            }
        }
        return @new_data;
    }

    method join(@a, @b, :&filter?, :&key_func?, :&dispute?) {
        if pir::defined(&filter) {
            @a := self.filter(@a, &filter);
            @b := self.filter(@b, &filter);
        }
        if pir::defined(&key_func) {
            if ! pir::defined(&dispute) {
                &dispute := sub($data_a, $data_b) { return $data_a; }
            }
            return self.join_key(@a, @b, &key_func, &dispute);
        }
        my @new_data := [];
        for @a {
            pir::push(@new_data, $_);
        }
        for @b {
            pir::push(@new_data, $_);
        }
        return @new_data;
    }

    method join_key(@a, @b, &key_func, &dispute) {
        my %keys := {};
        for @a {
            my $key := &key_func($_);
            %keys{$key} := $_;
        }
        my $conflict := 0;
        for @b {
            my $key := &key_func($_);
            my $value := $_;
            Q:PIR {
                .local pmc keys, key, conflict
                keys = find_lex "%keys"
                key = find_lex "$key"
                conflict = find_lex "$conflict"
                $I0 = exists keys [key]
                conflict = $I0
            };
            if $conflict {
                %keys{$key} := &dispute($key, %keys{$key}, $value);
            } else {
                %keys{$key} := $value;
            }
        }
        my @new_data := [];
        for %keys {
            pir::push(@new_data, %keys{$_});
        }
        return @new_data;
    }
}
