class ParrotContainer::Container {
    has %!library;

    sub new_hash(*%hash) { %hash; }

    method BUILD() {
        %!library := new_hash();
    }

    # Registration Methods

    # $init_pmc is passed to the init_pmc/instantiate vtable
    # @meth_inits is a list of MethodInitializers, invoked in order
    method register_type($type, :$init_pmc?, :@meth_inits?) {
        my $name := self.get_type_name($type);
        my $item := self.get_generator_item($init_pmc, @meth_inits);
        %!library{$name} := $item;
    }

    method register_prototype($type, $proto, :@meth_inits?) {
        my $name := self.get_type_name($type);
        my $item := self.get_prototype_item($proto, @meth_inits);
        %!library{$name} := $item;
    }

    method register_instance($instance, :@meth_inits?) {
        my $type := self.get_instance_type($instance);
        self.register_instance($type, $instance, :meth_inits(@meth_inits));
    }

    method register_instance($type, $instance, :@meth_inits?) {
        my $name := self.get_type_name($type);
        my $item := self.get_instance_item($instance, @meth_inits);
        %!library{$name} := $item;
    }

    # Resolve Methods

    # Full resolution. Look for a registered type to resolve. If not found,
    # attempt to create a fresh item of the given type.
    method resolve($type, *%named_opts) {
        my $name := self.get_type_name($type);
        my $item := %!library{$name};
        if pir::defined($item) {
            return $item.resolve(self, |%named_opts);
        }
        return self.resolve_create($type, |%named_opts);
    }

    # Create a new object only. Do not attempt to resolve from the library
    # of registered types
    method resolve_create($type, *%named_opts) {
        if pir::isa($type, "P6protoobject") {
            return $type.new();
        }
        my $init := %named_opts{"init_pmc"};
        my $class := self.get_type_class($type);
        if pir::defined($init) {
            return pir::new__PPP($class, $init);
        }
        return pir::new__PP($class);
    }

    # Resolve from the library only. Attempting to resolve a type that has
    # not previously been registered causes an error
    method resolve_nocreate($type, *%named_opts) {
        my $name := self.get_type_name($type);
        my $item := %!library{$name};
        if pir::defined($item) {
            return $item.resolve(self, |%named_opts);
        }
        pir::die("Type $name not registered");
    }

    # Get Item Methods
    # Get a ParrotContainer::Container::Item object for storing information
    # about a type

    # Get a Container::Item that returns an existing instance
    method get_instance_item($instance, @meth_inits) {
        my $item := create(ParrotContainer::Container::Item::Instance,
                $instance, @meth_inits);
        return $item;
    }

    # Get a Container::Item that returns a clone of an existing prototype
    method get_prototype_item($proto, @meth_inits) {
        my $item := create(ParrotContainer::Container::Item::Prototype,
                $proto, @meth_inits);
        return $item;
    }

    # Get a Container::Item that returns a factory-type resolver.
    # $type may any of the standard type identifier types.
    method get_generator_item($type, $init_pmc, @meth_inits) {
        my $item;
        # TODO: Arguments for BUILD?
        if pir::isa($type, "P6protoobject") {
            $item := create(ParrotContainer::Container::Item::P6protoobject,
                    $type, @meth_inits);
        } elsif pir::isa($type, "Class") {
            $item := create(ParrotContainer::Container::Item::ParrotClass,
                    $type, $init_pmc, @meth_inits);
        } else {
            my $class := self.get_type_class($type);
            $item := create(ParrotContainer::Container::Item::ParrotClass,
                    $class, $init_pmc, @meth_inits);
        }
        return $item;
    }

    # Helper Methods

    # Return a stringified type name for the object. $type could be a
    # NameSpace, a Class, a P6metaclass, a P6protoobject, a Key, a
    # *StringArray or a String.
    method get_type_name($type) {
        if pir::isa($type, "String") {
            return $type;
        }

        # If we have these objects, try to get the Parrot NameSpace for
        # easy stringification
        if pir::isa($type, "P6protoobject") {
            $type := $type.HOW().get_parrotclass().get_namespace();
        } elsif pir::isa($type, "P6metaclass") {
            $type := $type.get_parrotclass().get_namespace();
        } elsif pir::isa($type, "Class") {
            $type := $type.get_namespace();
        } elsif pir::isa($type, "Key") {
            $type := pir::get_namespace__PP($type);
        }

        if pir::isa($type, "NameSpace") {
            return pir::join("::", $type.get_name());
        }
        if pir::does($type, "Array") {
            return pir::join("::", $type);
        }
        return ~$type;
    }

    # Look up a Parrot Class PMC for the given type. $type can be any of
    # the PMC types used in get_type_name above
    method get_type_class($type) {
        if pir::isa($type, "Class") {
            return $type;
        }
        if pir::isa($type, "P6metaclass") {
            return $type.get_parrotclass();
        }
        if pir::isa($type, "P6protoobject") {
            return $type.HOW().get_parrotclass();
        }
        return pir::get_class__PP($type);
    }

    sub create($proto, *@pos, *%named) {
        return ParrotContainer::build($proto, @pos, %named);
    }
}


