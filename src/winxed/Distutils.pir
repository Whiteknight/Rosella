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
.annotate 'line', 4
load_bytecode "distutils.pbc"
.annotate 'line', 5
get_hll_global $P1, 'setup'
.annotate 'line', 6
get_hll_global $P2, 'register_step_before'
.annotate 'line', 8
.const 'Sub' $P3 = 'build_winxed'
.annotate 'line', 9
.const 'Sub' $P4 = 'clean_winxed'
.annotate 'line', 10
$P2("build", $P3)
.annotate 'line', 11
$P2("clean", $P4)
.annotate 'line', 12
$P1(__ARG_1, __ARG_2)
# }
.annotate 'line', 13

.end # winxed_setup


.sub 'build_winxed'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 15
# Body
# {
.annotate 'line', 16
# var winxed_files: $P1
$P1 = __ARG_1["pir_winxed"]
.annotate 'line', 17
unless_null $P1, __label_0
.annotate 'line', 18
.return()
__label_0: # endif
.annotate 'line', 19
# int num_files: $I1
# predefined elements
elements $I1, $P1
.annotate 'line', 20
iter $P2, $P1
set $P2, 0
__label_1: # for iteration
unless $P2 goto __label_2
shift $S1, $P2
# {
.annotate 'line', 21
$P3 = $P1[$S1]
'compile_to_pir'($P3, $S1)
# }
goto __label_1
__label_2: # endfor
# }
.annotate 'line', 23

.end # build_winxed


.sub 'clean_winxed'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 25
# Body
# {
.annotate 'line', 26
# var winxed_files: $P1
$P1 = __ARG_1["pir_winxed"]
.annotate 'line', 27
unless_null $P1, __label_0
.annotate 'line', 28
.return()
__label_0: # endif
.annotate 'line', 29
# int num_files: $I1
# predefined elements
elements $I1, $P1
.annotate 'line', 30
get_hll_global $P2, 'unlink'
.annotate 'line', 31
iter $P3, $P1
set $P3, 0
__label_1: # for iteration
unless $P3 goto __label_2
shift $S1, $P3
# {
.annotate 'line', 32
$P2($S1)
# }
goto __label_1
__label_2: # endfor
# }
.annotate 'line', 34

.end # clean_winxed


.sub 'get_pir_file_name'
.param string __ARG_1

.annotate 'line', 36
# Body
# {
.annotate 'line', 37
# int index: $I1
null $I1
.annotate 'line', 38
# pirop index
index $I1, __ARG_1, ".winxed"
.annotate 'line', 39
ne $I1, -1, __label_0
.annotate 'line', 40
concat $S2, __ARG_1, " is not a winxed file"
# predefined die
die $S2
__label_0: # endif
.annotate 'line', 41
# string pir_file: $S1
null $S1
.annotate 'line', 42
# pirop substr
substr $S1, __ARG_1, 0, $I1
.annotate 'line', 43
concat $S2, $S1, ".pir"
.return($S2)
# }
.annotate 'line', 44

.end # get_pir_file_name


.sub 'compile_to_pir'
.param string __ARG_1
.param string __ARG_2

.annotate 'line', 46
# Body
# {
.annotate 'line', 47
# string cmd: $S1
concat $S1, "winxed -c ", __ARG_1
.annotate 'line', 48
# int result: $I1
null $I1
.annotate 'line', 49
# predefined say
say $S1
.annotate 'line', 50
# pirop spawnw
spawnw $I1, $S1
.annotate 'line', 51
.return($I1)
# }
.annotate 'line', 52

.end # compile_to_pir

# End generated code
