# Begin generated code

.namespace [ 'WinxedDistutils' ]

.sub 'winxed_setup'
.param pmc __ARG_1
.param pmc __ARG_2

.annotate 'file', 'src/winxed/Distutils.winxed'
.annotate 'line', 3
# Body
# {
# predefined load_bytecode
.annotate 'line', 5
load_bytecode "distutils.pbc"
.annotate 'line', 6
get_hll_global $P1, 'setup'
.annotate 'line', 7
get_hll_global $P2, 'register_step_before'
.annotate 'line', 9
.const 'Sub' $P3 = 'build_winxed'
.annotate 'line', 10
.const 'Sub' $P4 = 'clean_winxed'
.annotate 'line', 11
$P2("build", $P3)
.annotate 'line', 12
$P2("clean", $P4)
.annotate 'line', 13
$P1(__ARG_1, __ARG_2)
# }
.annotate 'line', 14

.end # winxed_setup


.sub 'build_winxed'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 16
# Body
# {
.annotate 'line', 18
# var winxed_files: $P1
$P1 = __ARG_1["pir_winxed"]
.annotate 'line', 19
unless_null $P1, __label_0
.annotate 'line', 20
.return()
__label_0: # endif
.annotate 'line', 21
get_hll_global $P2, 'newer'
.annotate 'line', 22
iter $P3, $P1
set $P3, 0
__label_1: # for iteration
unless $P3 goto __label_2
shift $S1, $P3
# {
.annotate 'line', 23
# string winxed_file: $S2
$S2 = $P1[$S1]
.annotate 'line', 24
$P4 = $P2($S2, $S1)
if_null $P4, __label_3
unless $P4 goto __label_3
.annotate 'line', 25
'compile_to_pir'($S2, $S1)
__label_3: # endif
# }
goto __label_1
__label_2: # endfor
# }
.annotate 'line', 27

.end # build_winxed


.sub 'clean_winxed'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 29
# Body
# {
.annotate 'line', 30
# var winxed_files: $P1
$P1 = __ARG_1["pir_winxed"]
.annotate 'line', 31
unless_null $P1, __label_0
.annotate 'line', 32
.return()
__label_0: # endif
.annotate 'line', 33
# int num_files: $I1
# predefined elements
elements $I1, $P1
.annotate 'line', 34
get_hll_global $P2, 'unlink'
.annotate 'line', 35
iter $P3, $P1
set $P3, 0
__label_1: # for iteration
unless $P3 goto __label_2
shift $S1, $P3
# {
.annotate 'line', 36
$P2($S1)
# }
goto __label_1
__label_2: # endfor
# }
.annotate 'line', 38

.end # clean_winxed


.sub 'get_pir_file_name'
.param string __ARG_1

.annotate 'line', 40
# Body
# {
.annotate 'line', 41
# int index: $I1
null $I1
.annotate 'line', 42
# pirop index
index $I1, __ARG_1, ".winxed"
.annotate 'line', 43
ne $I1, -1, __label_0
.annotate 'line', 44
concat $S2, __ARG_1, " is not a winxed file"
# predefined die
die $S2
__label_0: # endif
.annotate 'line', 45
# string pir_file: $S1
null $S1
.annotate 'line', 46
# pirop substr
substr $S1, __ARG_1, 0, $I1
.annotate 'line', 47
concat $S2, $S1, ".pir"
.return($S2)
# }
.annotate 'line', 48

.end # get_pir_file_name


.sub 'compile_to_pir'
.param string __ARG_1
.param string __ARG_2

.annotate 'line', 50
# Body
# {
.annotate 'line', 52
# string cmd: $S1
concat $S1, "winxed -c ", __ARG_1
.annotate 'line', 53
# int result: $I1
null $I1
.annotate 'line', 54
# predefined say
say $S1
.annotate 'line', 55
# pirop spawnw
spawnw $I1, $S1
.annotate 'line', 56
.return($I1)
# }
.annotate 'line', 57

.end # compile_to_pir

# End generated code
