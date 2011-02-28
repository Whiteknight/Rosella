class Rosella::Proxy::Factory {
    has $!target_class;
    has $!proxy_class;
    has @!builders;

    method BUILD($type, *@builders) {
        $!target_class := Rosella::get_type_class($type);
        @!builders := @builders;
        if pir::elements(@!builders) == 0 {
            my $builder := Rosella::build(Rosella::Proxy::Build::MethodIntercept);
            pir::push(@!builders, $builder);
        }
        $!proxy_class := pir::new__PS('Class');
        $!proxy_class.add_attribute('$!controller');
        $!proxy_class.add_attribute('$!factory');
        for @!builders {
            $_.setup_proxy_class($!target_class, $!proxy_class);
        }
    }

    method get_proxy($controller) {
        my $proxy := pir::new__PP($!proxy_class);
        pir::setattribute__vPSP($proxy, '$!factory', self);
        pir::setattribute__vPSP($proxy, '$!controller', $controller);
        for @!builders {
            $_.setup_proxy_object($proxy, $controller);
        }
        return $proxy;
    }
}
