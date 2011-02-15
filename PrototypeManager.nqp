# A basic class for handling prototypes only. Much lighter-weight than
# ParrotContainer::Container
class ParrotContainer::PrototypeManager {
    has %!library;

    sub new_hash(*%hash) { %hash; }

    method initialize(*%lib) {
        %!library := new_hash(|%lib);
    }

    method add_prototype($name, $proto) {
        %!library{$name} := $proto;
    }

    method instance($name) {
        return pir::clone(%!library{$name});
    }
}
