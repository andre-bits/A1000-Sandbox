
out/a.elf:     file format elf32-m68k


Disassembly of section .text:

00000000 <_start>:
extern void (*__init_array_start[])() __attribute__((weak));
extern void (*__init_array_end[])() __attribute__((weak));
extern void (*__fini_array_start[])() __attribute__((weak));
extern void (*__fini_array_end[])() __attribute__((weak));

__attribute__((used)) __attribute__((section(".text.unlikely"))) void _start() {
   0:	       movem.l d2-d3/a2,-(sp)
	// initialize globals, ctors etc.
	unsigned long count;
	unsigned long i;

	count = __preinit_array_end - __preinit_array_start;
   4:	       move.l #8504,d3
   a:	       subi.l #8504,d3
  10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	       move.l #8504,d0
  18:	       cmpi.l #8504,d0
  1e:	,----- beq.s 32 <_start+0x32>
  20:	|      lea 2138 <DOSBase>,a2
  26:	|      moveq #0,d2
		__preinit_array_start[i]();
  28:	|  ,-> movea.l (a2)+,a0
  2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  2c:	|  |   addq.l #1,d2
  2e:	|  |   cmp.l d3,d2
  30:	|  '-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
  32:	'----> move.l #8504,d3
  38:	       subi.l #8504,d3
  3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  40:	       move.l #8504,d0
  46:	       cmpi.l #8504,d0
  4c:	,----- beq.s 60 <_start+0x60>
  4e:	|      lea 2138 <DOSBase>,a2
  54:	|      moveq #0,d2
		__init_array_start[i]();
  56:	|  ,-> movea.l (a2)+,a0
  58:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  5a:	|  |   addq.l #1,d2
  5c:	|  |   cmp.l d3,d2
  5e:	|  '-- bcs.s 56 <_start+0x56>

	main();
  60:	'----> jsr 8c <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
  66:	       move.l #8504,d2
  6c:	       subi.l #8504,d2
  72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  74:	,----- beq.s 86 <_start+0x86>
  76:	|      lea 2138 <DOSBase>,a2
		__fini_array_start[i - 1]();
  7c:	|  ,-> subq.l #1,d2
  7e:	|  |   movea.l -(a2),a0
  80:	|  |   jsr (a0)
	for (i = count; i > 0; i--)
  82:	|  |   tst.l d2
  84:	|  '-- bne.s 7c <_start+0x7c>
}
  86:	'----> movem.l (sp)+,d2-d3/a2
  8a:	       rts

0000008c <main>:
struct ExecBase *SysBase;
struct DosLibrary *DOSBase;



int main() {
  8c:	    movem.l d2-d3/a6,-(sp)
	SysBase = *((struct ExecBase**)4UL);
  90:	    movea.l 4 <_start+0x4>,a6
  94:	    move.l a6,213c <SysBase>

	// used for printing
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  9a:	    lea 11c <main+0x90>,a1
  a0:	    moveq #0,d0
  a2:	    jsr -552(a6)
  a6:	    movea.l d0,a6
  a8:	    move.l d0,2138 <DOSBase>
	if (!DOSBase)
  ae:	,-- beq.s e0 <main+0x54>
		Exit(0);

	Write(Output(), (APTR)"Hello console!\n", 15);
  b0:	|   jsr -60(a6)
  b4:	|   movea.l 2138 <DOSBase>,a6
  ba:	|   move.l d0,d1
  bc:	|   move.l #296,d2
  c2:	|   moveq #15,d3
  c4:	|   jsr -48(a6)

	CloseLibrary((struct Library*)DOSBase);
  c8:	|   movea.l 213c <SysBase>,a6
  ce:	|   movea.l 2138 <DOSBase>,a1
  d4:	|   jsr -414(a6)
}
  d8:	|   moveq #0,d0
  da:	|   movem.l (sp)+,d2-d3/a6
  de:	|   rts
		Exit(0);
  e0:	'-> moveq #0,d1
  e2:	    jsr -144(a6)
	Write(Output(), (APTR)"Hello console!\n", 15);
  e6:	    movea.l 2138 <DOSBase>,a6
  ec:	    jsr -60(a6)
  f0:	    movea.l 2138 <DOSBase>,a6
  f6:	    move.l d0,d1
  f8:	    move.l #296,d2
  fe:	    moveq #15,d3
 100:	    jsr -48(a6)
	CloseLibrary((struct Library*)DOSBase);
 104:	    movea.l 213c <SysBase>,a6
 10a:	    movea.l 2138 <DOSBase>,a1
 110:	    jsr -414(a6)
}
 114:	    moveq #0,d0
 116:	    movem.l (sp)+,d2-d3/a6
 11a:	    rts
