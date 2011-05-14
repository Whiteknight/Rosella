# Begin generated code

.loadlib "io_ops"
# end libs
.namespace [ 'Rosella'; 'Winxed'; 'Distutils' ]

.sub 'winxed_setup'
# Body
# {
# predefined load_bytecode
.annotate 'file', 'src/winxed/Distutils.winxed'
.annotate 'line', 9
    load_bytecode "distutils.pbc"
.annotate 'line', 10
    get_hll_global $P1, 'setup'
.annotate 'line', 11
    get_hll_global $P2, 'register_step_before'
.annotate 'line', 13
.const 'Sub' $P3 = 'build_winxed'
.annotate 'line', 14
.const 'Sub' $P4 = 'clean_winxed'
.annotate 'line', 15
    $P2("build", $P3)
.annotate 'line', 16
    $P2("clean", $P4)
# }
.annotate 'line', 17

.end # winxed_setup


.sub 'build_winxed'
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 22
# var winxed_files: $P1
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 23
    unless_null $P1, __label_0
.annotate 'line', 24
    .return()
  __label_0: # endif
.annotate 'line', 25
    get_hll_global $P2, 'newer'
.annotate 'line', 26
    iter $P3, $P1
    set $P3, 0
  __label_1: # for iteration
    unless $P3 goto __label_2
    shift $S1, $P3
# {
.annotate 'line', 27
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 28
# e: $I1
    null $I1
.annotate 'line', 29
# pirop stat
    stat $I1, $S1, 0
.annotate 'line', 30
    not $I2, $I1
    if $I2 goto __label_4
    $I2 = $P2($S2, $S1)
  __label_4:
    unless $I2 goto __label_3
.annotate 'line', 31
    'compile_to_pir'($S2, $S1)
  __label_3: # endif
# }
    goto __label_1
  __label_2: # endfor
# }
.annotate 'line', 33

.end # build_winxed


.sub 'clean_winxed'
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 38
# var winxed_files: $P1
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 39
    unless_null $P1, __label_0
.annotate 'line', 40
    .return()
  __label_0: # endif
.annotate 'line', 41
# num_files: $I1
# predefined elements
    elements $I1, $P1
.annotate 'line', 42
    get_hll_global $P2, 'unlink'
.annotate 'line', 43
    iter $P3, $P1
    set $P3, 0
  __label_1: # for iteration
    unless $P3 goto __label_2
    shift $S1, $P3
# {
.annotate 'line', 44
# e: $I2
    null $I2
.annotate 'line', 45
# pirop stat
    stat $I2, $S1, 0
.annotate 'line', 46
    unless $I2 goto __label_3
# {
.annotate 'line', 47
    concat $S2, "unlink ", $S1
# predefined say
    say $S2
.annotate 'line', 48
    $P2($S1)
# }
  __label_3: # endif
# }
    goto __label_1
  __label_2: # endfor
# }
.annotate 'line', 51

.end # clean_winxed


.sub 'get_pir_file_name'
        .param string __ARG_1
# Body
# {
.annotate 'line', 56
# index: $I1
    null $I1
.annotate 'line', 57
# pirop index
    index $I1, __ARG_1, ".winxed"
.annotate 'line', 58
    ne $I1, -1, __label_0
.annotate 'line', 59
    concat $S2, __ARG_1, " is not a winxed file"
# predefined die
    die $S2
  __label_0: # endif
.annotate 'line', 60
# pir_file: $S1
    null $S1
.annotate 'line', 61
# pirop substr
    substr $S1, __ARG_1, 0, $I1
.annotate 'line', 62
    concat $S2, $S1, ".pir"
    .return($S2)
# }
.annotate 'line', 63

.end # get_pir_file_name


.sub 'compile_to_pir'
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 68
# cmd: $S1
    concat $S1, "winxed --nowarn -o ", __ARG_2
    concat $S1, $S1, " -c "
    concat $S1, $S1, __ARG_1
.annotate 'line', 69
# result: $I1
    null $I1
.annotate 'line', 70
# predefined say
    say $S1
.annotate 'line', 71
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 72
    eq $I1, 0, __label_0
.annotate 'line', 73
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_0: # endif
# }
.annotate 'line', 74

.end # compile_to_pir

# End generated code
