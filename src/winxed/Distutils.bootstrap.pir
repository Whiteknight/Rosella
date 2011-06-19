# THIS IS A GENERATED FILE! DO NOT EDIT!
# Begin generated code

.loadlib "io_ops"
# end libs
.namespace [ 'Rosella'; 'Winxed'; 'Distutils' ]

.sub 'winxed_setup' :subid('WSubId_1')
# Body
# {
# predefined load_bytecode
.annotate 'file', 'src/winxed/Distutils.winxed'
.annotate 'line', 14
    load_bytecode "distutils.pbc"
.annotate 'line', 15
    get_hll_global $P1, 'register_step_before'
.annotate 'line', 17
.const 'Sub' WSubId_5 = 'WSubId_5'
    $P1("build", WSubId_5)
.annotate 'line', 18
.const 'Sub' WSubId_6 = 'WSubId_6'
    $P1("build", WSubId_6)
.annotate 'line', 19
.const 'Sub' WSubId_7 = 'WSubId_7'
    $P1("build", WSubId_7)
.annotate 'line', 21
.const 'Sub' $P3 = 'WSubId_2'
    newclosure $P2, $P3
    $P1("clean", $P2)
.annotate 'line', 24
.const 'Sub' $P3 = 'WSubId_3'
    newclosure $P2, $P3
    $P1("clean", $P2)
.annotate 'line', 27
.const 'Sub' $P3 = 'WSubId_4'
    newclosure $P2, $P3
    $P1("clean", $P2)
# }
.annotate 'line', 30

.end # winxed_setup


.sub '' :anon :subid('WSubId_2') :outer('WSubId_1')
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 22
.const 'Sub' WSubId_8 = 'WSubId_8'
    $P1 = __ARG_1["winxed_winxed"]
    WSubId_8($P1)
# }
.annotate 'line', 23

.end # WSubId_2


.sub '' :anon :subid('WSubId_3') :outer('WSubId_1')
        .param pmc __ARG_2 :named :slurpy
# Body
# {
.annotate 'line', 25
.const 'Sub' WSubId_8 = 'WSubId_8'
    $P1 = __ARG_2["pir_winxed"]
    WSubId_8($P1)
# }
.annotate 'line', 26

.end # WSubId_3


.sub '' :anon :subid('WSubId_4') :outer('WSubId_1')
        .param pmc __ARG_3 :named :slurpy
# Body
# {
.annotate 'line', 28
.const 'Sub' WSubId_8 = 'WSubId_8'
    $P1 = __ARG_3["include_winxed"]
    WSubId_8($P1)
# }
.annotate 'line', 29

.end # WSubId_4


.sub 'build_winxed_files' :subid('WSubId_5')
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 40
# var winxed_files: $P1
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 41
    unless_null $P1, __label_1
.annotate 'line', 42
    .return()
  __label_1: # endif
.const 'Sub' WSubId_9 = "WSubId_9"
.annotate 'line', 44
    iter $P2, $P1
    set $P2, 0
  __label_2: # for iteration
    unless $P2 goto __label_3
    shift $S1, $P2
# {
.annotate 'line', 45
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 46
.const 'Sub' WSubId_9 = 'WSubId_9'
    $P3 = WSubId_9($S2, $S1)
    if_null $P3, __label_4
    unless $P3 goto __label_4
.annotate 'line', 47
.const 'Sub' WSubId_10 = 'WSubId_10'
    WSubId_10($S2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 49

.end # build_winxed_files


.sub 'build_winxed_const_includes' :subid('WSubId_6')
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 55
# var winxed_files: $P1
    $P1 = __ARG_1["include_winxed"]
.annotate 'line', 56
    unless_null $P1, __label_1
.annotate 'line', 57
    .return()
  __label_1: # endif
.const 'Sub' WSubId_9 = "WSubId_9"
.annotate 'line', 59
    iter $P2, $P1
    set $P2, 0
  __label_2: # for iteration
    unless $P2 goto __label_3
    shift $S1, $P2
# {
.annotate 'line', 60
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 61
.const 'Sub' WSubId_9 = 'WSubId_9'
    $P3 = WSubId_9($S2, $S1)
    if_null $P3, __label_4
    unless $P3 goto __label_4
.annotate 'line', 62
.const 'Sub' WSubId_11 = 'WSubId_11'
    WSubId_11($S2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 64

.end # build_winxed_const_includes


.sub 'build_concat_winxed_files' :subid('WSubId_7')
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 70
# var dest_files: $P1
    $P1 = __ARG_1["winxed_winxed"]
.annotate 'line', 71
    unless_null $P1, __label_1
.annotate 'line', 72
    .return()
  __label_1: # endif
.const 'Sub' WSubId_12 = "WSubId_12"
.annotate 'line', 75
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
# {
.annotate 'line', 76
# var source_files: $P2
    $P2 = $P1[$S1]
.annotate 'line', 77
.const 'Sub' WSubId_12 = 'WSubId_12'
    $P4 = WSubId_12($P2, $S1)
    if_null $P4, __label_4
    unless $P4 goto __label_4
.annotate 'line', 78
.const 'Sub' WSubId_13 = 'WSubId_13'
    WSubId_13($P2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 80

.end # build_concat_winxed_files


.sub 'get_pir_file_name'
        .param string __ARG_1
# Body
# {
.annotate 'line', 90
# index: $I1
    null $I1
.annotate 'line', 91
# pirop index
    index $I1, __ARG_1, ".winxed"
.annotate 'line', 92
    ne $I1, -1, __label_1
.annotate 'line', 93
    concat $S2, __ARG_1, " is not a winxed file"
# predefined die
    die $S2
  __label_1: # endif
.annotate 'line', 94
# pir_file: $S1
    null $S1
.annotate 'line', 95
# pirop substr
    substr $S1, __ARG_1, 0, $I1
.annotate 'line', 96
    concat $S2, $S1, ".pir"
    .return($S2)
# }
.annotate 'line', 97

.end # get_pir_file_name


.sub 'compile_to_pir' :subid('WSubId_10')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 102
    get_hll_global $P1, 'dirname'
.annotate 'line', 103
    get_hll_global $P2, 'mkdir'
.annotate 'line', 104
    $P3 = $P1(__ARG_2)
    'mkpath'($P3, 1 :named("verbose"))
.annotate 'line', 105
# cmd: $S1
    concat $S1, "winxed --nowarn -o ", __ARG_2
    concat $S1, $S1, " -c "
    concat $S1, $S1, __ARG_1
.annotate 'line', 106
# result: $I1
    null $I1
.annotate 'line', 107
# predefined say
    say $S1
.annotate 'line', 108
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 109
    eq $I1, 0, __label_1
.annotate 'line', 110
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_1: # endif
# }
.annotate 'line', 111

.end # compile_to_pir


.sub 'compile_to_pasm_include' :subid('WSubId_11')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 116
    get_hll_global $P1, 'dirname'
.annotate 'line', 117
    get_hll_global $P2, 'mkdir'
.annotate 'line', 118
    $P3 = $P1(__ARG_2)
    'mkpath'($P3, 1 :named("verbose"))
.annotate 'line', 119
# cmd: $S1
.annotate 'line', 120
    root_new $P3, ['parrot';'ResizablePMCArray']
    box $P4, __ARG_2
    push $P3, $P4
    box $P4, __ARG_1
    push $P3, $P4
# predefined sprintf
.annotate 'line', 119
    sprintf $S1, "winxed --nowarn -o %s --target=include %s", $P3
.annotate 'line', 122
# result: $I1
    null $I1
.annotate 'line', 123
# predefined say
    say $S1
.annotate 'line', 124
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 125
    eq $I1, 0, __label_1
.annotate 'line', 126
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_1: # endif
# }
.annotate 'line', 127

.end # compile_to_pasm_include


.sub 'delete_files' :subid('WSubId_8')
        .param pmc __ARG_1
# Body
# {
.annotate 'line', 131
    unless_null __ARG_1, __label_1
.annotate 'line', 132
    .return()
  __label_1: # endif
.annotate 'line', 134
    iter $P1, __ARG_1
    set $P1, 0
  __label_2: # for iteration
    unless $P1 goto __label_3
    shift $S1, $P1
.annotate 'line', 135
.const 'Sub' WSubId_14 = 'WSubId_14'
    WSubId_14($S1)
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 136

.end # delete_files


.sub 'delete_file' :subid('WSubId_14')
        .param string __ARG_1
# Body
# {
.annotate 'line', 140
    get_hll_global $P1, 'unlink'
.annotate 'line', 141
# e: $I1
    null $I1
.annotate 'line', 142
# pirop stat
    stat $I1, __ARG_1, 0
.annotate 'line', 143
    unless $I1 goto __label_1
# {
.annotate 'line', 144
    concat $S1, "unlink ", __ARG_1
# predefined say
    say $S1
.annotate 'line', 145
    $P1(__ARG_1)
# }
  __label_1: # endif
# }
.annotate 'line', 147

.end # delete_file


.sub 'needs_updating_all' :subid('WSubId_12')
        .param pmc __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 153
    unless_null __ARG_1, __label_1
.annotate 'line', 154
    .return(0)
  __label_1: # endif
.annotate 'line', 156
    get_hll_global $P1, 'newer'
.annotate 'line', 157
# e: $I1
    null $I1
.annotate 'line', 158
# pirop stat
    stat $I1, __ARG_2, 0
.annotate 'line', 159
    not $I2, $I1
    unless $I2 goto __label_2
.annotate 'line', 160
    .return(1)
  __label_2: # endif
.annotate 'line', 162
    iter $P2, __ARG_1
    set $P2, 0
  __label_3: # for iteration
    unless $P2 goto __label_4
    shift $S1, $P2
# {
.annotate 'line', 163
    $P3 = $P1($S1, __ARG_2)
    if_null $P3, __label_5
    unless $P3 goto __label_5
.annotate 'line', 164
    .return(1)
  __label_5: # endif
# }
    goto __label_3
  __label_4: # endfor
.annotate 'line', 166
    .return(0)
# }
.annotate 'line', 167

.end # needs_updating_all


.sub 'needs_updating' :subid('WSubId_9')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 173
    get_hll_global $P1, 'newer'
.annotate 'line', 174
# e: $I1
    null $I1
.annotate 'line', 175
# pirop stat
    stat $I1, __ARG_2, 0
.annotate 'line', 176
    not $I2, $I1
    if $I2 goto __label_2
    $I2 = $P1(__ARG_1, __ARG_2)
  __label_2:
    unless $I2 goto __label_1
.annotate 'line', 177
    .return(1)
  __label_1: # endif
.annotate 'line', 178
    .return(0)
# }
.annotate 'line', 179

.end # needs_updating


.sub 'concat_files' :subid('WSubId_13')
        .param pmc __ARG_1
        .param pmc __ARG_2
# Body
# {
.annotate 'line', 183
    get_hll_global $P3, 'dirname'
.annotate 'line', 184
    get_hll_global $P4, 'mkdir'
.annotate 'line', 185
    $P5 = $P3(__ARG_2)
    'mkpath'($P5, 1 :named("verbose"))
.annotate 'line', 186
.const 'Sub' WSubId_14 = 'WSubId_14'
    WSubId_14(__ARG_2)
.annotate 'line', 187
    root_new $P5, ['parrot';'ResizablePMCArray']
    push $P5, __ARG_2
# predefined join
    join $S4, ", ", __ARG_1
    box $P6, $S4
    push $P5, $P6
# predefined sprintf
    sprintf $S3, "concat %s = %s", $P5
# predefined say
    say $S3
.annotate 'line', 188
# var dest_fh: $P1
    new $P1, [ 'FileHandle' ]
.annotate 'line', 189
    $P1.'open'(__ARG_2, "w")
.annotate 'line', 190
    iter $P7, __ARG_1
    set $P7, 0
  __label_1: # for iteration
    unless $P7 goto __label_2
    shift $S1, $P7
# {
.annotate 'line', 191
# var source_fh: $P2
    new $P2, [ 'FileHandle' ]
.annotate 'line', 192
    $P2.'open'($S1, "r")
.annotate 'line', 193
# contents: $S2
    $P5 = $P2.'readall'()
    null $S2
    if_null $P5, __label_3
    set $S2, $P5
  __label_3:
.annotate 'line', 194
    $P2.'close'()
.annotate 'line', 195
    $P1.'print'($S2)
.annotate 'line', 196
    $P1.'print'("\n")
# }
    goto __label_1
  __label_2: # endfor
.annotate 'line', 198
    $P1.'close'()
# }
.annotate 'line', 199

.end # concat_files

# End generated code
