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
.annotate 'file', 'Distutils.winxed'
.annotate 'line', 15
    load_bytecode "distutils.pbc"
.annotate 'line', 16
    get_hll_global $P1, 'register_step_before'
.annotate 'line', 18
    $P1("build", WSubId_5)
.annotate 'line', 19
    $P1("build", WSubId_6)
.annotate 'line', 20
    $P1("build", WSubId_7)
.annotate 'line', 22
    set $P2, WSubId_2
    $P1("clean", $P2)
.annotate 'line', 25
    set $P2, WSubId_3
    $P1("clean", $P2)
.annotate 'line', 28
    set $P2, WSubId_4
    $P1("clean", $P2)
.annotate 'line', 31

.end # winxed_setup


.sub '' :anon :subid('WSubId_2')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_8 = "WSubId_8"
.annotate 'line', 23
    $P1 = __ARG_1["winxed_winxed"]
    WSubId_8($P1)
.annotate 'line', 24

.end # WSubId_2


.sub '' :anon :subid('WSubId_3')
        .param pmc __ARG_2 :named :slurpy
.const 'Sub' WSubId_8 = "WSubId_8"
.annotate 'line', 26
    $P1 = __ARG_2["pir_winxed"]
    WSubId_8($P1)
.annotate 'line', 27

.end # WSubId_3


.sub '' :anon :subid('WSubId_4')
        .param pmc __ARG_3 :named :slurpy
.const 'Sub' WSubId_8 = "WSubId_8"
.annotate 'line', 29
    $P1 = __ARG_3["include_winxed"]
    WSubId_8($P1)
.annotate 'line', 30

.end # WSubId_4


.sub 'make_path_for' :subid('WSubId_15')
        .param string __ARG_1
.annotate 'line', 37
    get_hll_global $P1, 'dirname'
.annotate 'line', 38
    get_hll_global $P2, 'mkdir'
.annotate 'line', 39
    $P3 = $P1(__ARG_1)
    'mkpath'($P3, 1 :named("verbose"))
.annotate 'line', 40

.end # make_path_for


.sub 'build_winxed_files' :subid('WSubId_5')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_9 = "WSubId_9"
.const 'Sub' WSubId_10 = "WSubId_10"
.annotate 'line', 50
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 51
    unless_null $P1, __label_1
.annotate 'line', 52
    .return()
  __label_1: # endif
.annotate 'line', 53
    $P2 = __ARG_1["winxed_debug"]
.annotate 'line', 54
    unless_null $P2, __label_2
.annotate 'line', 55
    box $P2, 0
  __label_2: # endif
.annotate 'line', 57
    if_null $P1, __label_4
    iter $P3, $P1
    set $P3, 0
  __label_3: # for iteration
    unless $P3 goto __label_4
    shift $S1, $P3
.annotate 'line', 58
    $S2 = $P1[$S1]
.annotate 'line', 59
    $P4 = WSubId_9($S2, $S1)
    if_null $P4, __label_5
    unless $P4 goto __label_5
.annotate 'line', 60
    set $I1, $P2
    WSubId_10($S2, $S1, $I1)
  __label_5: # endif
    goto __label_3
  __label_4: # endfor
.annotate 'line', 62

.end # build_winxed_files


.sub 'build_winxed_const_includes' :subid('WSubId_6')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_9 = "WSubId_9"
.const 'Sub' WSubId_11 = "WSubId_11"
.annotate 'line', 68
    $P1 = __ARG_1["include_winxed"]
.annotate 'line', 69
    unless_null $P1, __label_1
.annotate 'line', 70
    .return()
  __label_1: # endif
.annotate 'line', 72
    if_null $P1, __label_3
    iter $P2, $P1
    set $P2, 0
  __label_2: # for iteration
    unless $P2 goto __label_3
    shift $S1, $P2
.annotate 'line', 73
    $S2 = $P1[$S1]
.annotate 'line', 74
    $P3 = WSubId_9($S2, $S1)
    if_null $P3, __label_4
    unless $P3 goto __label_4
.annotate 'line', 75
    WSubId_11($S2, $S1)
  __label_4: # endif
    goto __label_2
  __label_3: # endfor
.annotate 'line', 77

.end # build_winxed_const_includes


.sub 'build_concat_winxed_files' :subid('WSubId_7')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_12 = "WSubId_12"
.const 'Sub' WSubId_13 = "WSubId_13"
.annotate 'line', 83
    $P1 = __ARG_1["winxed_winxed"]
.annotate 'line', 84
    unless_null $P1, __label_1
.annotate 'line', 85
    .return()
  __label_1: # endif
.annotate 'line', 88
    if_null $P1, __label_3
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
.annotate 'line', 89
    $P2 = $P1[$S1]
.annotate 'line', 90
    $P4 = WSubId_12($P2, $S1)
    if_null $P4, __label_4
    unless $P4 goto __label_4
.annotate 'line', 91
    WSubId_13($P2, $S1)
  __label_4: # endif
    goto __label_2
  __label_3: # endfor
.annotate 'line', 93

.end # build_concat_winxed_files


.sub 'delete_files' :subid('WSubId_8')
        .param pmc __ARG_1
.const 'Sub' WSubId_14 = "WSubId_14"
.annotate 'line', 98
    unless_null __ARG_1, __label_1
.annotate 'line', 99
    .return()
  __label_1: # endif
.annotate 'line', 101
    if_null __ARG_1, __label_3
    iter $P1, __ARG_1
    set $P1, 0
  __label_2: # for iteration
    unless $P1 goto __label_3
    shift $S1, $P1
.annotate 'line', 102
    WSubId_14($S1)
    goto __label_2
  __label_3: # endfor
.annotate 'line', 103

.end # delete_files


.sub 'get_pir_file_name'
        .param string __ARG_1
.annotate 'line', 113
    $P1 = 'index'(__ARG_1, ".winxed")
    set $I1, $P1
.annotate 'line', 114
    ne $I1, -1, __label_1
.annotate 'line', 115
    concat $S1, __ARG_1, " is not a winxed file"
    die $S1
  __label_1: # endif
.annotate 'line', 116
    substr $S1, __ARG_1, 0, $I1
    concat $S2, $S1, ".pir"
    .return($S2)
.annotate 'line', 117

.end # get_pir_file_name


.sub 'compile_to_pir' :subid('WSubId_10')
        .param string __ARG_1
        .param string __ARG_2
        .param int __ARG_3
.const 'Sub' WSubId_15 = "WSubId_15"
.annotate 'line', 122
    WSubId_15(__ARG_2)
.annotate 'line', 123
    root_new $P1, ['parrot';'ResizablePMCArray']
    assign $P1, 3
    if __ARG_3 goto __label_2
    set $S2, ""
    goto __label_1
  __label_2:
    set $S2, "--debug"
  __label_1:
    $P1[0] = $S2
    $P1[1] = __ARG_2
    $P1[2] = __ARG_1
    sprintf $S1, "winxed %s -o %s -c %s", $P1
.annotate 'line', 124
    null $I1
.annotate 'line', 125
    say $S1
.annotate 'line', 126
    spawnw $I1, $S1
.annotate 'line', 127
    unless $I1 goto __label_3
    set $S3, $I1
    concat $S2, "exit status: ", $S3
.annotate 'line', 128
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
    die $S4
  __label_3: # endif
.annotate 'line', 129

.end # compile_to_pir


.sub 'compile_to_pasm_include' :subid('WSubId_11')
        .param string __ARG_1
        .param string __ARG_2
.const 'Sub' WSubId_15 = "WSubId_15"
.annotate 'line', 134
    WSubId_15(__ARG_2)
.annotate 'line', 136
    root_new $P1, ['parrot';'ResizablePMCArray']
    assign $P1, 2
    $P1[0] = __ARG_2
    $P1[1] = __ARG_1
.annotate 'line', 135
    sprintf $S1, "winxed --nowarn -o %s --target=include %s", $P1
.annotate 'line', 138
    null $I1
.annotate 'line', 139
    say $S1
.annotate 'line', 140
    spawnw $I1, $S1
.annotate 'line', 141
    unless $I1 goto __label_1
    set $S3, $I1
    concat $S2, "exit status: ", $S3
.annotate 'line', 142
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
    die $S4
  __label_1: # endif
.annotate 'line', 143

.end # compile_to_pasm_include


.sub 'delete_file' :subid('WSubId_14')
        .param string __ARG_1
.annotate 'line', 148
    get_hll_global $P1, 'unlink'
.annotate 'line', 149
    null $I1
.annotate 'line', 150
    stat $I1, __ARG_1, 0
.annotate 'line', 151
    unless $I1 goto __label_1
.annotate 'line', 152
    concat $S1, "unlink ", __ARG_1
    say $S1
.annotate 'line', 153
    $P1(__ARG_1)
  __label_1: # endif
.annotate 'line', 155

.end # delete_file


.sub 'needs_updating_all' :subid('WSubId_12')
        .param pmc __ARG_1
        .param string __ARG_2
.annotate 'line', 161
    unless_null __ARG_1, __label_1
.annotate 'line', 162
    .return(0)
  __label_1: # endif
.annotate 'line', 164
    get_hll_global $P1, 'newer'
.annotate 'line', 165
    null $I1
.annotate 'line', 166
    stat $I1, __ARG_2, 0
.annotate 'line', 167
    not $I2, $I1
    unless $I2 goto __label_2
.annotate 'line', 168
    .return(1)
  __label_2: # endif
.annotate 'line', 170
    if_null __ARG_1, __label_4
    iter $P2, __ARG_1
    set $P2, 0
  __label_3: # for iteration
    unless $P2 goto __label_4
    shift $S1, $P2
.annotate 'line', 171
    $P3 = $P1($S1, __ARG_2)
    if_null $P3, __label_5
    unless $P3 goto __label_5
.annotate 'line', 172
    .return(1)
  __label_5: # endif
    goto __label_3
  __label_4: # endfor
.annotate 'line', 174
    .return(0)
.annotate 'line', 175

.end # needs_updating_all


.sub 'needs_updating' :subid('WSubId_9')
        .param string __ARG_1
        .param string __ARG_2
.annotate 'line', 181
    get_hll_global $P1, 'newer'
.annotate 'line', 182
    null $I1
.annotate 'line', 183
    stat $I1, __ARG_2, 0
.annotate 'line', 184
    not $I2, $I1
    box $P2, $I2
    if $P2 goto __label_2
    $P2 = $P1(__ARG_1, __ARG_2)
  __label_2:
    if_null $P2, __label_1
    unless $P2 goto __label_1
.annotate 'line', 185
    .return(1)
  __label_1: # endif
.annotate 'line', 186
    .return(0)
.annotate 'line', 187

.end # needs_updating


.sub 'concat_files' :subid('WSubId_13')
        .param pmc __ARG_1
        .param pmc __ARG_2
.const 'Sub' WSubId_15 = "WSubId_15"
.const 'Sub' WSubId_14 = "WSubId_14"
.annotate 'line', 192
    WSubId_15(__ARG_2)
.annotate 'line', 193
    WSubId_14(__ARG_2)
.annotate 'line', 194
    root_new $P3, ['parrot';'ResizablePMCArray']
    assign $P3, 2
    $P3[0] = __ARG_2
    join $S4, ", ", __ARG_1
    $P3[1] = $S4
    sprintf $S3, "concat %s = %s", $P3
    say $S3
.annotate 'line', 195
    new $P1, [ 'FileHandle' ]
.annotate 'line', 196
    $P1.'open'(__ARG_2, "w")
.annotate 'line', 197
    if_null __ARG_1, __label_2
    iter $P4, __ARG_1
    set $P4, 0
  __label_1: # for iteration
    unless $P4 goto __label_2
    shift $S1, $P4
.annotate 'line', 198
    new $P2, [ 'FileHandle' ]
.annotate 'line', 199
    $P2.'open'($S1, "r")
.annotate 'line', 200
    $P3 = $P2.'readall'()
    null $S2
    if_null $P3, __label_3
    set $S2, $P3
  __label_3:
.annotate 'line', 201
    $P2.'close'()
.annotate 'line', 202
    concat $S3, "\n/* BEGIN INPUT FILE: ", $S1
    concat $S3, $S3, " */\n"
    $P1.'print'($S3)
.annotate 'line', 203
    $P1.'print'($S2)
.annotate 'line', 204
    $P1.'print'("\n")
.annotate 'line', 205
    concat $S3, "\n/* END INPUT FILE: ", $S1
    concat $S3, $S3, " */\n"
    $P1.'print'($S3)
    goto __label_1
  __label_2: # endfor
.annotate 'line', 207
    $P1.'close'()
.annotate 'line', 208

.end # concat_files

# End generated code
