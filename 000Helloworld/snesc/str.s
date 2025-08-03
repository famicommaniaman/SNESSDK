.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __writestring_locals 4
.define __writenum_locals 1

.section ".text_0x0" superfree

writestring:
.ifgr __writestring_locals 0
tsa
sec
sbc #__writestring_locals
tas
.endif
lda 11 + __writestring_locals + 1,s
sta.b tcc__r0
sta -2 + __writestring_locals + 1,s
__local_3:
lda 3 + __writestring_locals + 1,s
sta.b tcc__r0
lda 5 + __writestring_locals + 1,s
sta.b tcc__r0h
lda.w #0
sep #$20
lda.b [tcc__r0]
rep #$20
sta.b tcc__r1
sta -4 + __writestring_locals + 1,s
lda.b tcc__r1 ; DON'T OPTIMIZE
bne +
brl __local_0
+
lda -4 + __writestring_locals + 1,s
sta.b tcc__r0
ldx #1
sec
sbc #10
tay
beq +
dex
+
stx.b tcc__r5
txa
bne +
brl __local_1
+
lda -2 + __writestring_locals + 1,s
clc
adc.w #32
sta -2 + __writestring_locals + 1,s
sta.b tcc__r0
sta 11 + __writestring_locals + 1,s
bra __local_2
__local_1:
lda 11 + __writestring_locals + 1,s
asl a
sta.b tcc__r0
lda 7 + __writestring_locals + 1,s
sta.b tcc__r1
lda 9 + __writestring_locals + 1,s
sta.b tcc__r1h
clc
lda.b tcc__r1
adc.b tcc__r0
sta.b tcc__r1
lda -4 + __writestring_locals + 1,s
sta.b tcc__r0
lda 13 + __writestring_locals + 1,s
sta.b tcc__r2
clc
adc.b tcc__r0
sta.b [tcc__r1]
lda 11 + __writestring_locals + 1,s
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
inc.b tcc__r0
lda.b tcc__r0
sta 11 + __writestring_locals + 1,s
__local_2:
lda 5 + __writestring_locals + 1,s
sta.b tcc__r0h
lda 3 + __writestring_locals + 1,s
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
inc.b tcc__r0
lda.b tcc__r0
sta 3 + __writestring_locals + 1,s
lda.b tcc__r0h
sta 5 + __writestring_locals + 1,s
jmp.w __local_3
__local_0:
.ifgr __writestring_locals 0
tsa
clc
adc #__writestring_locals
tas
.endif
rtl
.ends

.section ".text_0x1" superfree

writenum:
.ifgr __writenum_locals 0
tsa
sec
sbc #__writenum_locals
tas
.endif
lda.w #0
sep #$20
lda 7 + __writenum_locals + 1,s
rep #$20
dec a
sta.b tcc__r0
lda 12 + __writenum_locals + 1,s
clc
adc.b tcc__r0
sta.b tcc__r1
sta 12 + __writenum_locals + 1,s
lda 3 + __writenum_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(3 + __writenum_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
ora.b tcc__r0
bne +
brl __local_4
+
bra __local_5
__local_4:
lda 12 + __writenum_locals + 1,s
asl a
sta.b tcc__r0
lda 8 + __writenum_locals + 1,s
sta.b tcc__r1
lda 10 + __writenum_locals + 1,s
sta.b tcc__r1h
clc
lda.b tcc__r1
adc.b tcc__r0
sta.b tcc__r1
lda 14 + __writenum_locals + 1,s
sta.b tcc__r0
sta.b [tcc__r1]
jmp.w __local_6
__local_5:
__local_12:
lda.w #0
sep #$20
lda 7 + __writenum_locals + 1,s
rep #$20
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
brl __local_7
+
lda 3 + __writenum_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(3 + __writenum_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
ora.b tcc__r0
bne +
__local_7:
brl __local_8
+
pea.w 0
pea.w 10
lda 7 + __writenum_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(7 + __writenum_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
pha
pei (tcc__r0)
jsr.l tcc__umoddi3
tsa
clc
adc #8
tas
lda.w #255
sta.b tcc__r2
stz.b tcc__r3
lda.b tcc__r0
and.b tcc__r2
sta.b tcc__r0
lda.b tcc__r1
and.b tcc__r3
sta.b tcc__r1
sep #$20
lda.b tcc__r0
sta -1 + __writenum_locals + 1,s
rep #$20
lda 3 + __writenum_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(3 + __writenum_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
ora.b tcc__r0
beq +
brl __local_9
+
lda.w #0
sep #$20
lda -1 + __writenum_locals + 1,s
rep #$20
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
beq +
__local_9:
brl __local_10
+
bra __local_11
__local_10:
lda 12 + __writenum_locals + 1,s
asl a
sta.b tcc__r0
lda 8 + __writenum_locals + 1,s
sta.b tcc__r1
lda 10 + __writenum_locals + 1,s
sta.b tcc__r1h
clc
lda.b tcc__r1
adc.b tcc__r0
sta.b tcc__r1
lda.w #0
sep #$20
lda -1 + __writenum_locals + 1,s
rep #$20
sta.b tcc__r0
lda 14 + __writenum_locals + 1,s
sta.b tcc__r2
clc
adc.b tcc__r0
sta.b tcc__r0
sta.b [tcc__r1]
__local_11:
pea.w 0
pea.w 10
lda 7 + __writenum_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(7 + __writenum_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
pha
pei (tcc__r0)
jsr.l tcc__udivdi3
tsa
clc
adc #8
tas
lda.b tcc__r0
sta 3 + __writenum_locals + 1,s
stz.b tcc__r2h
tsa
clc
adc #(3 + __writenum_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r1
sta.b [tcc__r2]
lda 12 + __writenum_locals + 1,s
clc
adc.w #65535
sta 12 + __writenum_locals + 1,s
lda.w #0
sep #$20
lda 7 + __writenum_locals + 1,s
rep #$20
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
dec.b tcc__r0
sep #$20
lda.b tcc__r0
sta 7 + __writenum_locals + 1,s
rep #$20
jmp.w __local_12
__local_8:
__local_6:
.ifgr __writenum_locals 0
tsa
clc
adc #__writenum_locals
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
__local_dummybss dsb 1
.ends
