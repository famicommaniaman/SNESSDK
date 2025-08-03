.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __write_locals 0
.define __main_locals 12

.section ".text_0x0" superfree

write:
.ifgr __write_locals 0
tsa
sec
sbc #__write_locals
tas
.endif
__local_1:
lda 3 + __write_locals + 1,s
sta.b tcc__r0
lda 5 + __write_locals + 1,s
sta.b tcc__r0h
lda.w #0
sep #$20
lda.b [tcc__r0]
rep #$20
xba
xba
bpl +
ora.w #$ff00
+
sta.b tcc__r1
lda.b tcc__r1 ; DON'T OPTIMIZE
bne +
brl __local_0
+
lda 5 + __write_locals + 1,s
sta.b tcc__r0h
lda 3 + __write_locals + 1,s
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
inc.b tcc__r0
lda.b tcc__r0
sta 3 + __write_locals + 1,s
lda.b tcc__r0h
sta 5 + __write_locals + 1,s
lda.w #0
sep #$20
lda.b [tcc__r1]
rep #$20
xba
xba
bpl +
ora.w #$ff00
+
sta.b tcc__r0
lda.w #65534
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
jmp.w __local_1
__local_0:
.ifgr __write_locals 0
tsa
clc
adc #__write_locals
tas
.endif
rtl
.ends

.section ".text_0x1" superfree

main:
.ifgr __main_locals 0
tsa
sec
sbc #__main_locals
tas
.endif
jsr.l snesc_init
sep #$20
lda.b #72
sta -12 + __main_locals + 1,s
lda.b #69
sta -11 + __main_locals + 1,s
lda.b #76
sta -10 + __main_locals + 1,s
lda.b #76
sta -9 + __main_locals + 1,s
lda.b #79
sta -8 + __main_locals + 1,s
lda.b #44
sta -7 + __main_locals + 1,s
lda.b #87
sta -6 + __main_locals + 1,s
lda.b #79
sta -5 + __main_locals + 1,s
lda.b #82
sta -4 + __main_locals + 1,s
lda.b #76
sta -3 + __main_locals + 1,s
lda.b #68
sta -2 + __main_locals + 1,s
rep #$20
lda.w #0
sep #$20
sta -1 + __main_locals + 1,s
rep #$20
pea.w 3840
pea.w :tiles1
pea.w tiles1 + 0
pea.w 0
jsr.l settiles
tsa
clc
adc #8
tas
pea.w 592
pea.w :tiles2
pea.w tiles2 + 0
pea.w 1
jsr.l settiles
tsa
clc
adc #8
tas
pea.w 512
pea.w :palette
pea.w palette + 0
pea.w :pal
pea.w pal + 0
jsr.l memcpy
tsa
clc
adc #10
tas
pea.w 1014
pea.w 584
pea.w :blockmap
pea.w blockmap + 0
stz.b tcc__r0h
tsa
clc
adc #(-4 + __main_locals + 1)
pei (tcc__r0h)
pha
jsr.l writestring
tsa
clc
adc #12
tas
pea.w :blockmap
pea.w blockmap + 0
pea.w 0
jsr.l setmap
tsa
clc
adc #6
tas
pea.w :backmap
pea.w backmap + 0
pea.w 1
jsr.l setmap
tsa
clc
adc #6
tas
pea.w :pal
pea.w pal + 0
jsr.l setpalette
tsa
clc
adc #4
tas
jsr.l enablescreen
__tccs_label1:
__local_2:
jsr.l resettimer
pea.w 1
jsr.l sync
pla
bra __local_2
.ifgr __main_locals 0
tsa
clc
adc #__main_locals
tas
.endif
rtl
.ends
.ramsection "ram.data" bank $7f slot 3
__local_dummy.data dsb 1

.ends

.section ".data" superfree

__local_dummy.data: .db 0
.ends

.section ".rodata" superfree

__local_dummy.rodata: .db 0
.ends

.ramsection ".bss" bank $7e slot 2
blockmap dsb 2048
backmap dsb 2048
pal dsb 512
blocks dsb 100
.ends
