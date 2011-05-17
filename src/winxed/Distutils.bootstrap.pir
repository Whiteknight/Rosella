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
    get_hll_global $P1, 'register_step_before'
.annotate 'line', 12
.const 'Sub' $P2 = 'build_winxed'
.annotate 'line', 13
.const 'Sub' $P3 = 'clean_winxed'
.annotate 'line', 14
.const 'Sub' $P4 = 'build_winxed_const_includes'
.annotate 'line', 15
.const 'Sub' $P5 = 'clean_winxed_const_includes'
.annotate 'line', 17
    $P1("build", $P2)
.annotate 'line', 18
    $P1("build", $P4)
.annotate 'line', 19
    $P1("clean", $P3)
.annotate 'line', 20
    $P1("clean", $P5)
# }
.annotate 'line', 21

.end # winxed_setup


.sub 'build_winxed'
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 26
# var winxed_files: $P1
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 27
    unless_null $P1, __label_1
.annotate 'line', 28
    .return()
  __label_1: # endif
.annotate 'line', 29
    get_hll_global $P2, 'newer'
.annotate 'line', 30
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
# {
.annotate 'line', 31
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 32
# e: $I1
    null $I1
.annotate 'line', 33
# pirop stat
    stat $I1, $S1, 0
.annotate 'line', 34
    not $I2, $I1
    if $I2 goto __label_5
    $I2 = $P2($S2, $S1)
  __label_5:
    unless $I2 goto __label_4
.const 'Sub' $P4 = 'WSubId_1'
.annotate 'line', 35
    $P4($S2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 37

.end # build_winxed


.sub 'build_winxed_const_includes'
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 41
# var winxed_files: $P1
    $P1 = __ARG_1["pasm_winxed"]
.annotate 'line', 42
    unless_null $P1, __label_1
.annotate 'line', 43
    .return()
  __label_1: # endif
.annotate 'line', 44
    get_hll_global $P2, 'newer'
.annotate 'line', 45
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
# {
.annotate 'line', 46
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 47
# e: $I1
    null $I1
.annotate 'line', 48
# pirop stat
    stat $I1, $S1, 0
.annotate 'line', 49
    not $I2, $I1
    if $I2 goto __label_5
    $I2 = $P2($S2, $S1)
  __label_5:
    unless $I2 goto __label_4
.const 'Sub' $P4 = 'WSubId_2'
.annotate 'line', 50
    $P4($S2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 52

.end # build_winxed_const_includes


.sub 'clean_winxed'
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 57
# var winxed_files: $P1
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 58
    unless_null $P1, __label_1
.annotate 'line', 59
    .return()
  __label_1: # endif
.annotate 'line', 60
# num_files: $I1
# predefined elements
    elements $I1, $P1
.annotate 'line', 61
    get_hll_global $P2, 'unlink'
.annotate 'line', 62
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
# {
.annotate 'line', 63
# e: $I2
    null $I2
.annotate 'line', 64
# pirop stat
    stat $I2, $S1, 0
.annotate 'line', 65
    unless $I2 goto __label_4
# {
.annotate 'line', 66
    concat $S2, "unlink ", $S1
# predefined say
    say $S2
.annotate 'line', 67
    $P2($S1)
# }
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 70

.end # clean_winxed


.sub 'clean_winxed_const_includes'
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 74
# var winxed_files: $P1
    $P1 = __ARG_1["pasm_winxed"]
.annotate 'line', 75
    unless_null $P1, __label_1
.annotate 'line', 76
    .return()
  __label_1: # endif
.annotate 'line', 77
# num_files: $I1
# predefined elements
    elements $I1, $P1
.annotate 'line', 78
    get_hll_global $P2, 'unlink'
.annotate 'line', 79
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
# {
.annotate 'line', 80
# e: $I2
    null $I2
.annotate 'line', 81
# pirop stat
    stat $I2, $S1, 0
.annotate 'line', 82
    unless $I2 goto __label_4
# {
.annotate 'line', 83
    concat $S2, "unlink ", $S1
# predefined say
    say $S2
.annotate 'line', 84
    $P2($S1)
# }
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 87

.end # clean_winxed_const_includes


.sub 'get_pir_file_name'
        .param string __ARG_1
# Body
# {
.annotate 'line', 92
# index: $I1
    null $I1
.annotate 'line', 93
# pirop index
    index $I1, __ARG_1, ".winxed"
.annotate 'line', 94
    ne $I1, -1, __label_1
.annotate 'line', 95
    concat $S2, __ARG_1, " is not a winxed file"
# predefined die
    die $S2
  __label_1: # endif
.annotate 'line', 96
# pir_file: $S1
    null $S1
.annotate 'line', 97
# pirop substr
    substr $S1, __ARG_1, 0, $I1
.annotate 'line', 98
    concat $S2, $S1, ".pir"
    .return($S2)
# }
.annotate 'line', 99

.end # get_pir_file_name


.sub 'compile_to_pir' :subid('WSubId_1')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 104
# cmd: $S1
    concat $S1, "winxed --nowarn -o ", __ARG_2
    concat $S1, $S1, " -c "
    concat $S1, $S1, __ARG_1
.annotate 'line', 105
# result: $I1
    null $I1
.annotate 'line', 106
# predefined say
    say $S1
.annotate 'line', 107
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 108
    eq $I1, 0, __label_1
.annotate 'line', 109
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_1: # endif
# }
.annotate 'line', 110

.end # compile_to_pir


.sub 'compile_to_pasm_include' :subid('WSubId_2')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 114
# cmd: $S1
.annotate 'line', 115
    root_new $P1, ['parrot';'ResizablePMCArray']
    box $P2, __ARG_2
    push $P1, $P2
    box $P2, __ARG_1
    push $P1, $P2
# predefined sprintf
.annotate 'line', 114
    sprintf $S1, "winxed --nowarn -o %s --target=include %s", $P1
.annotate 'line', 117
# result: $I1
    null $I1
.annotate 'line', 118
# predefined say
    say $S1
.annotate 'line', 119
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 120
    eq $I1, 0, __label_1
.annotate 'line', 121
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_1: # endif
# }
.annotate 'line', 122

.end # compile_to_pasm_include

# End generated code
