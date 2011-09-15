# THIS IS A GENERATED FILE! DO NOT EDIT!
# Begin generated code

.loadlib "io_ops"
# end libs
.namespace [ 'Rosella'; 'Winxed'; 'Distutils' ]

.sub 'winxed_setup' :subid('WSubId_1')
.const 'Sub' WSubId_5 = "WSubId_5"
.const 'Sub' WSubId_6 = "WSubId_6"
.const 'Sub' WSubId_7 = "WSubId_7"
.const 'Sub' WSubId_2 = "WSubId_2"
.const 'Sub' WSubId_3 = "WSubId_3"
.const 'Sub' WSubId_4 = "WSubId_4"
# Body
# {
# predefined load_bytecode
.annotate 'file', 'Distutils.winxed'
.annotate 'line', 16
    load_bytecode "distutils.pbc"
.annotate 'line', 17
    get_hll_global $P1, 'register_step_before'
.annotate 'line', 19
    $P1("build", WSubId_5)
.annotate 'line', 20
    $P1("build", WSubId_6)
.annotate 'line', 21
    $P1("build", WSubId_7)
.annotate 'line', 23
    set $P2, WSubId_2
    $P1("clean", $P2)
.annotate 'line', 26
    set $P2, WSubId_3
    $P1("clean", $P2)
.annotate 'line', 29
    set $P2, WSubId_4
    $P1("clean", $P2)
# }
.annotate 'line', 32

.end # winxed_setup


.sub '' :anon :subid('WSubId_2') :outer('WSubId_1')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_8 = "WSubId_8"
# Body
# {
.annotate 'line', 24
    $P1 = __ARG_1["winxed_winxed"]
    WSubId_8($P1)
# }
.annotate 'line', 25

.end # WSubId_2


.sub '' :anon :subid('WSubId_3') :outer('WSubId_1')
        .param pmc __ARG_2 :named :slurpy
.const 'Sub' WSubId_8 = "WSubId_8"
# Body
# {
.annotate 'line', 27
    $P1 = __ARG_2["pir_winxed"]
    WSubId_8($P1)
# }
.annotate 'line', 28

.end # WSubId_3


.sub '' :anon :subid('WSubId_4') :outer('WSubId_1')
        .param pmc __ARG_3 :named :slurpy
.const 'Sub' WSubId_8 = "WSubId_8"
# Body
# {
.annotate 'line', 30
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
.const 'Sub' WSubId_9 = "WSubId_9"
.const 'Sub' WSubId_10 = "WSubId_10"
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
.annotate 'line', 54
# var debug: $P2
# predefined var
    $P2 = __ARG_1["winxed_debug"]
.annotate 'line', 55
    unless_null $P2, __label_2
.annotate 'line', 56
    box $P2, 0
  __label_2: # endif
.annotate 'line', 58
    if_null $P1, __label_4
    iter $P3, $P1
    set $P3, 0
  __label_3: # for iteration
    unless $P3 goto __label_4
    shift $S1, $P3
# {
.annotate 'line', 59
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 60
    $P4 = WSubId_9($S2, $S1)
    if_null $P4, __label_5
    unless $P4 goto __label_5
.annotate 'line', 61
# predefined int
    set $I1, $P2
    WSubId_10($S2, $S1, $I1)
  __label_5: # endif
# }
    goto __label_3
  __label_4: # endfor
# }
.annotate 'line', 63

.end # build_winxed_files


.sub 'build_winxed_const_includes' :subid('WSubId_6')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_9 = "WSubId_9"
.const 'Sub' WSubId_11 = "WSubId_11"
# Body
# {
.annotate 'line', 69
# var winxed_files: $P1
    $P1 = __ARG_1["include_winxed"]
.annotate 'line', 70
    unless_null $P1, __label_1
.annotate 'line', 71
    .return()
  __label_1: # endif
.annotate 'line', 73
    if_null $P1, __label_3
    iter $P2, $P1
    set $P2, 0
  __label_2: # for iteration
    unless $P2 goto __label_3
    shift $S1, $P2
# {
.annotate 'line', 74
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 75
    $P3 = WSubId_9($S2, $S1)
    if_null $P3, __label_4
    unless $P3 goto __label_4
.annotate 'line', 76
    WSubId_11($S2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 78

.end # build_winxed_const_includes


.sub 'build_concat_winxed_files' :subid('WSubId_7')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_12 = "WSubId_12"
.const 'Sub' WSubId_13 = "WSubId_13"
# Body
# {
.annotate 'line', 84
# var dest_files: $P1
    $P1 = __ARG_1["winxed_winxed"]
.annotate 'line', 85
    unless_null $P1, __label_1
.annotate 'line', 86
    .return()
  __label_1: # endif
.annotate 'line', 89
    if_null $P1, __label_3
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
# {
.annotate 'line', 90
# var source_files: $P2
    $P2 = $P1[$S1]
.annotate 'line', 91
    $P4 = WSubId_12($P2, $S1)
    if_null $P4, __label_4
    unless $P4 goto __label_4
.annotate 'line', 92
    WSubId_13($P2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 94

.end # build_concat_winxed_files


.sub 'delete_files' :subid('WSubId_8')
        .param pmc __ARG_1
.const 'Sub' WSubId_14 = "WSubId_14"
# Body
# {
.annotate 'line', 99
    unless_null __ARG_1, __label_1
.annotate 'line', 100
    .return()
  __label_1: # endif
.annotate 'line', 102
    if_null __ARG_1, __label_3
    iter $P1, __ARG_1
    set $P1, 0
  __label_2: # for iteration
    unless $P1 goto __label_3
    shift $S1, $P1
.annotate 'line', 103
    WSubId_14($S1)
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 104

.end # delete_files


.sub 'get_pir_file_name'
        .param string __ARG_1
# Body
# {
.annotate 'line', 114
# index: $I1
    null $I1
.annotate 'line', 115
# pirop index
    index $I1, __ARG_1, ".winxed"
.annotate 'line', 116
    ne $I1, -1, __label_1
.annotate 'line', 117
    concat $S2, __ARG_1, " is not a winxed file"
# predefined die
    die $S2
  __label_1: # endif
.annotate 'line', 118
# pir_file: $S1
    null $S1
.annotate 'line', 119
# pirop substr
    substr $S1, __ARG_1, 0, $I1
.annotate 'line', 120
    concat $S2, $S1, ".pir"
    .return($S2)
# }
.annotate 'line', 121

.end # get_pir_file_name


.sub 'compile_to_pir' :subid('WSubId_10')
        .param string __ARG_1
        .param string __ARG_2
        .param int __ARG_3
.const 'Sub' WSubId_15 = "WSubId_15"
# Body
# {
.annotate 'line', 126
    WSubId_15(__ARG_2)
.annotate 'line', 127
# cmd: $S1
    root_new $P1, ['parrot';'ResizablePMCArray']
    assign $P1, 3
    if __ARG_3, __label_2
    set $S2, ""
    goto __label_1
  __label_2:
    set $S2, "--debug"
  __label_1:
    $P1[0] = $S2
    $P1[1] = __ARG_2
    $P1[2] = __ARG_1
# predefined sprintf
    sprintf $S1, "winxed %s -o %s -c %s", $P1
.annotate 'line', 128
# result: $I1
    null $I1
.annotate 'line', 129
# predefined say
    say $S1
.annotate 'line', 130
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 131
    unless $I1, __label_3
.annotate 'line', 132
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_3: # endif
# }
.annotate 'line', 133

.end # compile_to_pir


.sub 'compile_to_pasm_include' :subid('WSubId_11')
        .param string __ARG_1
        .param string __ARG_2
.const 'Sub' WSubId_15 = "WSubId_15"
# Body
# {
.annotate 'line', 138
    WSubId_15(__ARG_2)
.annotate 'line', 139
# cmd: $S1
.annotate 'line', 140
    root_new $P1, ['parrot';'ResizablePMCArray']
    assign $P1, 2
    $P1[0] = __ARG_2
    $P1[1] = __ARG_1
# predefined sprintf
.annotate 'line', 139
    sprintf $S1, "winxed --nowarn -o %s --target=include %s", $P1
.annotate 'line', 142
# result: $I1
    null $I1
.annotate 'line', 143
# predefined say
    say $S1
.annotate 'line', 144
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 145
    unless $I1, __label_1
.annotate 'line', 146
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_1: # endif
# }
.annotate 'line', 147

.end # compile_to_pasm_include


.sub 'delete_file' :subid('WSubId_14')
        .param string __ARG_1
# Body
# {
.annotate 'line', 152
    get_hll_global $P1, 'unlink'
.annotate 'line', 153
# e: $I1
    null $I1
.annotate 'line', 154
# pirop stat
    stat $I1, __ARG_1, 0
.annotate 'line', 155
    unless $I1 goto __label_1
# {
.annotate 'line', 156
    concat $S1, "unlink ", __ARG_1
# predefined say
    say $S1
.annotate 'line', 157
    $P1(__ARG_1)
# }
  __label_1: # endif
# }
.annotate 'line', 159

.end # delete_file


.sub 'needs_updating_all' :subid('WSubId_12')
        .param pmc __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 165
    unless_null __ARG_1, __label_1
.annotate 'line', 166
    .return(0)
  __label_1: # endif
.annotate 'line', 168
    get_hll_global $P1, 'newer'
.annotate 'line', 169
# e: $I1
    null $I1
.annotate 'line', 170
# pirop stat
    stat $I1, __ARG_2, 0
.annotate 'line', 171
    not $I2, $I1
    unless $I2 goto __label_2
.annotate 'line', 172
    .return(1)
  __label_2: # endif
.annotate 'line', 174
    if_null __ARG_1, __label_4
    iter $P2, __ARG_1
    set $P2, 0
  __label_3: # for iteration
    unless $P2 goto __label_4
    shift $S1, $P2
# {
.annotate 'line', 175
    $P3 = $P1($S1, __ARG_2)
    if_null $P3, __label_5
    unless $P3 goto __label_5
.annotate 'line', 176
    .return(1)
  __label_5: # endif
# }
    goto __label_3
  __label_4: # endfor
.annotate 'line', 178
    .return(0)
# }
.annotate 'line', 179

.end # needs_updating_all


.sub 'needs_updating' :subid('WSubId_9')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 185
    get_hll_global $P1, 'newer'
.annotate 'line', 186
# e: $I1
    null $I1
.annotate 'line', 187
# pirop stat
    stat $I1, __ARG_2, 0
.annotate 'line', 188
    not $I2, $I1
    if $I2 goto __label_2
    $I2 = $P1(__ARG_1, __ARG_2)
  __label_2:
    unless $I2 goto __label_1
.annotate 'line', 189
    .return(1)
  __label_1: # endif
.annotate 'line', 190
    .return(0)
# }
.annotate 'line', 191

.end # needs_updating


.sub 'concat_files' :subid('WSubId_13')
        .param pmc __ARG_1
        .param pmc __ARG_2
.const 'Sub' WSubId_15 = "WSubId_15"
.const 'Sub' WSubId_14 = "WSubId_14"
# Body
# {
.annotate 'line', 196
    WSubId_15(__ARG_2)
.annotate 'line', 197
    WSubId_14(__ARG_2)
.annotate 'line', 198
    root_new $P3, ['parrot';'ResizablePMCArray']
    assign $P3, 2
    $P3[0] = __ARG_2
# predefined join
    join $S4, ", ", __ARG_1
    $P3[1] = $S4
# predefined sprintf
    sprintf $S3, "concat %s = %s", $P3
# predefined say
    say $S3
.annotate 'line', 199
# var dest_fh: $P1
    new $P1, [ 'FileHandle' ]
.annotate 'line', 200
    $P1.'open'(__ARG_2, "w")
.annotate 'line', 201
    if_null __ARG_1, __label_2
    iter $P4, __ARG_1
    set $P4, 0
  __label_1: # for iteration
    unless $P4 goto __label_2
    shift $S1, $P4
# {
.annotate 'line', 202
# var source_fh: $P2
    new $P2, [ 'FileHandle' ]
.annotate 'line', 203
    $P2.'open'($S1, "r")
.annotate 'line', 204
# contents: $S2
    $P3 = $P2.'readall'()
    null $S2
    if_null $P3, __label_3
    set $S2, $P3
  __label_3:
.annotate 'line', 205
    $P2.'close'()
.annotate 'line', 206
    $P1.'print'($S2)
.annotate 'line', 207
    $P1.'print'("\n")
# }
    goto __label_1
  __label_2: # endfor
.annotate 'line', 209
    $P1.'close'()
# }
.annotate 'line', 210

.end # concat_files

# End generated code
