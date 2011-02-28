# Begin generated code

.loadlib "io_ops"
# end libs
.namespace [ 'WinxedDistutils' ]

.sub 'winxed_setup'
.param pmc __ARG_1
.param pmc __ARG_2

.annotate 'file', 'src/winxed/Distutils.winxed'
.annotate 'line', 5
# Body
# {
# predefined load_bytecode
.annotate 'line', 7
load_bytecode "distutils.pbc"
.annotate 'line', 8
get_hll_global $P1, 'setup'
.annotate 'line', 9
get_hll_global $P2, 'register_step_before'
.annotate 'line', 11
.const 'Sub' $P3 = 'build_winxed'
.annotate 'line', 12
.const 'Sub' $P4 = 'clean_winxed'
.annotate 'line', 13
$P2("build", $P3)
.annotate 'line', 14
$P2("clean", $P4)
.annotate 'line', 15
$P1(__ARG_1, __ARG_2)
# }
.annotate 'line', 16

.end # winxed_setup


.sub 'build_winxed'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 18
# Body
# {
.annotate 'line', 20
# var winxed_files: $P1
$P1 = __ARG_1["pir_winxed"]
.annotate 'line', 21
unless_null $P1, __label_0
.annotate 'line', 22
.return()
__label_0: # endif
.annotate 'line', 23
get_hll_global $P2, 'newer'
.annotate 'line', 24
iter $P3, $P1
set $P3, 0
__label_1: # for iteration
unless $P3 goto __label_2
shift $S1, $P3
# {
.annotate 'line', 25
# string winxed_file: $S2
$S2 = $P1[$S1]
.annotate 'line', 26
# int e: $I1
null $I1
.annotate 'line', 27
# pirop stat
stat $I1, $S1, 0
.annotate 'line', 28
not $I2, $I1
if $I2 goto __label_4
$I2 = $P2($S2, $S1)
__label_4:
unless $I2 goto __label_3
.annotate 'line', 29
'compile_to_pir'($S2, $S1)
__label_3: # endif
# }
goto __label_1
__label_2: # endfor
# }
.annotate 'line', 31

.end # build_winxed


.sub 'clean_winxed'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 33
# Body
# {
.annotate 'line', 34
# var winxed_files: $P1
$P1 = __ARG_1["pir_winxed"]
.annotate 'line', 35
unless_null $P1, __label_0
.annotate 'line', 36
.return()
__label_0: # endif
.annotate 'line', 37
# int num_files: $I1
# predefined elements
elements $I1, $P1
.annotate 'line', 38
get_hll_global $P2, 'unlink'
.annotate 'line', 39
iter $P3, $P1
set $P3, 0
__label_1: # for iteration
unless $P3 goto __label_2
shift $S1, $P3
# {
.annotate 'line', 40
# int e: $I2
null $I2
.annotate 'line', 41
# pirop stat
stat $I2, $S1, 0
.annotate 'line', 42
unless $I2 goto __label_3
.annotate 'line', 43
$P2($S1)
__label_3: # endif
# }
goto __label_1
__label_2: # endfor
# }
.annotate 'line', 45

.end # clean_winxed


.sub 'get_pir_file_name'
.param string __ARG_1

.annotate 'line', 47
# Body
# {
.annotate 'line', 48
# int index: $I1
null $I1
.annotate 'line', 49
# pirop index
index $I1, __ARG_1, ".winxed"
.annotate 'line', 50
ne $I1, -1, __label_0
.annotate 'line', 51
concat $S2, __ARG_1, " is not a winxed file"
# predefined die
die $S2
__label_0: # endif
.annotate 'line', 52
# string pir_file: $S1
null $S1
.annotate 'line', 53
# pirop substr
substr $S1, __ARG_1, 0, $I1
.annotate 'line', 54
concat $S2, $S1, ".pir"
.return($S2)
# }
.annotate 'line', 55

.end # get_pir_file_name


.sub 'compile_to_pir'
.param string __ARG_1
.param string __ARG_2

.annotate 'line', 57
# Body
# {
.annotate 'line', 59
# string cmd: $S1
concat $S1, "winxed -c ", __ARG_1
.annotate 'line', 60
# int result: $I1
null $I1
.annotate 'line', 61
# predefined say
say $S1
.annotate 'line', 62
# pirop spawnw
spawnw $I1, $S1
.annotate 'line', 63
.return($I1)
# }
.annotate 'line', 64

.end # compile_to_pir

# End generated code
