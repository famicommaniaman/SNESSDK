.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __do_dma_locals 0
.define __snesc_vblank_locals 10
.define __snesc_init_locals 2

.section ".text_0x0" superfree

do_dma:
.ifgr __do_dma_locals 0
tsa
sec
sbc #__do_dma_locals
tas
.endif
lda.w #0
sep #$20
lda 3 + __do_dma_locals + 1,s
rep #$20
and.w #128
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
brl __local_0
+
lda.w #1024
sta.b tcc__r0
lda.w #17152
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
stz.b tcc__r0
lda.w #8450
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
lda.w #:snesc_oam_table1
sta.b tcc__r0h
lda.w #snesc_oam_table1 + 0
sta.b tcc__r0
lda.w #17154
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
ldy #0
sta.b [tcc__r9],y
lda.b tcc__r0h
iny
iny
sta.b [tcc__r9],y
lda.w #544
sta.b tcc__r0
lda.w #17157
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
lda.w #1
sta.b tcc__r0
lda.w #16907
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
__local_0:
lda.w #0
sep #$20
lda 3 + __do_dma_locals + 1,s
rep #$20
and.w #64
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
brl __local_1
+
lda.w #8704
sta.b tcc__r0
lda.w #17152
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
lda.w #:snesc_palette
sta.b tcc__r0h
lda.w #snesc_palette + 0
sta.b tcc__r0
lda.w #17154
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
ldy #0
sta.b [tcc__r9],y
lda.b tcc__r0h
iny
iny
sta.b [tcc__r9],y
lda.w #512
sta.b tcc__r0
lda.w #17157
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
stz.b tcc__r0
lda.w #8481
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
lda.w #1
sta.b tcc__r0
lda.w #16907
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
__local_1:
.ifgr __do_dma_locals 0
tsa
clc
adc #__do_dma_locals
tas
.endif
rtl
.ends

.section ".text_0x1" superfree

snesc_vblank:
.ifgr __snesc_vblank_locals 0
tsa
sec
sbc #__snesc_vblank_locals
tas
.endif
lda.w #0
sep #$20
lda.w snesc_do_copy + 0
sta -1 + __snesc_vblank_locals + 1,s
rep #$20
lda.w #0
sep #$20
lda -1 + __snesc_vblank_locals + 1,s
rep #$20
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
brl __local_2
+
lda.w #0
sep #$20
sta.w snesc_do_copy + 0
rep #$20
lda.w #0
sep #$20
lda -1 + __snesc_vblank_locals + 1,s
pha
rep #$20
jsr.l do_dma
tsa
clc
adc #1
tas
lda.w #0
sep #$20
lda -1 + __snesc_vblank_locals + 1,s
rep #$20
and.w #63
sep #$20
sta -1 + __snesc_vblank_locals + 1,s
rep #$20
lda.w #0
sep #$20
lda -1 + __snesc_vblank_locals + 1,s
rep #$20
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
brl __local_3
+
stz.b tcc__r0
lda.b tcc__r0
sta -4 + __snesc_vblank_locals + 1,s
__local_15:
lda.w #0
sep #$20
lda -1 + __snesc_vblank_locals + 1,s
rep #$20
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
brl __local_4
+
lda -4 + __snesc_vblank_locals + 1,s
asl a
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_dma_transfers
sta.b tcc__r1h
lda.w #snesc_dma_transfers + 0
clc
adc.b tcc__r0
clc
adc.w #3
sta.b tcc__r1
lda.w #0
sep #$20
lda.b [tcc__r1]
rep #$20
sta.b tcc__r0
bra __local_5
bra __local_6
__local_5:
ldx #1
lda.b tcc__r0
sec
sbc #0
tay
beq +
dex
+
stx.b tcc__r5
txa
bne +
brl __local_7
+
__local_6:
lda.w #6145
sta.b tcc__r0
lda.w #17152
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
lda -4 + __snesc_vblank_locals + 1,s
asl a
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_dma_transfers
sta.b tcc__r1h
lda.w #snesc_dma_transfers + 0
clc
adc.b tcc__r0
clc
adc.w #4
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r0
lda.w #8470
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
jmp.w __local_8
bra __local_9
__local_7:
ldx #1
lda.b tcc__r0
sec
sbc #1
tay
beq +
dex
+
stx.b tcc__r5
txa
bne +
brl __local_10
+
__local_9:
lda.w #1024
sta.b tcc__r0
lda.w #17152
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
lda -4 + __snesc_vblank_locals + 1,s
asl a
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_dma_transfers
sta.b tcc__r1h
lda.w #snesc_dma_transfers + 0
clc
adc.b tcc__r0
clc
adc.w #4
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r0
lda.w #8450
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
jmp.w __local_11
bra __local_12
__local_10:
ldx #1
lda.b tcc__r0
sec
sbc #2
tay
beq +
dex
+
stx.b tcc__r5
txa
bne +
brl __local_13
+
__local_12:
lda.w #8704
sta.b tcc__r0
lda.w #17152
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
lda -4 + __snesc_vblank_locals + 1,s
asl a
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_dma_transfers
sta.b tcc__r1h
lda.w #snesc_dma_transfers + 0
clc
adc.b tcc__r0
clc
adc.w #4
sta.b tcc__r1
lda.w #0
sep #$20
lda.b [tcc__r1]
rep #$20
sta.b tcc__r0
lda.w #8481
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
__local_13:
__local_8:
__local_11:
__local_14:
lda -4 + __snesc_vblank_locals + 1,s
asl a
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_dma_transfers
sta.b tcc__r1h
lda.w #snesc_dma_transfers + 0
clc
adc.b tcc__r0
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r0
lda.w #17154
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
lda -4 + __snesc_vblank_locals + 1,s
asl a
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_dma_transfers
sta.b tcc__r1h
lda.w #snesc_dma_transfers + 0
clc
adc.b tcc__r0
clc
adc.w #6
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r0
lda.w #17157
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b [tcc__r9]
lda -4 + __snesc_vblank_locals + 1,s
asl a
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_dma_transfers
sta.b tcc__r1h
lda.w #snesc_dma_transfers + 0
clc
adc.b tcc__r0
inc a
inc a
sta.b tcc__r1
lda.w #0
sep #$20
lda.b [tcc__r1]
rep #$20
sta.b tcc__r0
lda.w #17156
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
lda.w #1
sta.b tcc__r0
lda.w #16907
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
lda -4 + __snesc_vblank_locals + 1,s
inc a
sta -4 + __snesc_vblank_locals + 1,s
lda.w #0
sep #$20
lda -1 + __snesc_vblank_locals + 1,s
rep #$20
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
dec.b tcc__r0
sep #$20
lda.b tcc__r0
sta -1 + __snesc_vblank_locals + 1,s
rep #$20
jmp.w __local_15
__local_4:
__local_3:
__local_2:
__local_17:
lda.w #0
sep #$20
lda.l 16914
rep #$20
and.w #1
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
brl __local_16
+
bra __local_17
__local_16:
stz.b tcc__r0
lda.b tcc__r0
sta -6 + __snesc_vblank_locals + 1,s
__local_20:
lda -6 + __snesc_vblank_locals + 1,s
sta.b tcc__r0
ldx #1
sec
sbc.w #4
tay
bcc ++
+ dex
++
stx.b tcc__r5
txa
bne +
brl __local_18
+
bra __local_19
__local_21:
lda -6 + __snesc_vblank_locals + 1,s
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
inc.b tcc__r0
lda.b tcc__r0
sta -6 + __snesc_vblank_locals + 1,s
bra __local_20
__local_19:
lda -6 + __snesc_vblank_locals + 1,s
asl a
sta.b tcc__r0
lda.w #:snesc_controllers
sta.b tcc__r1h
lda.w #snesc_controllers + 0
clc
adc.b tcc__r0
sta.b tcc__r1
lda -6 + __snesc_vblank_locals + 1,s
asl a
sta.b tcc__r0
stz.b tcc__r0h
clc
lda.b tcc__r0
adc.w #16920
sta.b tcc__r0
lda.b [tcc__r1]
sta.b tcc__r2
lda.b [tcc__r0]
sta.b tcc__r3
ora.b tcc__r2
sta.b tcc__r2
sta.b [tcc__r1]
jmp.w __local_21
__local_18:
lda.w #0
sep #$20
lda.w snesc_timer_enabled + 0
sta -7 + __snesc_vblank_locals + 1,s
rep #$20
stz.b tcc__r0
lda.b tcc__r0
sta -10 + __snesc_vblank_locals + 1,s
__local_23:
lda.w #0
sep #$20
lda -7 + __snesc_vblank_locals + 1,s
rep #$20
and.w #1
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
brl __local_22
+
lda -10 + __snesc_vblank_locals + 1,s
asl a
sta.b tcc__r0
lda.w #:snesc_timers
sta.b tcc__r1h
lda.w #snesc_timers + 0
clc
adc.b tcc__r0
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r0
sta.b tcc__r2
lda.b tcc__r0h
sta.b tcc__r2h
inc.b tcc__r0
lda.b tcc__r0
sta.b [tcc__r1]
lda -10 + __snesc_vblank_locals + 1,s
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
inc.b tcc__r0
lda.b tcc__r0
sta -10 + __snesc_vblank_locals + 1,s
lda.w #0
sep #$20
lda -7 + __snesc_vblank_locals + 1,s
rep #$20
sta.b tcc__r0
cmp #$8000
ror.b tcc__r0
sep #$20
lda.b tcc__r0
sta -7 + __snesc_vblank_locals + 1,s
rep #$20
jmp.w __local_23
__local_22:
.ifgr __snesc_vblank_locals 0
tsa
clc
adc #__snesc_vblank_locals
tas
.endif
rtl
.ends

.section ".text_0x2" superfree

snesc_init:
.ifgr __snesc_init_locals 0
tsa
sec
sbc #__snesc_init_locals
tas
.endif
lda.w #:snesc_vblank
sta.b tcc__r0h
lda.w #snesc_vblank + 0
sta.b tcc__r0
sta.l __nmi_handler + 0
lda.b tcc__r0h
sta.l __nmi_handler + 0 + 2
lda.w #129
sta.b tcc__r0
lda.w #16896
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
stz.b tcc__r0
lda.b tcc__r0
sta.w snesc_controllers + 0
sep #$20
lda.b tcc__r0
sta.w snesc_do_copy + 0
rep #$20
lda.b tcc__r0
and.w #255
and.w #255
sep #$20
sta.w snesc_timer_enabled + 0
rep #$20
stz.b tcc__r0
lda.b tcc__r0
sta -2 + __snesc_init_locals + 1,s
__local_26:
lda -2 + __snesc_init_locals + 1,s
sta.b tcc__r0
ldx #1
sec
sbc.w #128
tay
bvc +
eor #$8000
+
bmi +++
++
dex
+++
stx.b tcc__r5
txa
bne +
brl __local_24
+
bra __local_25
__local_27:
lda -2 + __snesc_init_locals + 1,s
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
inc.b tcc__r0
lda.b tcc__r0
sta -2 + __snesc_init_locals + 1,s
bra __local_26
__local_25:
lda -2 + __snesc_init_locals + 1,s
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_oam_table1
sta.b tcc__r1h
lda.w #snesc_oam_table1 + 0
clc
adc.b tcc__r0
sta.b tcc__r1
lda.w #0
sep #$20
sta.b [tcc__r1]
rep #$20
lda -2 + __snesc_init_locals + 1,s
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_oam_table1
sta.b tcc__r1h
lda.w #snesc_oam_table1 + 0
clc
adc.b tcc__r0
inc a
sta.b tcc__r1
lda.w #232
sep #$20
sta.b [tcc__r1]
rep #$20
lda -2 + __snesc_init_locals + 1,s
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_oam_table1
sta.b tcc__r1h
lda.w #snesc_oam_table1 + 0
clc
adc.b tcc__r0
inc a
inc a
sta.b tcc__r1
lda.w #0
sep #$20
sta.b [tcc__r1]
rep #$20
lda -2 + __snesc_init_locals + 1,s
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_oam_table1
sta.b tcc__r1h
lda.w #snesc_oam_table1 + 0
clc
adc.b tcc__r0
clc
adc.w #3
sta.b tcc__r1
lda.w #0
sta.b tcc__r0
sep #$20
sta.b [tcc__r1]
rep #$20
jmp.w __local_27
__local_24:
stz.b tcc__r0
lda.b tcc__r0
sta -2 + __snesc_init_locals + 1,s
__local_30:
lda -2 + __snesc_init_locals + 1,s
sta.b tcc__r0
ldx #1
sec
sbc.w #32
tay
bvc +
eor #$8000
+
bmi +++
++
dex
+++
stx.b tcc__r5
txa
bne +
brl __local_28
+
bra __local_29
__local_31:
lda -2 + __snesc_init_locals + 1,s
inc a
inc a
sta.b tcc__r0
sta -2 + __snesc_init_locals + 1,s
bra __local_30
__local_29:
lda -2 + __snesc_init_locals + 1,s
asl a
sta.b tcc__r0
lda.w #:snesc_oam_table2
sta.b tcc__r1h
lda.w #snesc_oam_table2 + 0
clc
adc.b tcc__r0
sta.b tcc__r1
stz.b tcc__r0
lda.b tcc__r0
sta.b [tcc__r1]
bra __local_31
__local_28:
.ifgr __snesc_init_locals 0
tsa
clc
adc #__snesc_init_locals
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
snesc_do_copy dsb 1
snesc_timer_enabled dsb 1
snesc_timers dsb 32
snesc_oam_table1 dsb 512
snesc_oam_table2 dsb 32
snesc_palette dsb 512
snesc_controllers dsb 8
snesc_dma_transfers dsb 512
.ends
