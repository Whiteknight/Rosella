class Rosella::Proxy::Build::MethodIntercept is Rosella::Proxy::Build {
    # setup the method intercepter on the proxy class.
    method setup_proxy_class($proxy_class) {
        # TODO: Find the old VTABLE_find_method entry, and add that to
        #       the fallback logic
        $!methodproxy_class.add_vtable_override("find_method",
            Rosella::Proxy::Factory::VTABLE_find_method
        );

    }

    # We don't need to do anything for the instance
    method setup_proxy_object($proxy, $controller) {
    }

    our method methodproxy_find_method($name) {
        my $controller := pir::getattribute__PPS(self, '$!controller');
        my $target := pir::getattribute__PPS(self, '$!target');
        return $controller.find_method(self, $name);
    }
}
