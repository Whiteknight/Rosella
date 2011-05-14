class FunctionCompositor {
    method add($func_a, $func_b) {
        return sub (*@args) { return $func_a(|@args) + $func_b(|@args); }
    }

    method add_const($func, $const) {
        return sub (*@args) { return $func(|@args) + $const; }
    }

    method subtract($func_a, $func_b) {
        return sub (*@args) { return $func_a(|@args) - $func_b(|@args); }
    }

    method subtract_const($func, $const) {
        return sub (*@args) { return $func(|@args) - $const; }
    }

    method negate($func) {
        return sub (*@args) { return -$func(|@args); }
    }

    method multiply($func_a, $func_b) {
        return sub (*@args) { return $func_a(|@args) * $func_b(|@args); }
    }

    method multiply_const($func, $const) {
        return sub (*@args) { return $func(|@args) * $const; }
    }

    method divide($func_a, $func_b) {
        return sub (*@args) { return $func_a(|@args) / $func_b(|@args); }
    }

    method divide_const($func, $const) {
        return sub (*@args) { return $func(|@args) / $const; }
    }

    method invert($func, $const = 1) {
        return sub (*@args) { return $const / $func(|@args); }
    }

    method compose($func_a, $func_b) {
        return sub (*@args) { return $func_a($func_b(|@args)); }
    }
}

class SymbolicFunctionGenerator {
    method constant ($const) { return sub ($val) { "$val"; } }
    method line ($m, $b) { return sub ($val) { "$m($val) + $b"; } }
    method parabola($m, $a, $b) { return sub($val) { "$m($val)^2 + $a($val) + $b"; } }
    method impulse() { return sub ($val) { "d($val)"; } }
    method step() { return sub($val) { "u($val)"; } }
    method sin($a, $b) { return sub($val) { "sin($val)"; } }
    method cos($a, $b) { return sub($val) { "cos($val)"; } }
    method pow_a($a) { return sub($val) { "$val ^ $a"; } }
    method pow_b($a) { return sub($val) { "$a ^ $val"; } }
    method exp() { return sub($val) { "e^$val"; } }
    method log($b) { return sub($val) { "log_$b($val)"; } }
    method ln() { return sub($val) { "ln($val)"; } }
}

class SymbolicValue {
    method add is pirtags<:vtable(add_pmc)> ($a, $b, $c) { return "$a + $b"; }
    method sub is pirtags<:vtable(sub_pmc)> ($a, $b, $c) { return "$a - $b"; }
    method mul is pirtags<:vtable(add_pmc)> ($a, $b, $c) { return "$a * $b"; }
    method div is pirtags<:vtable(add_pmc)> ($a, $b, $c) { return "$a / $b"; }
}

class NumericFunctionGenerator {
    method constant() { return sub ($val) { return $val; } }

    method line($m, $b) { return sub ($val) { return $m * $val + $b; } }

    method parabola($m, $a, $b) { return sub ($val) { return ($val * $val * $m) + ($val * $a) + $b; } }

    method impulse() {
        return sub ($val) {
            if ($val != 0) return 0;
            return 1;
        }
    }

    method step() {
        return sub($val) {
            if ($at < 0) return 0;
            return 1;
        }
    }

    method sin($a, $b) { return sub ($val) { return pir::sin($a * $val + $b); } }
    method cos($a, $b) { return sub ($val) { return pir::cos($a * $val + $b); } }
    method tan($a, $b) { return sub ($val) { return pir::tan($a * $val + $b); } }
    method pow_a($a) { return sub ($val) { return pir::pow($val, $a); } }
    method pow_b($b) { return sub ($val) { return pir::pow($b, $val); } }
    method exp($a, $b) {}
    method log() {}
    method ln() {}
}


