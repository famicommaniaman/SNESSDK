REM C -> ASM / S
..\bin\816-tcc.exe -Wall -I../include -o snesc.ps -c snesc.c
..\bin\816-tcc.exe -Wall -I../include -o input.ps -c input.c
..\bin\816-tcc.exe -Wall -I../include -o init.ps -c init.c
..\bin\816-tcc.exe -Wall -I../include -o graph.ps -c graph.c
..\bin\816-tcc.exe -Wall -I../include -o str.ps -c str.c

REM Optimize ASM files
..\bin\816-opt.py snesc.ps > snesc.s
..\bin\816-opt.py input.ps > input.s
..\bin\816-opt.py init.ps > init.s
..\bin\816-opt.py graph.ps > graph.s
..\bin\816-opt.py str.ps > str.s

REM ASM -> OBJ
..\bin\wla-65816.exe -io data.asm data.obj

..\bin\wla-65816.exe -io snesc.s snesc.obj
..\bin\wla-65816.exe -io input.s input.obj
..\bin\wla-65816.exe -io init.s init.obj
..\bin\wla-65816.exe -io graph.s graph.obj
..\bin\wla-65816.exe -io str.s str.obj

REM OBJ -> SMC
..\bin\wlalink.exe -dvSo data.obj snesc.obj input.obj init.obj graph.obj str.obj snesc.smc


