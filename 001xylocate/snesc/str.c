void writestring(unsigned char *st, unsigned int *map, unsigned int p, unsigned int offset)
{
  unsigned int sp = p; /* start position */
  unsigned int c;
  while ((c = *st)) {
    if (c == '\n') {
      sp += 0x20;
      p = sp;
    }
    else {
      map[p] = c + offset;
      p++;
    }
    st++;
  }
}
void writestring2(unsigned char *st, unsigned int *map, unsigned int x,unsigned int y)
{
	int adr=y*32+x;
	writestring(st,map,adr,0x3F6);
	//©ìŠÖ”(x,y)‚Åw’è‚·‚é
}
void writenum(unsigned long long num, unsigned char len, unsigned int *map, unsigned int p, unsigned int offset)
{
    unsigned char figure;
    p += len - 1;
    if (!num) {
      map[p] = offset;
    }
    else while (len && num) {
      figure = num % 10;
      if (num || figure) map[p] = figure + offset;
      num /= 10;
      p--;
      len--;
    }
}
