.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __enablescreen_locals 0
.define __screenmode_locals 0
.define __waitforvsync_locals 0
.define __delay_locals 0
.define __setpalette_locals 0
.define __setsprite_locals 4
.define __sync_locals 0
.define __resettimer_locals 0
.define __settiles_locals 8
.define __setmap_locals 4

.section ".text_0x0" superfree

enablescreen:
.ifgr __enablescreen_locals 0
tsa
sec
sbc #__enablescreen_locals
tas
.endif
lda.w #9
sta.b tcc__r0
lda.w #8453
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
lda.w #4
sta.b tcc__r0
lda.w #8457
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
lda.w #1
sta.b tcc__r0
lda.w #8459
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
lda.w #2
sta.b tcc__r0
lda.w #8460
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
lda.w #21
sta.b tcc__r0
lda.w #8492
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
lda.w #128
sta.b tcc__r0
lda.w #8448
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
jsr.l snesc_vblank
lda.w #15
sta.b tcc__r0
lda.w #8448
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
.ifgr __enablescreen_locals 0
tsa
clc
adc #__enablescreen_locals
tas
.endif
rtl
.ends

.section ".text_0x1" superfree

screenmode:
.ifgr __screenmode_locals 0
tsa
sec
sbc #__screenmode_locals
tas
.endif
lda.w #0
sep #$20
lda 3 + __screenmode_locals + 1,s
rep #$20
sta.b tcc__r0
lda.w #8453
sta.b tcc__r9
lda.w #0
sta.b tcc__r9h
sep #$20
lda.b tcc__r0
sta.b [tcc__r9]
rep #$20
.ifgr __screenmode_locals 0
tsa
clc
adc #__screenmode_locals
tas
.endif
rtl
.ends

.section ".text_0x2" superfree

waitforvsync:
.ifgr __waitforvsync_locals 0
tsa
sec
sbc #__waitforvsync_locals
tas
.endif
lda.w #0
sep #$20
lda.l snesc_timer_enabled + 0
rep #$20
ora.w #1
sep #$20
sta.l snesc_timer_enabled + 0
rep #$20
stz.b tcc__r0
lda.b tcc__r0
sta.l snesc_timers + 0
__local_2:
lda.l snesc_timers + 0
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
brl __local_0
+
bra __local_1
__local_0:
bra __local_2
__local_1:
.ifgr __waitforvsync_locals 0
tsa
clc
adc #__waitforvsync_locals
tas
.endif
rtl
.ends

.section ".text_0x3" superfree

delay:
.ifgr __delay_locals 0
tsa
sec
sbc #__delay_locals
tas
.endif
lda.w #0
sep #$20
lda.l snesc_timer_enabled + 0
rep #$20
ora.w #1
sep #$20
sta.l snesc_timer_enabled + 0
rep #$20
stz.b tcc__r0
lda.b tcc__r0
sta.l snesc_timers + 0
__local_4:
lda.l snesc_timers + 0
sta.b tcc__r0
lda 3 + __delay_locals + 1,s
sta.b tcc__r1
ldx #1
lda.b tcc__r0
sec
sbc.b tcc__r1
tay
bcc ++
+ dex
++
stx.b tcc__r5
txa
bne +
brl __local_3
+
bra __local_4
__local_3:
.ifgr __delay_locals 0
tsa
clc
adc #__delay_locals
tas
.endif
rtl
.ends

.section ".text_0x4" superfree

setpalette:
.ifgr __setpalette_locals 0
tsa
sec
sbc #__setpalette_locals
tas
.endif
pea.w 512
lda 5 + __setpalette_locals + 1,s
sta.b tcc__r0
lda 7 + __setpalette_locals + 1,s
pha
pei (tcc__r0)
pea.w :snesc_palette
pea.w snesc_palette + 0
jsr.l memcpy
tsa
clc
adc #10
tas
lda.w #0
sep #$20
lda.l snesc_do_copy + 0
rep #$20
ora.w #64
sta.b tcc__r0
sep #$20
sta.l snesc_do_copy + 0
rep #$20
.ifgr __setpalette_locals 0
tsa
clc
adc #__setpalette_locals
tas
.endif
rtl
.ends

.section ".text_0x5" superfree

setsprite:
.ifgr __setsprite_locals 0
tsa
sec
sbc #__setsprite_locals
tas
.endif
lda 3 + __setsprite_locals + 1,s
asl a
asl a
sta.b tcc__r0
lda.w #:snesc_oam_table1
sta.b tcc__r1h
lda.w #snesc_oam_table1 + 0
clc
adc.b tcc__r0
sta.b tcc__r1
sta -4 + __setsprite_locals + 1,s
lda.b tcc__r1h
sta -2 + __setsprite_locals + 1,s
lda -4 + __setsprite_locals + 1,s
sta.b tcc__r0
lda -2 + __setsprite_locals + 1,s
sta.b tcc__r0h
lda.w #0
sep #$20
lda 5 + __setsprite_locals + 1,s
sta.b [tcc__r0]
rep #$20
lda -2 + __setsprite_locals + 1,s
sta.b tcc__r0h
lda -4 + __setsprite_locals + 1,s
inc a
sta.b tcc__r0
lda.w #0
sep #$20
lda 6 + __setsprite_locals + 1,s
sta.b [tcc__r0]
rep #$20
lda -2 + __setsprite_locals + 1,s
sta.b tcc__r0h
lda -4 + __setsprite_locals + 1,s
inc a
inc a
sta.b tcc__r0
lda.w #0
sep #$20
lda 7 + __setsprite_locals + 1,s
sta.b [tcc__r0]
rep #$20
lda -4 + __setsprite_locals + 1,s
sta.b tcc__r0
lda -2 + __setsprite_locals + 1,s
sta.b tcc__r0h
clc
lda.b tcc__r0
adc.w #3
sta.b tcc__r0
lda.w #0
sep #$20
lda 8 + __setsprite_locals + 1,s
rep #$20
sta.b tcc__r1
sep #$20
sta.b [tcc__r0]
rep #$20
lda.w #0
sep #$20
lda.l snesc_do_copy + 0
rep #$20
ora.w #128
sta.b tcc__r0
sep #$20
sta.l snesc_do_copy + 0
rep #$20
.ifgr __setsprite_locals 0
tsa
clc
adc #__setsprite_locals
tas
.endif
rtl
.ends

.section ".text_0x6" superfree

sync:
.ifgr __sync_locals 0
tsa
sec
sbc #__sync_locals
tas
.endif
__local_6:
lda.l snesc_timers + 0
sta.b tcc__r0
lda 3 + __sync_locals + 1,s
sta.b tcc__r1
ldx #1
lda.b tcc__r0
sec
sbc.b tcc__r1
tay
bcc ++
+ dex
++
stx.b tcc__r5
txa
bne +
brl __local_5
+
bra __local_6
__local_5:
.ifgr __sync_locals 0
tsa
clc
adc #__sync_locals
tas
.endif
rtl
.ends

.section ".text_0x7" superfree

resettimer:
.ifgr __resettimer_locals 0
tsa
sec
sbc #__resettimer_locals
tas
.endif
lda.w #0
sep #$20
lda.l snesc_timer_enabled + 0
rep #$20
ora.w #1
sep #$20
sta.l snesc_timer_enabled + 0
rep #$20
stz.b tcc__r0
lda.b tcc__r0
sta.l snesc_timers + 0
.ifgr __resettimer_locals 0
tsa
clc
adc #__resettimer_locals
tas
.endif
rtl
.ends

.section ".text_0x8" superfree

settiles:
.ifgr __settiles_locals 0
tsa
sec
sbc #__settiles_locals
tas
.endif
lda.w #0
sep #$20
lda.l snesc_do_copy + 0
rep #$20
and.w #63
sta -2 + __settiles_locals + 1,s
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
sta -8 + __settiles_locals + 1,s
lda.b tcc__r1h
sta -6 + __settiles_locals + 1,s
lda -8 + __settiles_locals + 1,s
sta.b tcc__r0
lda -6 + __settiles_locals + 1,s
sta.b tcc__r0h
lda 7 + __settiles_locals + 1,s
sta.b tcc__r1h
lda 5 + __settiles_locals + 1,s
sta.b tcc__r1
ldy #0
sta.b [tcc__r0],y
lda.b tcc__r1h
iny
iny
sta.b [tcc__r0],y
lda -8 + __settiles_locals + 1,s
sta.b tcc__r0
lda -6 + __settiles_locals + 1,s
sta.b tcc__r0h
clc
lda.b tcc__r0
adc.w #3
sta.b tcc__r0
lda.w #0
sep #$20
sta.b [tcc__r0]
rep #$20
lda -8 + __settiles_locals + 1,s
sta.b tcc__r0
lda -6 + __settiles_locals + 1,s
sta.b tcc__r0h
clc
lda.b tcc__r0
adc.w #4
sta.b tcc__r0
lda 3 + __settiles_locals + 1,s
inc a
sta.b tcc__r1
ldy.w #12
-
asl a
dey
bne -
+
sta.b [tcc__r0]
lda -8 + __settiles_locals + 1,s
sta.b tcc__r0
lda -6 + __settiles_locals + 1,s
sta.b tcc__r0h
clc
lda.b tcc__r0
adc.w #6
sta.b tcc__r0
lda 9 + __settiles_locals + 1,s
sta.b [tcc__r0]
lda.w #0
sep #$20
lda.l snesc_do_copy + 0
rep #$20
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
inc.b tcc__r0
sep #$20
lda.b tcc__r0
sta.l snesc_do_copy + 0
rep #$20
.ifgr __settiles_locals 0
tsa
clc
adc #__settiles_locals
tas
.endif
rtl
.ends

.section ".text_0x9" superfree

setmap:
.ifgr __setmap_locals 0
tsa
sec
sbc #__setmap_locals
tas
.endif
lda.w #0
sep #$20
lda.l snesc_do_copy + 0
rep #$20
and.w #63
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
sta -4 + __setmap_locals + 1,s
lda.b tcc__r1h
sta -2 + __setmap_locals + 1,s
lda -4 + __setmap_locals + 1,s
sta.b tcc__r0
lda -2 + __setmap_locals + 1,s
sta.b tcc__r0h
lda 7 + __setmap_locals + 1,s
sta.b tcc__r1h
lda 5 + __setmap_locals + 1,s
sta.b tcc__r1
ldy #0
sta.b [tcc__r0],y
lda.b tcc__r1h
iny
iny
sta.b [tcc__r0],y
lda -4 + __setmap_locals + 1,s
sta.b tcc__r0
lda -2 + __setmap_locals + 1,s
sta.b tcc__r0h
clc
lda.b tcc__r0
adc.w #3
sta.b tcc__r0
lda.w #0
sep #$20
sta.b [tcc__r0]
rep #$20
lda -4 + __setmap_locals + 1,s
sta.b tcc__r0
lda -2 + __setmap_locals + 1,s
sta.b tcc__r0h
clc
lda.b tcc__r0
adc.w #4
sta.b tcc__r0
lda 3 + __setmap_locals + 1,s
sta.b tcc__r1
ldy.w #10
-
asl a
dey
bne -
+
sta.b [tcc__r0]
lda -4 + __setmap_locals + 1,s
sta.b tcc__r0
lda -2 + __setmap_locals + 1,s
sta.b tcc__r0h
clc
lda.b tcc__r0
adc.w #6
sta.b tcc__r0
lda.w #2048
sta.b [tcc__r0]
lda.w #0
sep #$20
lda.l snesc_do_copy + 0
rep #$20
sta.b tcc__r0
sta.b tcc__r1
lda.b tcc__r0h
sta.b tcc__r1h
inc.b tcc__r0
sep #$20
lda.b tcc__r0
sta.l snesc_do_copy + 0
rep #$20
.ifgr __setmap_locals 0
tsa
clc
adc #__setmap_locals
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
