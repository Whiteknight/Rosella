# THIS IS A GENERATED FILE! DO NOT EDIT!
# Begin generated code

.loadlib "io_ops"
# end libs
.namespace [ 'Rosella'; 'Winxed'; 'Distutils' ]

.sub 'winxed_setup' :subid('WSubId_1')
# Body
# {
# predefined load_bytecode
.annotate 'file', 'Distutils.winxed'
.annotate 'line', 16
    load_bytecode "distutils.pbc"
.annotate 'line', 17
    get_hll_global $P1, 'register_step_before'
.annotate 'line', 19
.const 'Sub' WSubId_5 = 'WSubId_5'
    $P1("build", WSubId_5)
.annotate 'line', 20
.const 'Sub' WSubId_6 = 'WSubId_6'
    $P1("build", WSubId_6)
.annotate 'line', 21
.const 'Sub' WSubId_7 = 'WSubId_7'
    $P1("build", WSubId_7)
.annotate 'line', 23
.const 'Sub' $P3 = 'WSubId_2'
    newclosure $P2, $P3
    $P1("clean", $P2)
.annotate 'line', 26
.const 'Sub' $P3 = 'WSubId_3'
    newclosure $P2, $P3
    $P1("clean", $P2)
.annotate 'line', 29
.const 'Sub' $P3 = 'WSubId_4'
    newclosure $P2, $P3
    $P1("clean", $P2)
# }
.annotate 'line', 32

.end # winxed_setup


.sub '' :anon :subid('WSubId_2') :outer('WSubId_1')
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 24
.const 'Sub' WSubId_8 = 'WSubId_8'
    $P1 = __ARG_1["winxed_winxed"]
    WSubId_8($P1)
# }
.annotate 'line', 25

.end # WSubId_2


.sub '' :anon :subid('WSubId_3') :outer('WSubId_1')
        .param pmc __ARG_2 :named :slurpy
# Body
# {
.annotate 'line', 27
.const 'Sub' WSubId_8 = 'WSubId_8'
    $P1 = __ARG_2["pir_winxed"]
    WSubId_8($P1)
# }
.annotate 'line', 28

.end # WSubId_3


.sub '' :anon :subid('WSubId_4') :outer('WSubId_1')
        .param pmc __ARG_3 :named :slurpy
# Body
# {
.annotate 'line', 30
.const 'Sub' WSubId_8 = 'WSubId_8'
    $P1 = __ARG_3["include_winxed"]
    WSubId_8($P1)
# }
.annotate 'line', 31

.end # WSubId_4


.sub 'make_path_for' :subid('WSubId_15')
        .param string __ARG_1
# Body
# {
.annotate 'line', 38
    get_hll_global $P1, 'dirname'
.annotate 'line', 39
    get_hll_global $P2, 'mkdir'
.annotate 'line', 40
    $P3 = $P1(__ARG_1)
    'mkpath'($P3, 1 :named("verbose"))
# }
.annotate 'line', 41

.end # make_path_for


.sub 'build_winxed_files' :subid('WSubId_5')
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 51
# var winxed_files: $P1
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 52
    unless_null $P1, __label_1
.annotate 'line', 53
    .return()
  __label_1: # endif
.const 'Sub' WSubId_9 = "WSubId_9"
.annotate 'line', 55
    iter $P2, $P1
    set $P2, 0
  __label_2: # for iteration
    unless $P2 goto __label_3
    shift $S1, $P2
# {
.annotate 'line', 56
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 57
.const 'Sub' WSubId_9 = 'WSubId_9'
    $P3 = WSubId_9($S2, $S1)
    if_null $P3, __label_4
    unless $P3 goto __label_4
.annotate 'line', 58
.const 'Sub' WSubId_10 = 'WSubId_10'
    WSubId_10($S2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 60

.end # build_winxed_files


.sub 'build_winxed_const_includes' :subid('WSubId_6')
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 66
# var winxed_files: $P1
    $P1 = __ARG_1["include_winxed"]
.annotate 'line', 67
    unless_null $P1, __label_1
.annotate 'line', 68
    .return()
  __label_1: # endif
.const 'Sub' WSubId_9 = "WSubId_9"
.annotate 'line', 70
    iter $P2, $P1
    set $P2, 0
  __label_2: # for iteration
    unless $P2 goto __label_3
    shift $S1, $P2
# {
.annotate 'line', 71
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 72
.const 'Sub' WSubId_9 = 'WSubId_9'
    $P3 = WSubId_9($S2, $S1)
    if_null $P3, __label_4
    unless $P3 goto __label_4
.annotate 'line', 73
.const 'Sub' WSubId_11 = 'WSubId_11'
    WSubId_11($S2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 75

.end # build_winxed_const_includes


.sub 'build_concat_winxed_files' :subid('WSubId_7')
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 81
# var dest_files: $P1
    $P1 = __ARG_1["winxed_winxed"]
.annotate 'line', 82
    unless_null $P1, __label_1
.annotate 'line', 83
    .return()
  __label_1: # endif
.const 'Sub' WSubId_12 = "WSubId_12"
.annotate 'line', 86
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
# {
.annotate 'line', 87
# var source_files: $P2
    $P2 = $P1[$S1]
.annotate 'line', 88
.const 'Sub' WSubId_12 = 'WSubId_12'
    $P4 = WSubId_12($P2, $S1)
    if_null $P4, __label_4
    unless $P4 goto __label_4
.annotate 'line', 89
.const 'Sub' WSubId_13 = 'WSubId_13'
    WSubId_13($P2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 91

.end # build_concat_winxed_files


.sub 'delete_files' :subid('WSubId_8')
        .param pmc __ARG_1
# Body
# {
.annotate 'line', 96
    unless_null __ARG_1, __label_1
.annotate 'line', 97
    .return()
  __label_1: # endif
.annotate 'line', 99
    iter $P1, __ARG_1
    set $P1, 0
  __label_2: # for iteration
    unless $P1 goto __label_3
    shift $S1, $P1
.annotate 'line', 100
.const 'Sub' WSubId_14 = 'WSubId_14'
    WSubId_14($S1)
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 101

.end # delete_files


.sub 'get_pir_file_name'
        .param string __ARG_1
# Body
# {
.annotate 'line', 111
# index: $I1
    null $I1
.annotate 'line', 112
# pirop index
    index $I1, __ARG_1, ".winxed"
.annotate 'line', 113
    ne $I1, -1, __label_1
.annotate 'line', 114
    concat $S2, __ARG_1, " is not a winxed file"
# predefined die
    die $S2
  __label_1: # endif
.annotate 'line', 115
# pir_file: $S1
    null $S1
.annotate 'line', 116
# pirop substr
    substr $S1, __ARG_1, 0, $I1
.annotate 'line', 117
    concat $S2, $S1, ".pir"
    .return($S2)
# }
.annotate 'line', 118

.end # get_pir_file_name


.sub 'compile_to_pir' :subid('WSubId_10')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 123
.const 'Sub' WSubId_15 = 'WSubId_15'
    WSubId_15(__ARG_2)
.annotate 'line', 124
# cmd: $S1
    concat $S1, "winxed --nowarn -o ", __ARG_2
    concat $S1, $S1, " -c "
    concat $S1, $S1, __ARG_1
.annotate 'line', 125
# result: $I1
    null $I1
.annotate 'line', 126
# predefined say
    say $S1
.annotate 'line', 127
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 128
    eq $I1, 0, __label_1
.annotate 'line', 129
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_1: # endif
# }
.annotate 'line', 130

.end # compile_to_pir


.sub 'compile_to_pasm_include' :subid('WSubId_11')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 135
.const 'Sub' WSubId_15 = 'WSubId_15'
    WSubId_15(__ARG_2)
.annotate 'line', 136
# cmd: $S1
.annotate 'line', 137
    root_new $P1, ['parrot';'ResizablePMCArray']
    box $P2, __ARG_2
    push $P1, $P2
    box $P2, __ARG_1
    push $P1, $P2
# predefined sprintf
.annotate 'line', 136
    sprintf $S1, "winxed --nowarn -o %s --target=include %s", $P1
.annotate 'line', 139
# result: $I1
    null $I1
.annotate 'line', 140
# predefined say
    say $S1
.annotate 'line', 141
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 142
    eq $I1, 0, __label_1
.annotate 'line', 143
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_1: # endif
# }
.annotate 'line', 144

.end # compile_to_pasm_include


.sub 'delete_file' :subid('WSubId_14')
        .param string __ARG_1
# Body
# {
.annotate 'line', 149
    get_hll_global $P1, 'unlink'
.annotate 'line', 150
# e: $I1
    null $I1
.annotate 'line', 151
# pirop stat
    stat $I1, __ARG_1, 0
.annotate 'line', 152
    unless $I1 goto __label_1
# {
.annotate 'line', 153
    concat $S1, "unlink ", __ARG_1
# predefined say
    say $S1
.annotate 'line', 154
    $P1(__ARG_1)
# }
  __label_1: # endif
# }
.annotate 'line', 156

.end # delete_file


.sub 'needs_updating_all' :subid('WSubId_12')
        .param pmc __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 162
    unless_null __ARG_1, __label_1
.annotate 'line', 163
    .return(0)
  __label_1: # endif
.annotate 'line', 165
    get_hll_global $P1, 'newer'
.annotate 'line', 166
# e: $I1
    null $I1
.annotate 'line', 167
# pirop stat
    stat $I1, __ARG_2, 0
.annotate 'line', 168
    not $I2, $I1
    unless $I2 goto __label_2
.annotate 'line', 169
    .return(1)
  __label_2: # endif
.annotate 'line', 171
    iter $P2, __ARG_1
    set $P2, 0
  __label_3: # for iteration
    unless $P2 goto __label_4
    shift $S1, $P2
# {
.annotate 'line', 172
    $P3 = $P1($S1, __ARG_2)
    if_null $P3, __label_5
    unless $P3 goto __label_5
.annotate 'line', 173
    .return(1)
  __label_5: # endif
# }
    goto __label_3
  __label_4: # endfor
.annotate 'line', 175
    .return(0)
# }
.annotate 'line', 176

.end # needs_updating_all


.sub 'needs_updating' :subid('WSubId_9')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 182
    get_hll_global $P1, 'newer'
.annotate 'line', 183
# e: $I1
    null $I1
.annotate 'line', 184
# pirop stat
    stat $I1, __ARG_2, 0
.annotate 'line', 185
    not $I2, $I1
    if $I2 goto __label_2
    $I2 = $P1(__ARG_1, __ARG_2)
  __label_2:
    unless $I2 goto __label_1
.annotate 'line', 186
    .return(1)
  __label_1: # endif
.annotate 'line', 187
    .return(0)
# }
.annotate 'line', 188

.end # needs_updating


.sub 'concat_files' :subid('WSubId_13')
        .param pmc __ARG_1
        .param pmc __ARG_2
# Body
# {
.annotate 'line', 193
.const 'Sub' WSubId_15 = 'WSubId_15'
    WSubId_15(__ARG_2)
.annotate 'line', 194
.const 'Sub' WSubId_14 = 'WSubId_14'
    WSubId_14(__ARG_2)
.annotate 'line', 195
    root_new $P3, ['parrot';'ResizablePMCArray']
    push $P3, __ARG_2
# predefined join
    join $S4, ", ", __ARG_1
    box $P4, $S4
    push $P3, $P4
# predefined sprintf
    sprintf $S3, "concat %s = %s", $P3
# predefined say
    say $S3
.annotate 'line', 196
# var dest_fh: $P1
    new $P1, [ 'FileHandle' ]
.annotate 'line', 197
    $P1.'open'(__ARG_2, "w")
.annotate 'line', 198
    iter $P5, __ARG_1
    set $P5, 0
  __label_1: # for iteration
    unless $P5 goto __label_2
    shift $S1, $P5
# {
.annotate 'line', 199
# var source_fh: $P2
    new $P2, [ 'FileHandle' ]
.annotate 'line', 200
    $P2.'open'($S1, "r")
.annotate 'line', 201
# contents: $S2
    $P3 = $P2.'readall'()
    null $S2
    if_null $P3, __label_3
    set $S2, $P3
  __label_3:
.annotate 'line', 202
    $P2.'close'()
.annotate 'line', 203
    $P1.'print'($S2)
.annotate 'line', 204
    $P1.'print'("\n")
# }
    goto __label_1
  __label_2: # endfor
.annotate 'line', 206
    $P1.'close'()
# }
.annotate 'line', 207

.end # concat_files

# End generated code
