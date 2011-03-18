# Begin generated code

.loadlib "io_ops"
# end libs
.namespace [ 'WinxedDistutils' ]

.sub 'winxed_setup'
.annotate 'file', 'Distutils.winxed'
.annotate 'line', 6
# Body
# {
# predefined load_bytecode
.annotate 'line', 8
    load_bytecode "distutils.pbc"
.annotate 'line', 9
    get_hll_global $P1, 'setup'
.annotate 'line', 10
    get_hll_global $P2, 'register_step_before'
.annotate 'line', 12
.const 'Sub' $P3 = 'build_winxed'
.annotate 'line', 13
.const 'Sub' $P4 = 'clean_winxed'
.annotate 'line', 14
    $P2("build", $P3)
.annotate 'line', 15
    $P2("clean", $P4)
# }
.annotate 'line', 16

.end # winxed_setup


.sub 'build_winxed'
        .param pmc __ARG_1 :named :slurpy
.annotate 'line', 19
# Body
# {
.annotate 'line', 21
# var winxed_files: $P1
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 22
    unless_null $P1, __label_0
.annotate 'line', 23
    .return()
 __label_0: # endif
.annotate 'line', 24
    get_hll_global $P2, 'newer'
.annotate 'line', 25
    iter $P3, $P1
    set $P3, 0
 __label_1: # for iteration
    unless $P3 goto __label_2
    shift $S1, $P3
# {
.annotate 'line', 26
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 27
# e: $I1
    null $I1
.annotate 'line', 28
# pirop stat
    stat $I1, $S1, 0
.annotate 'line', 29
    not $I2, $I1
    if $I2 goto __label_4
    $I2 = $P2($S2, $S1)
 __label_4:
    unless $I2 goto __label_3
.annotate 'line', 30
    'compile_to_pir'($S2, $S1)
 __label_3: # endif
# }
    goto __label_1
 __label_2: # endfor
# }
.annotate 'line', 32

.end # build_winxed


.sub 'clean_winxed'
        .param pmc __ARG_1 :named :slurpy
.annotate 'line', 35
# Body
# {
.annotate 'line', 37
# var winxed_files: $P1
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 38
    unless_null $P1, __label_0
.annotate 'line', 39
    .return()
 __label_0: # endif
.annotate 'line', 40
# num_files: $I1
# predefined elements
    elements $I1, $P1
.annotate 'line', 41
    get_hll_global $P2, 'unlink'
.annotate 'line', 42
    iter $P3, $P1
    set $P3, 0
 __label_1: # for iteration
    unless $P3 goto __label_2
    shift $S1, $P3
# {
.annotate 'line', 43
# e: $I2
    null $I2
.annotate 'line', 44
# pirop stat
    stat $I2, $S1, 0
.annotate 'line', 45
    unless $I2 goto __label_3
# {
.annotate 'line', 46
    concat $S2, "unlink ", $S1
# predefined say
    say $S2
.annotate 'line', 47
    $P2($S1)
# }
 __label_3: # endif
# }
    goto __label_1
 __label_2: # endfor
# }
.annotate 'line', 50

.end # clean_winxed


.sub 'get_pir_file_name'
        .param string __ARG_1
.annotate 'line', 53
# Body
# {
.annotate 'line', 55
# index: $I1
    null $I1
.annotate 'line', 56
# pirop index
    index $I1, __ARG_1, ".winxed"
.annotate 'line', 57
    ne $I1, -1, __label_0
.annotate 'line', 58
    concat $S2, __ARG_1, " is not a winxed file"
# predefined die
    die $S2
 __label_0: # endif
.annotate 'line', 59
# pir_file: $S1
    null $S1
.annotate 'line', 60
# pirop substr
    substr $S1, __ARG_1, 0, $I1
.annotate 'line', 61
    concat $S2, $S1, ".pir"
    .return($S2)
# }
.annotate 'line', 62

.end # get_pir_file_name


.sub 'compile_to_pir'
        .param string __ARG_1
        .param string __ARG_2
.annotate 'line', 65
# Body
# {
.annotate 'line', 67
# cmd: $S1
    concat $S1, "winxed -o ", __ARG_2
    concat $S1, $S1, " -c "
    concat $S1, $S1, __ARG_1
.annotate 'line', 68
# result: $I1
    null $I1
.annotate 'line', 69
# predefined say
    say $S1
.annotate 'line', 70
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 71
    eq $I1, 0, __label_0
.annotate 'line', 72
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
 __label_0: # endif
# }
.annotate 'line', 73

.end # compile_to_pir

# End generated code
