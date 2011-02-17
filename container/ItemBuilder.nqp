class Rosella::ItemBuilder
{
    has @!method_initializers;

    method method_initializers(@meth_inits) {
        if pir::defined(@meth_inits) {
            @!method_initializers := @meth_inits;
        } else {
            @!method_initializers := [];
        }
    }

    method resolve(*%options) {
        my $item := self.resolve_instance();
        for @!method_initializers {
            $_.execute($item);
        }
        return $item;
    }

    method resolve_instance() {
        pir::die("Must use a subclass");
    }
}

class Rosella::ItemBuilder::Instance
    is Rosella::ItemBuilder
{
    has $!instance;

    method BUILD($obj, @meth_inits) {
        $!instance := $obj;
        self.method_initializers(@meth_inits);
    }

    method resolve_instance() {
        return $!instance;
    }
}

# Instantiate an object from a P6protoobject
class Rosella::ItemBuilder::P6protoobject
    is Rosella::ItemBuilder
{
    has $!proto;

    method BUILD($proto, @meth_inits) {
        $!proto := $proto;
        self.method_initializers(@meth_inits);
    }

    method resolve_instance() {
        return $!proto.new();
    }
}

# Instantiate an object from a ParrotClass
class Rosella::ItemBuilder::ParrotClass
    is Rosella::ItemBuilder
{
    has $!class;
    has $!init_pmc;

    method BUILD($class, $init_pmc, @meth_inits) {
        $!class := $class;
        $!init_pmc := $init_pmc;
        self.method_initializers(@meth_inits);
    }

    method resolve_instance() {
        if pir::defined($!init_pmc) {
            return pir::new__PPP($!class, $!init_pmc);
        }
        return pir::new__PP($!class);
    }
}

# Instantiate an object from an object prototype
class Rosella::ItemBuilder::Prototype
    is Rosella::ItemBuilder
{
    has $!prototype;

    method BUILD($proto, @meth_inits) {
        $!prototype := $proto;
        self.method_initializers(@meth_inits);
    }

    method resolve_instance() {
        return pir::clone($!prototype);
    }
}

class Rosella::ItemBuilder::FactoryMethod
    is Rosella::ItemBuilder
{
    has &!sub;
    has @!arg_initializers;

    method BUILD($sub, @meth_inits, @arg_inits) {
        &!sub := $sub;
        @!arg_initializers := @arg_inits;
        self.method_initializers(@meth_inits);
    }

    method resolve_instance() {
        my @pos := [];
        my %named := {};
        for @!arg_initializers {
            $_.prepare_args(@pos, %named);
        }
        my $obj := &!sub(|@pos, |%named);
    }
}
