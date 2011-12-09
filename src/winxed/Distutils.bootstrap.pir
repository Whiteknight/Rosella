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
.const 'Sub' WSubId_9 = "WSubId_9"
.const 'Sub' WSubId_10 = "WSubId_10"
.annotate 'file', 'src/winxed/Distutils.winxed'
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
.annotate 'line', 32
    $P1("install", WSubId_9)
.annotate 'line', 33
    $P1("uninstall", WSubId_10)
.annotate 'line', 34

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


.sub 'make_path_for' :subid('WSubId_17')
        .param string __ARG_1
.annotate 'line', 40
    get_hll_global $P1, 'dirname'
.annotate 'line', 41
    get_hll_global $P2, 'mkdir'
.annotate 'line', 42
    $P3 = $P1(__ARG_1)
    'mkpath'($P3, 1 :named("verbose"))
.annotate 'line', 43

.end # make_path_for


.sub 'build_winxed_files' :subid('WSubId_5')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_11 = "WSubId_11"
.const 'Sub' WSubId_12 = "WSubId_12"
.annotate 'line', 53
    $P1 = __ARG_1["pir_winxed"]
.annotate 'line', 54
    unless_null $P1, __label_1
.annotate 'line', 55
    .return()
  __label_1: # endif
.annotate 'line', 56
    $P2 = __ARG_1["winxed_debug"]
.annotate 'line', 57
    unless_null $P2, __label_2
.annotate 'line', 58
    box $P2, 0
  __label_2: # endif
.annotate 'line', 60
    if_null $P1, __label_4
    iter $P3, $P1
    set $P3, 0
  __label_3: # for iteration
    unless $P3 goto __label_4
    shift $S1, $P3
.annotate 'line', 61
    $S2 = $P1[$S1]
.annotate 'line', 62
    $P4 = WSubId_11($S2, $S1)
    if_null $P4, __label_5
    unless $P4 goto __label_5
.annotate 'line', 63
    set $I1, $P2
    WSubId_12($S2, $S1, $I1)
  __label_5: # endif
    goto __label_3
  __label_4: # endfor
.annotate 'line', 65

.end # build_winxed_files


.sub 'build_winxed_const_includes' :subid('WSubId_6')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_11 = "WSubId_11"
.const 'Sub' WSubId_13 = "WSubId_13"
.annotate 'line', 71
    $P1 = __ARG_1["include_winxed"]
.annotate 'line', 72
    unless_null $P1, __label_1
.annotate 'line', 73
    .return()
  __label_1: # endif
.annotate 'line', 75
    if_null $P1, __label_3
    iter $P2, $P1
    set $P2, 0
  __label_2: # for iteration
    unless $P2 goto __label_3
    shift $S1, $P2
.annotate 'line', 76
    $S2 = $P1[$S1]
.annotate 'line', 77
    $P3 = WSubId_11($S2, $S1)
    if_null $P3, __label_4
    unless $P3 goto __label_4
.annotate 'line', 78
    WSubId_13($S2, $S1)
  __label_4: # endif
    goto __label_2
  __label_3: # endfor
.annotate 'line', 80

.end # build_winxed_const_includes


.sub 'build_concat_winxed_files' :subid('WSubId_7')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_14 = "WSubId_14"
.const 'Sub' WSubId_15 = "WSubId_15"
.annotate 'line', 86
    $P1 = __ARG_1["winxed_winxed"]
.annotate 'line', 87
    unless_null $P1, __label_1
.annotate 'line', 88
    .return()
  __label_1: # endif
.annotate 'line', 91
    if_null $P1, __label_3
    iter $P3, $P1
    set $P3, 0
  __label_2: # for iteration
    unless $P3 goto __label_3
    shift $S1, $P3
.annotate 'line', 92
    $P2 = $P1[$S1]
.annotate 'line', 93
    $P4 = WSubId_14($P2, $S1)
    if_null $P4, __label_4
    unless $P4 goto __label_4
.annotate 'line', 94
    WSubId_15($P2, $S1)
  __label_4: # endif
    goto __label_2
  __label_3: # endfor
.annotate 'line', 96

.end # build_concat_winxed_files


.sub 'delete_files' :subid('WSubId_8')
        .param pmc __ARG_1
.const 'Sub' WSubId_16 = "WSubId_16"
.annotate 'line', 101
    unless_null __ARG_1, __label_1
.annotate 'line', 102
    .return()
  __label_1: # endif
.annotate 'line', 104
    if_null __ARG_1, __label_3
    iter $P1, __ARG_1
    set $P1, 0
  __label_2: # for iteration
    unless $P1 goto __label_3
    shift $S1, $P1
.annotate 'line', 105
    WSubId_16($S1)
    goto __label_2
  __label_3: # endfor
.annotate 'line', 106

.end # delete_files


.sub 'install_winxed_headers' :subid('WSubId_9')
        .param pmc __ARG_1 :named :slurpy
.annotate 'line', 110
    get_hll_global $P2, 'install'
.annotate 'line', 111
    get_hll_global $P3, 'get_libdir'
.annotate 'line', 112
    $P4 = $P3()
    set $S4, $P4
    concat $S1, $S4, "/include/"
.annotate 'line', 113
    $P1 = __ARG_1["inst_wxheader"]
.annotate 'line', 114
    if_null $P1, __label_2
    iter $P5, $P1
    set $P5, 0
  __label_1: # for iteration
    unless $P5 goto __label_2
    shift $S2, $P5
.annotate 'line', 115
    $S4 = $P1[$S2]
    concat $S3, $S1, $S4
.annotate 'line', 116
    $P2($S2, $S3, 1 :named("verbose"))
    goto __label_1
  __label_2: # endfor
.annotate 'line', 118

.end # install_winxed_headers


.sub 'uninstall_winxed_headers' :subid('WSubId_10')
        .param pmc __ARG_1 :named :slurpy
.const 'Sub' WSubId_16 = "WSubId_16"
.annotate 'line', 122
    get_hll_global $P2, 'get_libdir'
.annotate 'line', 124
    $P3 = $P2()
    set $S4, $P3
    concat $S1, $S4, "/include/"
.annotate 'line', 125
    $P1 = __ARG_1["inst_wxheader"]
.annotate 'line', 126
    if_null $P1, __label_2
    iter $P4, $P1
    set $P4, 0
  __label_1: # for iteration
    unless $P4 goto __label_2
    shift $S2, $P4
.annotate 'line', 127
    $S4 = $P1[$S2]
    concat $S3, $S1, $S4
.annotate 'line', 128
    WSubId_16($S3)
    goto __label_1
  __label_2: # endfor
.annotate 'line', 130

.end # uninstall_winxed_headers


.sub 'get_pir_file_name'
        .param string __ARG_1
.annotate 'line', 140
    $P1 = 'index'(__ARG_1, ".winxed")
    set $I1, $P1
.annotate 'line', 141
    ne $I1, -1, __label_1
.annotate 'line', 142
    concat $S1, __ARG_1, " is not a winxed file"
    die $S1
  __label_1: # endif
.annotate 'line', 143
    substr $S1, __ARG_1, 0, $I1
    concat $S2, $S1, ".pir"
    .return($S2)
.annotate 'line', 144

.end # get_pir_file_name


.sub 'compile_to_pir' :subid('WSubId_12')
        .param string __ARG_1
        .param string __ARG_2
        .param int __ARG_3
.const 'Sub' WSubId_17 = "WSubId_17"
.annotate 'line', 149
    WSubId_17(__ARG_2)
.annotate 'line', 150
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
.annotate 'line', 151
    null $I1
.annotate 'line', 152
    say $S1
.annotate 'line', 153
    spawnw $I1, $S1
.annotate 'line', 154
    unless $I1 goto __label_3
    set $S3, $I1
    concat $S2, "exit status: ", $S3
.annotate 'line', 155
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
    die $S4
  __label_3: # endif
.annotate 'line', 156

.end # compile_to_pir


.sub 'compile_to_pasm_include' :subid('WSubId_13')
        .param string __ARG_1
        .param string __ARG_2
.const 'Sub' WSubId_17 = "WSubId_17"
.annotate 'line', 161
    WSubId_17(__ARG_2)
.annotate 'line', 163
    root_new $P1, ['parrot';'ResizablePMCArray']
    assign $P1, 2
    $P1[0] = __ARG_2
    $P1[1] = __ARG_1
.annotate 'line', 162
    sprintf $S1, "winxed --nowarn -o %s --target=include %s", $P1
.annotate 'line', 165
    null $I1
.annotate 'line', 166
    say $S1
.annotate 'line', 167
    spawnw $I1, $S1
.annotate 'line', 168
    unless $I1 goto __label_1
    set $S3, $I1
    concat $S2, "exit status: ", $S3
.annotate 'line', 169
    concat $S4, $S2, "\ncommand: "
    concat $S4, $S4, $S1
    die $S4
  __label_1: # endif
.annotate 'line', 170

.end # compile_to_pasm_include


.sub 'delete_file' :subid('WSubId_16')
        .param string __ARG_1
.annotate 'line', 175
    get_hll_global $P1, 'unlink'
.annotate 'line', 176
    null $I1
.annotate 'line', 177
    stat $I1, __ARG_1, 0
.annotate 'line', 178
    unless $I1 goto __label_1
.annotate 'line', 179
    concat $S1, "unlink ", __ARG_1
    say $S1
.annotate 'line', 180
    $P1(__ARG_1)
  __label_1: # endif
.annotate 'line', 182

.end # delete_file


.sub 'needs_updating_all' :subid('WSubId_14')
        .param pmc __ARG_1
        .param string __ARG_2
.annotate 'line', 188
    unless_null __ARG_1, __label_1
.annotate 'line', 189
    .return(0)
  __label_1: # endif
.annotate 'line', 191
    get_hll_global $P1, 'newer'
.annotate 'line', 192
    null $I1
.annotate 'line', 193
    stat $I1, __ARG_2, 0
.annotate 'line', 194
    not $I2, $I1
    unless $I2 goto __label_2
.annotate 'line', 195
    .return(1)
  __label_2: # endif
.annotate 'line', 197
    if_null __ARG_1, __label_4
    iter $P2, __ARG_1
    set $P2, 0
  __label_3: # for iteration
    unless $P2 goto __label_4
    shift $S1, $P2
.annotate 'line', 198
    $P3 = $P1($S1, __ARG_2)
    if_null $P3, __label_5
    unless $P3 goto __label_5
.annotate 'line', 199
    .return(1)
  __label_5: # endif
    goto __label_3
  __label_4: # endfor
.annotate 'line', 201
    .return(0)
.annotate 'line', 202

.end # needs_updating_all


.sub 'needs_updating' :subid('WSubId_11')
        .param string __ARG_1
        .param string __ARG_2
.annotate 'line', 208
    get_hll_global $P1, 'newer'
.annotate 'line', 209
    null $I1
.annotate 'line', 210
    stat $I1, __ARG_2, 0
.annotate 'line', 211
    not $I2, $I1
    box $P2, $I2
    if $P2 goto __label_2
    $P2 = $P1(__ARG_1, __ARG_2)
  __label_2:
    if_null $P2, __label_1
    unless $P2 goto __label_1
.annotate 'line', 212
    .return(1)
  __label_1: # endif
.annotate 'line', 213
    .return(0)
.annotate 'line', 214

.end # needs_updating


.sub 'concat_files' :subid('WSubId_15')
        .param pmc __ARG_1
        .param pmc __ARG_2
.const 'Sub' WSubId_17 = "WSubId_17"
.const 'Sub' WSubId_16 = "WSubId_16"
.annotate 'line', 219
    WSubId_17(__ARG_2)
.annotate 'line', 220
    WSubId_16(__ARG_2)
.annotate 'line', 221
    root_new $P3, ['parrot';'ResizablePMCArray']
    assign $P3, 2
    $P3[0] = __ARG_2
    join $S4, ", ", __ARG_1
    $P3[1] = $S4
    sprintf $S3, "concat %s = %s", $P3
    say $S3
.annotate 'line', 222
    new $P1, [ 'FileHandle' ]
.annotate 'line', 223
    $P1.'open'(__ARG_2, "w")
.annotate 'line', 224
    if_null __ARG_1, __label_2
    iter $P4, __ARG_1
    set $P4, 0
  __label_1: # for iteration
    unless $P4 goto __label_2
    shift $S1, $P4
.annotate 'line', 225
    new $P2, [ 'FileHandle' ]
.annotate 'line', 226
    $P2.'open'($S1, "r")
.annotate 'line', 227
    $P3 = $P2.'readall'()
    null $S2
    if_null $P3, __label_3
    set $S2, $P3
  __label_3:
.annotate 'line', 228
    $P2.'close'()
.annotate 'line', 229
    concat $S3, "\n/* BEGIN INPUT FILE: ", $S1
    concat $S3, $S3, " */\n"
    $P1.'print'($S3)
.annotate 'line', 230
    $P1.'print'($S2)
.annotate 'line', 231
    $P1.'print'("\n")
.annotate 'line', 232
    concat $S3, "\n/* END INPUT FILE: ", $S1
    concat $S3, $S3, " */\n"
    $P1.'print'($S3)
    goto __label_1
  __label_2: # endfor
.annotate 'line', 234
    $P1.'close'()
.annotate 'line', 235

.end # concat_files

# End generated code
