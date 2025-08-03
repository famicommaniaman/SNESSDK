#include <string.h>
#include "snesc.h"

#define OUTLIT(x) (*((char*)0xfffe) = (x))
void write(char* s) {
  while(*s) OUTLIT(*s++);
}

extern unsigned char tiles1[];
extern unsigned char tiles2[];
extern unsigned char bg1map[];
extern unsigned char bg2map[];
extern unsigned char palette[];
extern unsigned char backpal[];

unsigned int blockmap[0x400];
unsigned int backmap[0x400];
unsigned int pal[0x100];
unsigned char blocks[0x64];
int main() {
  snesc_init();
  
  char st5[12]="HELLO,WORLD";
  
  settiles(0, tiles1, 0xF00);
  settiles(1, tiles2, 0x250);
  memcpy(pal, palette, 0x200);

  writestring(st5, blockmap, 0x248, 0x3F6);//248 3F6

  setmap(0, (unsigned char*)blockmap);
  setmap(1, (unsigned char*)backmap);
  setpalette((unsigned char*)pal);

  enablescreen();

label1:
  resettimer();
  
  
  sync(1);
  goto label1;
}
