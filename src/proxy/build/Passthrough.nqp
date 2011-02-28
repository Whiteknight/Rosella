# Sets up a proxy to contain a target object reference, and to pass through
# most behaviors to the target object.
class Rosella::Proxy::Build::Passthru {

    method setup_proxy_class($proxy_class) {
        $proxy_class.add_attribute('$!passthrough_target');
        # TODO: Set up the passthrough target object to receive most of
        #       the VTABLE fallbacks, so we can be a transparent immitator
        # This gets us transparent passthrough of most vtables
        $!methodproxy_class.add_parent($!target_class);
    }

    method setup_proxy_object($proxy, $controller) {
        my $target := Rosella::build($!target_class);
        pir::setattribute__vPSP($proxy, '$!passthrough_target', $target);
    }
}
