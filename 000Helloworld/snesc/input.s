.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __getjoystatus_locals 0
.define __clearjoy_locals 0

.section ".text_0x0" superfree

getjoystatus:
.ifgr __getjoystatus_locals 0
tsa
sec
sbc #__getjoystatus_locals
tas
.endif
lda 3 + __getjoystatus_locals + 1,s
asl a
sta.b tcc__r0
lda.w #:snesc_controllers
sta.b tcc__r1h
lda.w #snesc_controllers + 0
clc
adc.b tcc__r0
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r0
__local_0:
.ifgr __getjoystatus_locals 0
tsa
clc
adc #__getjoystatus_locals
tas
.endif
rtl
.ends

.section ".text_0x1" superfree

clearjoy:
.ifgr __clearjoy_locals 0
tsa
sec
sbc #__clearjoy_locals
tas
.endif
lda 3 + __clearjoy_locals + 1,s
asl a
sta.b tcc__r0
lda.w #:snesc_controllers
sta.b tcc__r1h
lda.w #snesc_controllers + 0
clc
adc.b tcc__r0
sta.b tcc__r1
stz.b tcc__r0
lda.b tcc__r0
sta.b [tcc__r1]
.ifgr __clearjoy_locals 0
tsa
clc
adc #__clearjoy_locals
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
