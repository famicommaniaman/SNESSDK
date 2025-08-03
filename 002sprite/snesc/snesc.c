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
  unsigned int py=0, x=94, y=109;
  signed int px=80;
  char st5[12]="HELLO,WORLD";
  
  settiles(0, tiles1, 0xF00);
  settiles(1, tiles2, 0x250);
  
  //memcpy(blockmap, bg1map, 0x800);
  //memcpy(backmap, bg2map, 0x800);
  memcpy(pal, palette, 0x200);

  writestring(st5, blockmap, 64, 0x3F6);//248 3F6
  writestring2("BAKAYAROU",blockmap,16,20);
  setmap(0, (unsigned char*)blockmap);
  setmap(1, (unsigned char*)backmap);
  setpalette((unsigned char*)pal);

  enablescreen();
  // main sprites
  setsprite(0, x, y, 114, 0x31);
  setsprite(1, x+8, y, 115, 0x31);
  setsprite(2, x, y+8, 116, 0x31);
  setsprite(3, x+8, y+8, 117, 0x31);

  delay(50); 
  while (getjoystatus(0) == 0) continue;
  setmap(0, (unsigned char*)blockmap);
label1:
  resettimer();
  
  
  sync(1);
  goto label1;
}
