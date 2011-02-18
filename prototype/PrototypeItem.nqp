class Rosella::Prototype::Item {
    has $!prototype;
    has &!constructor;

    method BUILD($proto, &sub?) {
        $!prototype := $proto;
        if pir::defined(&sub) {
            &!constructor := &sub;
        }
    }

    method create(@pos, %named) {
        my $item := pir::clone($!prototype);
        if pir::defined(&!constructor) {
            Rosella::call_parrot_method($item, &!constructor, @pos, %named);
        }
        retutn $item;
    }

    method prototype($proto?) {
        if pir::defined($proto) {
            $!prototype := $proto;
        }
        $!prototype;
    }

    method constructor(&sub?) {
        if pir::defined(&sub) {
            &!constructor := &sub;
        }
        return &!constructor;
    }
}
