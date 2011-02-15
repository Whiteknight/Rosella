class ParrotContainer::Container::Item
{
    has @!method_initializers;

    method method_initializers(@meth_inits) {
        if pir::defined(@meth_inits) {
            @!method_initializers := @meth_inits;
        } else {
            @!method_initializers := [];
        }
    }
}

class ParrotContainer::Container::Item::Instance
    is ParrotContainer::Container::Item
{
    has $!instance;

    method BUILD($obj, @meth_inits) {
        $!instance := $obj;
        self.method_initializers(@meth_inits);
    }
}

# Instantiate an object from a P6protoobject
class ParrotContainer::Container::Item::P6protoobject
    is ParrotContainer::Container::Item
{
    has $!proto;

    method BUILD($proto, @meth_inits) {
        $!proto := $proto;
        self.method_initializers(@meth_inits);
    }
}

# Instantiate an object from a ParrotClass
class ParrotContainer::Container::Item::ParrotClass
    is ParrotContainer::Container::Item
{
    has $!class;
    has $!init_pmc;

    method BUILD($class, $init_pmc, @meth_inits) {
        $!class := $class;
        $!init_pmc := $init_pmc;
        self.method_initializers(@meth_inits);
    }
}

# Instantiate an object from an object prototype
class ParrotContainer::Container::Item::Prototype
    is ParrotContainer::Container::Item::Instance
{
    has $!prototype;

    method BUILD($proto, @meth_inits) {
        $!prototype := $proto;
        self.method_initializers(@meth_inits);
    }
}
