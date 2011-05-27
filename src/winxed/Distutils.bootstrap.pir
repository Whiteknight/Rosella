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
.const 'Sub' $P2 = 'build_winxed_files'
.annotate 'line', 18
.const 'Sub' $P3 = 'build_winxed_const_includes'
.annotate 'line', 19
.const 'Sub' $P4 = 'build_concat_winxed_files'
.annotate 'line', 21
    $P1("build", $P2)
.annotate 'line', 22
    $P1("build", $P3)
.annotate 'line', 23
    $P1("build", $P4)
.annotate 'line', 25
.const 'Sub' $P6 = 'WSubId_2'
    newclosure $P5, $P6
    $P1("clean", $P5)
.annotate 'line', 28
.const 'Sub' $P6 = 'WSubId_3'
    newclosure $P5, $P6
    $P1("clean", $P5)
.annotate 'line', 31
.const 'Sub' $P6 = 'WSubId_4'
    newclosure $P5, $P6
    $P1("clean", $P5)
# }
.annotate 'line', 34

.end # winxed_setup


.sub '' :anon :subid('WSubId_2') :outer('WSubId_1')
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.const 'Sub' $P1 = 'WSubId_5'
.annotate 'line', 26
    $P2 = __ARG_1["winxed_winxed"]
    $P1($P2)
# }
.annotate 'line', 27

.end # WSubId_2


.sub '' :anon :subid('WSubId_3') :outer('WSubId_1')
        .param pmc __ARG_2 :named :slurpy
# Body
# {
.const 'Sub' $P1 = 'WSubId_5'
.annotate 'line', 29
    $P2 = __ARG_2["pir_winxed"]
    $P1($P2)
# }
.annotate 'line', 30

.end # WSubId_3


.sub '' :anon :subid('WSubId_4') :outer('WSubId_1')
        .param pmc __ARG_3 :named :slurpy
# Body
# {
.const 'Sub' $P1 = 'WSubId_5'
.annotate 'line', 32
    $P2 = __ARG_3["include_winxed"]
    $P1($P2)
# }
.annotate 'line', 33

.end # WSubId_4


.sub 'build_winxed_files'
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 44
# var winxed_files: $P1
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 45
    unless_null $P1, __label_1
.annotate 'line', 46
    .return()
  __label_1: # endif
.const 'Sub' $P2 = "WSubId_6"
.annotate 'line', 48
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
# {
.annotate 'line', 49
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 50
    $P4 = $P2($S2, $S1)
    if_null $P4, __label_4
    unless $P4 goto __label_4
.const 'Sub' $P5 = 'WSubId_7'
.annotate 'line', 51
    $P5($S2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 53

.end # build_winxed_files


.sub 'build_winxed_const_includes'
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 59
# var winxed_files: $P1
    $P1 = __ARG_1["include_winxed"]
.annotate 'line', 60
    unless_null $P1, __label_1
.annotate 'line', 61
    .return()
  __label_1: # endif
.const 'Sub' $P2 = "WSubId_6"
.annotate 'line', 63
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
# {
.annotate 'line', 64
# winxed_file: $S2
    $S2 = $P1[$S1]
.annotate 'line', 65
    $P4 = $P2($S2, $S1)
    if_null $P4, __label_4
    unless $P4 goto __label_4
.const 'Sub' $P5 = 'WSubId_8'
.annotate 'line', 66
    $P5($S2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 68

.end # build_winxed_const_includes


.sub 'build_concat_winxed_files'
        .param pmc __ARG_1 :named :slurpy
# Body
# {
.annotate 'line', 74
# var dest_files: $P1
    $P1 = __ARG_1["winxed_winxed"]
.annotate 'line', 75
    unless_null $P1, __label_1
.annotate 'line', 76
    .return()
  __label_1: # endif
.const 'Sub' $P3 = "WSubId_9"
.annotate 'line', 79
    iter $P4, $P1
    set $P4, 0
  __label_2: # for iteration
    unless $P4 goto __label_3
    shift $S1, $P4
# {
.annotate 'line', 80
# var source_files: $P2
    $P2 = $P1[$S1]
.annotate 'line', 81
    $P5 = $P3($P2, $S1)
    if_null $P5, __label_4
    unless $P5 goto __label_4
.const 'Sub' $P6 = 'WSubId_10'
.annotate 'line', 82
    $P6($P2, $S1)
  __label_4: # endif
# }
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 84

.end # build_concat_winxed_files


.sub 'get_pir_file_name'
        .param string __ARG_1
# Body
# {
.annotate 'line', 94
# index: $I1
    null $I1
.annotate 'line', 95
# pirop index
    index $I1, __ARG_1, ".winxed"
.annotate 'line', 96
    ne $I1, -1, __label_1
.annotate 'line', 97
    concat $S2, __ARG_1, " is not a winxed file"
# predefined die
    die $S2
  __label_1: # endif
.annotate 'line', 98
# pir_file: $S1
    null $S1
.annotate 'line', 99
# pirop substr
    substr $S1, __ARG_1, 0, $I1
.annotate 'line', 100
    concat $S2, $S1, ".pir"
    .return($S2)
# }
.annotate 'line', 101

.end # get_pir_file_name


.sub 'compile_to_pir' :subid('WSubId_7')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 106
# cmd: $S1
    concat $S1, "winxed --nowarn -o ", __ARG_2
    concat $S1, $S1, " -c "
    concat $S1, $S1, __ARG_1
.annotate 'line', 107
# result: $I1
    null $I1
.annotate 'line', 108
# predefined say
    say $S1
.annotate 'line', 109
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 110
    eq $I1, 0, __label_1
.annotate 'line', 111
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_1: # endif
# }
.annotate 'line', 112

.end # compile_to_pir


.sub 'compile_to_pasm_include' :subid('WSubId_8')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 117
# cmd: $S1
.annotate 'line', 118
    root_new $P1, ['parrot';'ResizablePMCArray']
    box $P2, __ARG_2
    push $P1, $P2
    box $P2, __ARG_1
    push $P1, $P2
# predefined sprintf
.annotate 'line', 117
    sprintf $S1, "winxed --nowarn -o %s --target=include %s", $P1
.annotate 'line', 120
# result: $I1
    null $I1
.annotate 'line', 121
# predefined say
    say $S1
.annotate 'line', 122
# pirop spawnw
    spawnw $I1, $S1
.annotate 'line', 123
    eq $I1, 0, __label_1
.annotate 'line', 124
    set $S3, $I1
    concat $S2, "exit status: ", $S3
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
# predefined die
    die $S4
  __label_1: # endif
# }
.annotate 'line', 125

.end # compile_to_pasm_include


.sub 'delete_files' :subid('WSubId_5')
        .param pmc __ARG_1
# Body
# {
.annotate 'line', 129
    unless_null __ARG_1, __label_1
.annotate 'line', 130
    .return()
  __label_1: # endif
.annotate 'line', 132
.const 'Sub' $P1 = 'delete_file'
.annotate 'line', 133
    iter $P2, __ARG_1
    set $P2, 0
  __label_2: # for iteration
    unless $P2 goto __label_3
    shift $S1, $P2
.const 'Sub' $P3 = 'WSubId_11'
.annotate 'line', 134
    $P3($S1)
    goto __label_2
  __label_3: # endfor
# }
.annotate 'line', 135

.end # delete_files


.sub 'delete_file' :subid('WSubId_11')
        .param string __ARG_1
# Body
# {
.annotate 'line', 139
    get_hll_global $P1, 'unlink'
.annotate 'line', 140
# e: $I1
    null $I1
.annotate 'line', 141
# pirop stat
    stat $I1, __ARG_1, 0
.annotate 'line', 142
    unless $I1 goto __label_1
# {
.annotate 'line', 143
    concat $S1, "unlink ", __ARG_1
# predefined say
    say $S1
.annotate 'line', 144
    $P1(__ARG_1)
# }
  __label_1: # endif
# }
.annotate 'line', 146

.end # delete_file


.sub 'needs_updating_all' :subid('WSubId_9')
        .param pmc __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 152
    unless_null __ARG_1, __label_1
.annotate 'line', 153
    .return(0)
  __label_1: # endif
.annotate 'line', 155
    get_hll_global $P1, 'newer'
.annotate 'line', 156
# e: $I1
    null $I1
.annotate 'line', 157
# pirop stat
    stat $I1, __ARG_2, 0
.annotate 'line', 158
    not $I2, $I1
    unless $I2 goto __label_2
.annotate 'line', 159
    .return(1)
  __label_2: # endif
.annotate 'line', 161
    iter $P2, __ARG_1
    set $P2, 0
  __label_3: # for iteration
    unless $P2 goto __label_4
    shift $S1, $P2
# {
.annotate 'line', 162
    $P3 = $P1($S1, __ARG_2)
    if_null $P3, __label_5
    unless $P3 goto __label_5
.annotate 'line', 163
    .return(1)
  __label_5: # endif
# }
    goto __label_3
  __label_4: # endfor
.annotate 'line', 165
    .return(0)
# }
.annotate 'line', 166

.end # needs_updating_all


.sub 'needs_updating' :subid('WSubId_6')
        .param string __ARG_1
        .param string __ARG_2
# Body
# {
.annotate 'line', 172
    get_hll_global $P1, 'newer'
.annotate 'line', 173
# e: $I1
    null $I1
.annotate 'line', 174
# pirop stat
    stat $I1, __ARG_2, 0
.annotate 'line', 175
    not $I2, $I1
    if $I2 goto __label_2
    $I2 = $P1(__ARG_1, __ARG_2)
  __label_2:
    unless $I2 goto __label_1
.annotate 'line', 176
    .return(1)
  __label_1: # endif
.annotate 'line', 177
    .return(0)
# }
.annotate 'line', 178

.end # needs_updating


.sub 'concat_files' :subid('WSubId_10')
        .param pmc __ARG_1
        .param pmc __ARG_2
# Body
# {
.const 'Sub' $P3 = 'WSubId_11'
.annotate 'line', 182
    $P3(__ARG_2)
.annotate 'line', 183
    root_new $P4, ['parrot';'ResizablePMCArray']
    push $P4, __ARG_2
# predefined join
    join $S4, ", ", __ARG_1
    box $P5, $S4
    push $P4, $P5
# predefined sprintf
    sprintf $S3, "concat %s = %s", $P4
# predefined say
    say $S3
.annotate 'line', 184
# var dest_fh: $P1
    new $P1, [ 'FileHandle' ]
.annotate 'line', 185
    $P1.'open'(__ARG_2, "w")
.annotate 'line', 186
    iter $P6, __ARG_1
    set $P6, 0
  __label_1: # for iteration
    unless $P6 goto __label_2
    shift $S1, $P6
# {
.annotate 'line', 187
# var source_fh: $P2
    new $P2, [ 'FileHandle' ]
.annotate 'line', 188
    $P2.'open'($S1, "r")
.annotate 'line', 189
# contents: $S2
    $P4 = $P2.'readall'()
    null $S2
    if_null $P4, __label_3
    set $S2, $P4
  __label_3:
.annotate 'line', 190
    $P2.'close'()
.annotate 'line', 191
    $P1.'print'($S2)
.annotate 'line', 192
    $P1.'print'("\n")
# }
    goto __label_1
  __label_2: # endfor
.annotate 'line', 194
    $P1.'close'()
# }
.annotate 'line', 195

.end # concat_files

# End generated code
