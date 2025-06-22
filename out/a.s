
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
       4:	       move.l #20788,d3
       a:	       subi.l #20788,d3
      10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	       move.l #20788,d0
      18:	       cmpi.l #20788,d0
      1e:	,----- beq.s 32 <_start+0x32>
      20:	|      lea 5134 <incbin_image_start>,a2
      26:	|      moveq #0,d2
		__preinit_array_start[i]();
      28:	|  ,-> movea.l (a2)+,a0
      2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
      2c:	|  |   addq.l #1,d2
      2e:	|  |   cmp.l d3,d2
      30:	|  '-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
      32:	'----> move.l #20788,d3
      38:	       subi.l #20788,d3
      3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
      40:	       move.l #20788,d0
      46:	       cmpi.l #20788,d0
      4c:	,----- beq.s 60 <_start+0x60>
      4e:	|      lea 5134 <incbin_image_start>,a2
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
      66:	       move.l #20788,d2
      6c:	       subi.l #20788,d2
      72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
      74:	,----- beq.s 86 <_start+0x86>
      76:	|      lea 5134 <incbin_image_start>,a2
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
static void Wait10() { WaitLine(0x10); }
static void Wait11() { WaitLine(0x11); }
static void Wait12() { WaitLine(0x12); }
static void Wait13() { WaitLine(0x13); }

int main() {
      8c:	                                                          link.w a5,#-52
      90:	                                                          movem.l d2-d7/a2-a4/a6,-(sp)
	SysBase = *((struct ExecBase**)4UL);
      94:	                                                          movea.l 4 <_start+0x4>,a6
      98:	                                                          move.l a6,13ccc <SysBase>
	custom = (struct Custom*)0xdff000;
      9e:	                                                          move.l #14675968,13cd6 <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR)"graphics.library",0);
      a8:	                                                          lea 2f66 <incbin_player_end+0xd4>,a1
      ae:	                                                          moveq #0,d0
      b0:	                                                          jsr -552(a6)
      b4:	                                                          move.l d0,13cc8 <GfxBase>
	if (!GfxBase)
      ba:	      ,-------------------------------------------------- beq.w c56 <main+0xbca>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
      be:	      |                                                   movea.l 13ccc <SysBase>,a6
      c4:	      |                                                   lea 2f77 <incbin_player_end+0xe5>,a1
      ca:	      |                                                   moveq #0,d0
      cc:	      |                                                   jsr -552(a6)
      d0:	      |                                                   move.l d0,13cc4 <DOSBase>
	if (!DOSBase)
      d6:	,-----|-------------------------------------------------- beq.w be2 <main+0xb56>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      da:	|  ,--|-------------------------------------------------> pea 2f83 <incbin_player_end+0xf1>
      e0:	|  |  |                                                   jsr f88 <KPrintF>
#endif
	Write(Output(), (APTR)"Hello console!\n", 15);
      e6:	|  |  |                                                   movea.l 13cc4 <DOSBase>,a6
      ec:	|  |  |                                                   jsr -60(a6)
      f0:	|  |  |                                                   movea.l 13cc4 <DOSBase>,a6
      f6:	|  |  |                                                   move.l d0,d1
      f8:	|  |  |                                                   move.l #12191,d2
      fe:	|  |  |                                                   moveq #15,d3
     100:	|  |  |                                                   jsr -48(a6)
	Delay(2000);
     104:	|  |  |                                                   movea.l 13cc4 <DOSBase>,a6
     10a:	|  |  |                                                   move.l #2000,d1
     110:	|  |  |                                                   jsr -198(a6)

	warpmode(1);
     114:	|  |  |                                                   pea 1 <_start+0x1>
     118:	|  |  |                                                   lea ffa <warpmode>,a4
     11e:	|  |  |                                                   jsr (a4)
		register volatile const void* _a0 ASM("a0") = module;
     120:	|  |  |                                                   lea 12838 <incbin_module_start>,a0
		register volatile const void* _a1 ASM("a1") = NULL;
     126:	|  |  |                                                   suba.l a1,a1
		register volatile const void* _a2 ASM("a2") = NULL;
     128:	|  |  |                                                   suba.l a2,a2
		register volatile const void* _a3 ASM("a3") = player;
     12a:	|  |  |                                                   lea 152c <incbin_player_start>,a3
		__asm volatile (
     130:	|  |  |                                                   movem.l d1-d7/a4-a6,-(sp)
     134:	|  |  |                                                   jsr (a3)
     136:	|  |  |                                                   movem.l (sp)+,d1-d7/a4-a6
	// TODO: precalc stuff here
#ifdef MUSIC
	if(p61Init(module) != 0)
     13a:	|  |  |                                                   addq.l #8,sp
     13c:	|  |  |                                                   tst.l d0
     13e:	|  |  |  ,----------------------------------------------- bne.w b32 <main+0xaa6>
		KPrintF("p61Init failed!\n");
#endif
	warpmode(0);
     142:	|  |  |  |  ,-------------------------------------------> clr.l -(sp)
     144:	|  |  |  |  |                                             jsr (a4)
	Forbid();
     146:	|  |  |  |  |                                             movea.l 13ccc <SysBase>,a6
     14c:	|  |  |  |  |                                             jsr -132(a6)
	SystemADKCON=custom->adkconr;
     150:	|  |  |  |  |                                             movea.l 13cd6 <custom>,a0
     156:	|  |  |  |  |                                             move.w 16(a0),d0
     15a:	|  |  |  |  |                                             move.w d0,13cb6 <SystemADKCON>
	SystemInts=custom->intenar;
     160:	|  |  |  |  |                                             move.w 28(a0),d0
     164:	|  |  |  |  |                                             move.w d0,13cba <SystemInts>
	SystemDMA=custom->dmaconr;
     16a:	|  |  |  |  |                                             move.w 2(a0),d0
     16e:	|  |  |  |  |                                             move.w d0,13cb8 <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
     174:	|  |  |  |  |                                             movea.l 13cc8 <GfxBase>,a6
     17a:	|  |  |  |  |                                             move.l 34(a6),13cb2 <ActiView>
	LoadView(0);
     182:	|  |  |  |  |                                             suba.l a1,a1
     184:	|  |  |  |  |                                             jsr -222(a6)
	WaitTOF();
     188:	|  |  |  |  |                                             movea.l 13cc8 <GfxBase>,a6
     18e:	|  |  |  |  |                                             jsr -270(a6)
	WaitTOF();
     192:	|  |  |  |  |                                             movea.l 13cc8 <GfxBase>,a6
     198:	|  |  |  |  |                                             jsr -270(a6)
	WaitVbl();
     19c:	|  |  |  |  |                                             lea ece <WaitVbl>,a2
     1a2:	|  |  |  |  |                                             jsr (a2)
	WaitVbl();
     1a4:	|  |  |  |  |                                             jsr (a2)
	OwnBlitter();
     1a6:	|  |  |  |  |                                             movea.l 13cc8 <GfxBase>,a6
     1ac:	|  |  |  |  |                                             jsr -456(a6)
	WaitBlit();	
     1b0:	|  |  |  |  |                                             movea.l 13cc8 <GfxBase>,a6
     1b6:	|  |  |  |  |                                             jsr -228(a6)
	Disable();
     1ba:	|  |  |  |  |                                             movea.l 13ccc <SysBase>,a6
     1c0:	|  |  |  |  |                                             jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
     1c4:	|  |  |  |  |                                             movea.l 13cd6 <custom>,a0
     1ca:	|  |  |  |  |                                             move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
     1d0:	|  |  |  |  |                                             move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
     1d6:	|  |  |  |  |                                             move.w #32767,150(a0)
     1dc:	|  |  |  |  |                                             addq.l #4,sp
	for(int a=0;a<32;a++)
     1de:	|  |  |  |  |                                             moveq #0,d1
		custom->color[a]=0;
     1e0:	|  |  |  |  |        ,----------------------------------> move.l d1,d0
     1e2:	|  |  |  |  |        |                                    addi.l #192,d0
     1e8:	|  |  |  |  |        |                                    add.l d0,d0
     1ea:	|  |  |  |  |        |                                    move.w #0,(0,a0,d0.l)
	for(int a=0;a<32;a++)
     1f0:	|  |  |  |  |        |                                    addq.l #1,d1
     1f2:	|  |  |  |  |        |                                    moveq #32,d0
     1f4:	|  |  |  |  |        |                                    cmp.l d1,d0
     1f6:	|  |  |  |  |        +----------------------------------- bne.s 1e0 <main+0x154>
	WaitVbl();
     1f8:	|  |  |  |  |        |                                    jsr (a2)
	WaitVbl();
     1fa:	|  |  |  |  |        |                                    jsr (a2)
	UWORD getvbr[] = { 0x4e7a, 0x0801, 0x4e73 }; // MOVEC.L VBR,D0 RTE
     1fc:	|  |  |  |  |        |                                    move.w #20090,-50(a5)
     202:	|  |  |  |  |        |                                    move.w #2049,-48(a5)
     208:	|  |  |  |  |        |                                    move.w #20083,-46(a5)
	if (SysBase->AttnFlags & AFF_68010) 
     20e:	|  |  |  |  |        |                                    movea.l 13ccc <SysBase>,a6
     214:	|  |  |  |  |        |                                    btst #0,297(a6)
     21a:	|  |  |  |  |  ,-----|----------------------------------- beq.w c82 <main+0xbf6>
		vbr = (APTR)Supervisor((ULONG (*)())getvbr);
     21e:	|  |  |  |  |  |     |                                    moveq #-50,d7
     220:	|  |  |  |  |  |     |                                    add.l a5,d7
     222:	|  |  |  |  |  |     |                                    exg d7,a5
     224:	|  |  |  |  |  |     |                                    jsr -30(a6)
     228:	|  |  |  |  |  |     |                                    exg d7,a5
	VBR=GetVBR();
     22a:	|  |  |  |  |  |     |                                    move.l d0,13cc0 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
     230:	|  |  |  |  |  |     |                                    movea.l 13cc0 <VBR>,a0
     236:	|  |  |  |  |  |     |                                    move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
     23a:	|  |  |  |  |  |     |                                    move.l d0,13cbc <SystemIrq>

	TakeSystem();
	WaitVbl();
     240:	|  |  |  |  |  |     |                                    jsr (a2)

	char* test = (char*)AllocMem(2502, MEMF_ANY);
     242:	|  |  |  |  |  |     |                                    movea.l 13ccc <SysBase>,a6
     248:	|  |  |  |  |  |     |                                    move.l #2502,d0
     24e:	|  |  |  |  |  |     |                                    moveq #0,d1
     250:	|  |  |  |  |  |     |                                    jsr -198(a6)
     254:	|  |  |  |  |  |     |                                    move.l d0,d4
	memset(test, 0xcd, 2502);
     256:	|  |  |  |  |  |     |                                    pea 9c6 <main+0x93a>
     25a:	|  |  |  |  |  |     |                                    pea cd <main+0x41>
     25e:	|  |  |  |  |  |     |                                    move.l d0,-(sp)
     260:	|  |  |  |  |  |     |                                    jsr 12c0 <memset>
	memclr(test + 2, 2502 - 4);
     266:	|  |  |  |  |  |     |                                    movea.l d4,a0
     268:	|  |  |  |  |  |     |                                    addq.l #2,a0
	__asm volatile (
     26a:	|  |  |  |  |  |     |                                    move.l #2498,d5
     270:	|  |  |  |  |  |     |                                    adda.l d5,a0
     272:	|  |  |  |  |  |     |                                    moveq #0,d0
     274:	|  |  |  |  |  |     |                                    moveq #0,d1
     276:	|  |  |  |  |  |     |                                    moveq #0,d2
     278:	|  |  |  |  |  |     |                                    moveq #0,d3
     27a:	|  |  |  |  |  |     |                                    cmpi.l #256,d5
     280:	|  |  |  |  |  |     |                             ,----- blt.w 2d4 <main+0x248>
     284:	|  |  |  |  |  |     |                             |  ,-> movem.l d0-d3,-(a0)
     288:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     28c:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     290:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     294:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     298:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     29c:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2a0:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2a4:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2a8:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2ac:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2b0:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2b4:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2b8:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2bc:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2c0:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2c4:	|  |  |  |  |  |     |                             |  |   subi.l #256,d5
     2ca:	|  |  |  |  |  |     |                             |  |   cmpi.l #256,d5
     2d0:	|  |  |  |  |  |     |                             |  '-- bge.w 284 <main+0x1f8>
     2d4:	|  |  |  |  |  |     |                             >----> cmpi.w #64,d5
     2d8:	|  |  |  |  |  |     |                             |  ,-- blt.w 2f4 <main+0x268>
     2dc:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2e0:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2e4:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2e8:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2ec:	|  |  |  |  |  |     |                             |  |   subi.w #64,d5
     2f0:	|  |  |  |  |  |     |                             '--|-- bra.w 2d4 <main+0x248>
     2f4:	|  |  |  |  |  |     |                                '-> lsr.w #2,d5
     2f6:	|  |  |  |  |  |     |                                ,-- bcc.w 2fc <main+0x270>
     2fa:	|  |  |  |  |  |     |                                |   move.w d0,-(a0)
     2fc:	|  |  |  |  |  |     |                                '-> moveq #16,d1
     2fe:	|  |  |  |  |  |     |                                    sub.w d5,d1
     300:	|  |  |  |  |  |     |                                    add.w d1,d1
     302:	|  |  |  |  |  |     |                                    jmp (306 <main+0x27a>,pc,d1.w)
     306:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     308:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     30a:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     30c:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     30e:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     310:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     312:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     314:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     316:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     318:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     31a:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     31c:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     31e:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     320:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     322:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     324:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
	FreeMem(test, 2502);
     326:	|  |  |  |  |  |     |                                    movea.l 13ccc <SysBase>,a6
     32c:	|  |  |  |  |  |     |                                    movea.l d4,a1
     32e:	|  |  |  |  |  |     |                                    move.l #2502,d0
     334:	|  |  |  |  |  |     |                                    jsr -210(a6)

	USHORT* copper1 = (USHORT*)AllocMem(1024, MEMF_CHIP);
     338:	|  |  |  |  |  |     |                                    movea.l 13ccc <SysBase>,a6
     33e:	|  |  |  |  |  |     |                                    move.l #1024,d0
     344:	|  |  |  |  |  |     |                                    moveq #2,d1
     346:	|  |  |  |  |  |     |                                    jsr -198(a6)
     34a:	|  |  |  |  |  |     |                                    movea.l d0,a3
	USHORT* copPtr = copper1;

	// register graphics resources with WinUAE for nicer gfx debugger experience
	debug_register_bitmap(image, "image.bpl", 320, 256, 5, debug_resource_bitmap_interleaved);
     34c:	|  |  |  |  |  |     |                                    pea 1 <_start+0x1>
     350:	|  |  |  |  |  |     |                                    pea 100 <main+0x74>
     354:	|  |  |  |  |  |     |                                    pea 140 <main+0xb4>
     358:	|  |  |  |  |  |     |                                    pea 2fc0 <incbin_player_end+0x12e>
     35e:	|  |  |  |  |  |     |                                    pea 5134 <incbin_image_start>
     364:	|  |  |  |  |  |     |                                    lea 1156 <debug_register_bitmap.constprop.0>,a4
     36a:	|  |  |  |  |  |     |                                    jsr (a4)
	debug_register_bitmap(bob, "bob.bpl", 32, 96, 5, debug_resource_bitmap_interleaved | debug_resource_bitmap_masked);
     36c:	|  |  |  |  |  |     |                                    lea 32(sp),sp
     370:	|  |  |  |  |  |     |                                    pea 3 <_start+0x3>
     374:	|  |  |  |  |  |     |                                    pea 60 <_start+0x60>
     378:	|  |  |  |  |  |     |                                    pea 20 <_start+0x20>
     37c:	|  |  |  |  |  |     |                                    pea 2fca <incbin_player_end+0x138>
     382:	|  |  |  |  |  |     |                                    pea 11936 <incbin_bob_start>
     388:	|  |  |  |  |  |     |                                    jsr (a4)
	my_strncpy(resource.name, name, sizeof(resource.name));
	debug_cmd(barto_cmd_register_resource, (unsigned int)&resource, 0, 0);
}

void debug_register_palette(const void* addr, const char* name, short numEntries, unsigned short flags) {
	struct debug_resource resource = {
     38a:	|  |  |  |  |  |     |                                    clr.l -42(a5)
     38e:	|  |  |  |  |  |     |                                    clr.l -38(a5)
     392:	|  |  |  |  |  |     |                                    clr.l -34(a5)
     396:	|  |  |  |  |  |     |                                    clr.l -30(a5)
     39a:	|  |  |  |  |  |     |                                    clr.l -26(a5)
     39e:	|  |  |  |  |  |     |                                    clr.l -22(a5)
     3a2:	|  |  |  |  |  |     |                                    clr.l -18(a5)
     3a6:	|  |  |  |  |  |     |                                    clr.l -14(a5)
     3aa:	|  |  |  |  |  |     |                                    clr.l -10(a5)
     3ae:	|  |  |  |  |  |     |                                    clr.l -6(a5)
     3b2:	|  |  |  |  |  |     |                                    clr.w -2(a5)
		.address = (unsigned int)addr,
     3b6:	|  |  |  |  |  |     |                                    move.l #5354,d3
	struct debug_resource resource = {
     3bc:	|  |  |  |  |  |     |                                    move.l d3,-50(a5)
     3c0:	|  |  |  |  |  |     |                                    moveq #64,d1
     3c2:	|  |  |  |  |  |     |                                    move.l d1,-46(a5)
     3c6:	|  |  |  |  |  |     |                                    move.w #1,-10(a5)
     3cc:	|  |  |  |  |  |     |                                    move.w #32,-6(a5)
     3d2:	|  |  |  |  |  |     |                                    lea 20(sp),sp
	while(*source && --num > 0)
     3d6:	|  |  |  |  |  |     |                                    moveq #105,d0
	struct debug_resource resource = {
     3d8:	|  |  |  |  |  |     |                                    lea -42(a5),a1
     3dc:	|  |  |  |  |  |     |                                    lea 2f5c <incbin_player_end+0xca>,a0
		*destination++ = *source++;
     3e2:	|  |  |  |  |  |  ,--|----------------------------------> addq.l #1,a0
     3e4:	|  |  |  |  |  |  |  |                                    move.b d0,(a1)+
	while(*source && --num > 0)
     3e6:	|  |  |  |  |  |  |  |                                    move.b (a0),d0
     3e8:	|  |  |  |  |  |  |  |                                ,-- beq.s 3f2 <main+0x366>
     3ea:	|  |  |  |  |  |  |  |                                |   cmpa.l #12155,a0
     3f0:	|  |  |  |  |  |  +--|--------------------------------|-- bne.s 3e2 <main+0x356>
	*destination = '\0';
     3f2:	|  |  |  |  |  |  |  |                                '-> clr.b (a1)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     3f4:	|  |  |  |  |  |  |  |                                    move.w f0ff60 <_end+0xefc284>,d0
     3fa:	|  |  |  |  |  |  |  |                                    cmpi.w #20153,d0
     3fe:	|  |  |  |  |  |  |  |     ,----------------------------- beq.w 9c6 <main+0x93a>
     402:	|  |  |  |  |  |  |  |     |                              cmpi.w #-24562,d0
     406:	|  |  |  |  |  |  |  |     +----------------------------- beq.w 9c6 <main+0x93a>
	debug_register_palette(colors, "image.pal", 32, 0);
	debug_register_copperlist(copper1, "copper1", 1024, 0);
     40a:	|  |  |  |  |  |  |  |     |                              pea 400 <main+0x374>
     40e:	|  |  |  |  |  |  |  |     |                              pea 2fd2 <incbin_player_end+0x140>
     414:	|  |  |  |  |  |  |  |     |                              move.l a3,-(sp)
     416:	|  |  |  |  |  |  |  |     |                              lea 1226 <debug_register_copperlist.constprop.0>,a4
     41c:	|  |  |  |  |  |  |  |     |                              jsr (a4)
	debug_register_copperlist(copper2, "copper2", sizeof(copper2), 0);
     41e:	|  |  |  |  |  |  |  |     |                              pea 80 <_start+0x80>
     422:	|  |  |  |  |  |  |  |     |                              pea 2fda <incbin_player_end+0x148>
     428:	|  |  |  |  |  |  |  |     |                              pea 30b4 <copper2>
     42e:	|  |  |  |  |  |  |  |     |                              jsr (a4)
	*copListEnd++ = offsetof(struct Custom, ddfstrt);
     430:	|  |  |  |  |  |  |  |     |                              move.w #146,(a3)
	*copListEnd++ = fw;
     434:	|  |  |  |  |  |  |  |     |                              move.w #56,2(a3)
	*copListEnd++ = offsetof(struct Custom, ddfstop);
     43a:	|  |  |  |  |  |  |  |     |                              move.w #148,4(a3)
	*copListEnd++ = fw+(((width>>4)-1)<<3);
     440:	|  |  |  |  |  |  |  |     |                              move.w #208,6(a3)
	*copListEnd++ = offsetof(struct Custom, diwstrt);
     446:	|  |  |  |  |  |  |  |     |                              move.w #142,8(a3)
	*copListEnd++ = x+(y<<8);
     44c:	|  |  |  |  |  |  |  |     |                              move.w #11393,10(a3)
	*copListEnd++ = offsetof(struct Custom, diwstop);
     452:	|  |  |  |  |  |  |  |     |                              move.w #144,12(a3)
	*copListEnd++ = (xstop-256)+((ystop-256)<<8);
     458:	|  |  |  |  |  |  |  |     |                              move.w #11457,14(a3)

	copPtr = screenScanDefault(copPtr);
	//enable bitplanes	
	*copPtr++ = offsetof(struct Custom, bplcon0);
     45e:	|  |  |  |  |  |  |  |     |                              move.w #256,16(a3)
	*copPtr++ = (0<<10)/*dual pf*/|(1<<9)/*color*/|((5)<<12)/*num bitplanes*/;
     464:	|  |  |  |  |  |  |  |     |                              move.w #20992,18(a3)
	*copPtr++ = offsetof(struct Custom, bplcon1);	//scrolling
     46a:	|  |  |  |  |  |  |  |     |                              move.w #258,20(a3)
     470:	|  |  |  |  |  |  |  |     |                              lea 22(a3),a0
     474:	|  |  |  |  |  |  |  |     |                              move.l a0,13cd2 <scroll>
	scroll = copPtr;
	*copPtr++ = 0;
     47a:	|  |  |  |  |  |  |  |     |                              clr.w 22(a3)
	*copPtr++ = offsetof(struct Custom, bplcon2);	//playfied priority
     47e:	|  |  |  |  |  |  |  |     |                              move.w #260,24(a3)
	*copPtr++ = 1<<6;//0x24;			//Sprites have priority over playfields
     484:	|  |  |  |  |  |  |  |     |                              move.w #64,26(a3)

	const USHORT lineSize=320/8;

	//set bitplane modulo
	*copPtr++=offsetof(struct Custom, bpl1mod); //odd planes   1,3,5
     48a:	|  |  |  |  |  |  |  |     |                              move.w #264,28(a3)
	*copPtr++=4*lineSize;
     490:	|  |  |  |  |  |  |  |     |                              move.w #160,30(a3)
	*copPtr++=offsetof(struct Custom, bpl2mod); //even  planes 2,4
     496:	|  |  |  |  |  |  |  |     |                              move.w #266,32(a3)
	*copPtr++=4*lineSize;
     49c:	|  |  |  |  |  |  |  |     |                              move.w #160,34(a3)
		ULONG addr=(ULONG)planes[i];
     4a2:	|  |  |  |  |  |  |  |     |                              move.l #20788,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     4a8:	|  |  |  |  |  |  |  |     |                              move.w #224,36(a3)
		*copListEnd++=(UWORD)(addr>>16);
     4ae:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     4b0:	|  |  |  |  |  |  |  |     |                              clr.w d1
     4b2:	|  |  |  |  |  |  |  |     |                              swap d1
     4b4:	|  |  |  |  |  |  |  |     |                              move.w d1,38(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     4b8:	|  |  |  |  |  |  |  |     |                              move.w #226,40(a3)
		*copListEnd++=(UWORD)addr;
     4be:	|  |  |  |  |  |  |  |     |                              move.w d0,42(a3)
		ULONG addr=(ULONG)planes[i];
     4c2:	|  |  |  |  |  |  |  |     |                              move.l #20828,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     4c8:	|  |  |  |  |  |  |  |     |                              move.w #228,44(a3)
		*copListEnd++=(UWORD)(addr>>16);
     4ce:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     4d0:	|  |  |  |  |  |  |  |     |                              clr.w d1
     4d2:	|  |  |  |  |  |  |  |     |                              swap d1
     4d4:	|  |  |  |  |  |  |  |     |                              move.w d1,46(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     4d8:	|  |  |  |  |  |  |  |     |                              move.w #230,48(a3)
		*copListEnd++=(UWORD)addr;
     4de:	|  |  |  |  |  |  |  |     |                              move.w d0,50(a3)
		ULONG addr=(ULONG)planes[i];
     4e2:	|  |  |  |  |  |  |  |     |                              move.l #20868,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     4e8:	|  |  |  |  |  |  |  |     |                              move.w #232,52(a3)
		*copListEnd++=(UWORD)(addr>>16);
     4ee:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     4f0:	|  |  |  |  |  |  |  |     |                              clr.w d1
     4f2:	|  |  |  |  |  |  |  |     |                              swap d1
     4f4:	|  |  |  |  |  |  |  |     |                              move.w d1,54(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     4f8:	|  |  |  |  |  |  |  |     |                              move.w #234,56(a3)
		*copListEnd++=(UWORD)addr;
     4fe:	|  |  |  |  |  |  |  |     |                              move.w d0,58(a3)
		ULONG addr=(ULONG)planes[i];
     502:	|  |  |  |  |  |  |  |     |                              move.l #20908,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     508:	|  |  |  |  |  |  |  |     |                              move.w #236,60(a3)
		*copListEnd++=(UWORD)(addr>>16);
     50e:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     510:	|  |  |  |  |  |  |  |     |                              clr.w d1
     512:	|  |  |  |  |  |  |  |     |                              swap d1
     514:	|  |  |  |  |  |  |  |     |                              move.w d1,62(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     518:	|  |  |  |  |  |  |  |     |                              move.w #238,64(a3)
		*copListEnd++=(UWORD)addr;
     51e:	|  |  |  |  |  |  |  |     |                              move.w d0,66(a3)
		ULONG addr=(ULONG)planes[i];
     522:	|  |  |  |  |  |  |  |     |                              move.l #20948,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     528:	|  |  |  |  |  |  |  |     |                              move.w #240,68(a3)
		*copListEnd++=(UWORD)(addr>>16);
     52e:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     530:	|  |  |  |  |  |  |  |     |                              clr.w d1
     532:	|  |  |  |  |  |  |  |     |                              swap d1
     534:	|  |  |  |  |  |  |  |     |                              move.w d1,70(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     538:	|  |  |  |  |  |  |  |     |                              move.w #242,72(a3)
		*copListEnd++=(UWORD)addr;
     53e:	|  |  |  |  |  |  |  |     |                              move.w d0,74(a3)
	for (USHORT i=0;i<numPlanes;i++) {
     542:	|  |  |  |  |  |  |  |     |                              lea 76(a3),a1
     546:	|  |  |  |  |  |  |  |     |                              move.l #5418,d2
     54c:	|  |  |  |  |  |  |  |     |                              lea 24(sp),sp
		*copListEnd++=(UWORD)addr;
     550:	|  |  |  |  |  |  |  |     |                              lea 14ea <incbin_colors_start>,a0
     556:	|  |  |  |  |  |  |  |     |                              move.w #382,d0
     55a:	|  |  |  |  |  |  |  |     |                              sub.w d3,d0
		planes[a]=(UBYTE*)image + lineSize * a;
	copPtr = copSetPlanes(0, copPtr, planes, 5);

	// set colors
	for(int a=0; a < 32; a++)
		copPtr = copSetColor(copPtr, a, ((USHORT*)colors)[a]);
     55c:	|  |  |  |  |  |  |  |  ,--|----------------------------> move.w (a0)+,d1
	*copListCurrent++=offsetof(struct Custom, color) + sizeof(UWORD) * index;
     55e:	|  |  |  |  |  |  |  |  |  |                              movea.w d0,a6
     560:	|  |  |  |  |  |  |  |  |  |                              adda.w a0,a6
     562:	|  |  |  |  |  |  |  |  |  |                              move.w a6,(a1)
	*copListCurrent++=color;
     564:	|  |  |  |  |  |  |  |  |  |                              addq.l #4,a1
     566:	|  |  |  |  |  |  |  |  |  |                              move.w d1,-2(a1)
	for(int a=0; a < 32; a++)
     56a:	|  |  |  |  |  |  |  |  |  |                              cmpa.l d2,a0
     56c:	|  |  |  |  |  |  |  |  +--|----------------------------- bne.s 55c <main+0x4d0>

	// jump to copper2
	*copPtr++ = offsetof(struct Custom, copjmp2);
     56e:	|  |  |  |  |  |  |  |  |  |                              move.w #138,204(a3)
	*copPtr++ = 0x7fff;
     574:	|  |  |  |  |  |  |  |  |  |                              move.w #32767,206(a3)

	custom->cop1lc = (ULONG)copper1;
     57a:	|  |  |  |  |  |  |  |  |  |                              movea.l 13cd6 <custom>,a0
     580:	|  |  |  |  |  |  |  |  |  |                              move.l a3,128(a0)
	custom->cop2lc = (ULONG)copper2;
     584:	|  |  |  |  |  |  |  |  |  |                              move.l #12468,132(a0)
	custom->dmacon = DMAF_BLITTER;//disable blitter dma for copjmp bug
     58c:	|  |  |  |  |  |  |  |  |  |                              move.w #64,150(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     592:	|  |  |  |  |  |  |  |  |  |                              move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER;
     598:	|  |  |  |  |  |  |  |  |  |                              move.w #-31808,150(a0)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
     59e:	|  |  |  |  |  |  |  |  |  |                              movea.l 13cc0 <VBR>,a1
     5a4:	|  |  |  |  |  |  |  |  |  |                              move.l #3648,108(a1)

	// DEMO
	SetInterruptHandler((APTR)interruptHandler);
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
     5ac:	|  |  |  |  |  |  |  |  |  |                              move.w #-16352,154(a0)
#ifdef MUSIC
	custom->intena = INTF_SETCLR | INTF_EXTER; // ThePlayer needs INTF_EXTER
     5b2:	|  |  |  |  |  |  |  |  |  |                              move.w #-24576,154(a0)
#endif

	custom->intreq=(1<<INTB_VERTB);//reset vbl req
     5b8:	|  |  |  |  |  |  |  |  |  |                              move.w #32,156(a0)
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
     5be:	|  |  |  |  |  |  |  |  |  |                              move.b bfe001 <_end+0xbea325>,d0

	while(!MouseLeft()) {
     5c4:	|  |  |  |  |  |  |  |  |  |                              btst #6,d0
     5c8:	|  |  |  |  |  |  |  |  |  |  ,-------------------------- beq.w 748 <main+0x6bc>
     5cc:	|  |  |  |  |  |  |  |  |  |  |                           lea 14aa <__umodsi3>,a4
     5d2:	|  |  |  |  |  |  |  |  |  |  |                           lea 3001 <sinus40>,a3
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     5d8:	|  |  |  |  |  |  |  |  |  |  |  ,----------------------> move.l dff004 <_end+0xdeb328>,d0
     5de:	|  |  |  |  |  |  |  |  |  |  |  |                        move.l d0,-50(a5)
		if(((vpos >> 8) & 511) == line)
     5e2:	|  |  |  |  |  |  |  |  |  |  |  |                        move.l -50(a5),d0
     5e6:	|  |  |  |  |  |  |  |  |  |  |  |                        andi.l #130816,d0
     5ec:	|  |  |  |  |  |  |  |  |  |  |  |                        cmpi.l #4096,d0
     5f2:	|  |  |  |  |  |  |  |  |  |  |  +----------------------- bne.s 5d8 <main+0x54c>
		Wait10();
		int f = frameCounter & 255;
     5f4:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w 13cd0 <frameCounter>,d7

		// clear
		WaitBlit();
     5fa:	|  |  |  |  |  |  |  |  |  |  |  |                        movea.l 13cc8 <GfxBase>,a6
     600:	|  |  |  |  |  |  |  |  |  |  |  |                        jsr -228(a6)
		custom->bltcon0 = A_TO_D | DEST;
     604:	|  |  |  |  |  |  |  |  |  |  |  |                        movea.l 13cd6 <custom>,a0
     60a:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #496,64(a0)
		custom->bltcon1 = 0;
     610:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #0,66(a0)
		custom->bltadat = 0;
     616:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #0,116(a0)
		custom->bltdpt = (UBYTE*)image + 320 / 8 * 200 * 5;
     61c:	|  |  |  |  |  |  |  |  |  |  |  |                        move.l #60788,84(a0)
		custom->bltdmod = 0;
     624:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #0,102(a0)
		custom->bltafwm = custom->bltalwm = 0xffff;
     62a:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #-1,70(a0)
     630:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #-1,68(a0)
		custom->bltsize = ((56 * 5) << HSIZEBITS) | (320/16);
     636:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #17940,88(a0)
     63c:	|  |  |  |  |  |  |  |  |  |  |  |                        moveq #0,d6
     63e:	|  |  |  |  |  |  |  |  |  |  |  |                        moveq #0,d5

		// blit
		for(short i = 0; i < 16; i++) {
			const short x = i * 16 + sinus32[(frameCounter + i) % sizeof(sinus32)] * 2;
     640:	|  |  |  |  |  |  |  |  |  |  |  |                    ,-> movea.w 13cd0 <frameCounter>,a0
     646:	|  |  |  |  |  |  |  |  |  |  |  |                    |   pea 33 <_start+0x33>
     64a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.w a0,a6
     64c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   pea (0,a6,d5.l)
     650:	|  |  |  |  |  |  |  |  |  |  |  |                    |   jsr (a4)
     652:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #8,sp
     654:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lea 3041 <sinus32>,a0
     65a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #0,d3
     65c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.b (0,a0,d0.l),d3
     660:	|  |  |  |  |  |  |  |  |  |  |  |                    |   add.l d6,d3
     662:	|  |  |  |  |  |  |  |  |  |  |  |                    |   add.w d3,d3
			const short y = sinus40[((frameCounter + i) * 2) & 63] / 2;
     664:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.w 13cd0 <frameCounter>,a0
     66a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.w a0,a6
     66c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lea (0,a6,d5.l),a0
     670:	|  |  |  |  |  |  |  |  |  |  |  |                    |   adda.l a0,a0
     672:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l a0,d0
     674:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #62,d1
     676:	|  |  |  |  |  |  |  |  |  |  |  |                    |   and.l d1,d0
     678:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.b (0,a3,d0.l),d2
     67c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lsr.b #1,d2
			UBYTE* src = (UBYTE*)bob + 32 / 8 * 10 * 16 * (i % 6);
     67e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d5,d0
     680:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #6,d1
     682:	|  |  |  |  |  |  |  |  |  |  |  |                    |   ext.l d0
     684:	|  |  |  |  |  |  |  |  |  |  |  |                    |   divs.w d1,d0
     686:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d0,d4
     688:	|  |  |  |  |  |  |  |  |  |  |  |                    |   swap d4
     68a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   muls.w #640,d4
     68e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addi.l #71990,d4

			WaitBlit();
     694:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.l 13cc8 <GfxBase>,a6
     69a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   jsr -228(a6)
			custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | ((x & 15) << ASHIFTSHIFT); // A = source, B = mask, C = background, D = destination
     69e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.l 13cd6 <custom>,a0
     6a4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d3,d0
     6a6:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #12,d1
     6a8:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lsl.w d1,d0
     6aa:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d0,d1
     6ac:	|  |  |  |  |  |  |  |  |  |  |  |                    |   ori.w #4042,d1
     6b0:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d1,64(a0)
			custom->bltcon1 = ((x & 15) << BSHIFTSHIFT);
     6b4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d0,66(a0)
			custom->bltapt = src;
     6b8:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d4,80(a0)
			custom->bltamod = 32 / 8;
     6bc:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #4,100(a0)
			custom->bltbpt = src + 32 / 8 * 1;
     6c2:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #4,d4
     6c4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d4,76(a0)
			custom->bltbmod = 32 / 8;
     6c8:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #4,98(a0)
			custom->bltcpt = custom->bltdpt = (UBYTE*)image + 320 / 8 * 5 * (200 + y) + x / 8;
     6ce:	|  |  |  |  |  |  |  |  |  |  |  |                    |   andi.l #255,d2
     6d4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addi.l #200,d2
     6da:	|  |  |  |  |  |  |  |  |  |  |  |                    |   muls.w #200,d2
     6de:	|  |  |  |  |  |  |  |  |  |  |  |                    |   asr.w #3,d3
     6e0:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d3,d0
     6e2:	|  |  |  |  |  |  |  |  |  |  |  |                    |   ext.l d0
     6e4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.l d2,a6
     6e6:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lea (0,a6,d0.l),a1
     6ea:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l a1,d0
     6ec:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addi.l #20788,d0
     6f2:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d0,84(a0)
     6f6:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d0,72(a0)
			custom->bltcmod = custom->bltdmod = (320 - 32) / 8;
     6fa:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #36,102(a0)
     700:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #36,96(a0)
			custom->bltafwm = custom->bltalwm = 0xffff;
     706:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #-1,70(a0)
     70c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #-1,68(a0)
			custom->bltsize = ((16 * 5) << HSIZEBITS) | (32/16);
     712:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #5122,88(a0)
		for(short i = 0; i < 16; i++) {
     718:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #1,d5
     71a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #8,d6
     71c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #16,d1
     71e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   cmp.l d5,d1
     720:	|  |  |  |  |  |  |  |  |  |  |  |                    '-- bne.w 640 <main+0x5b4>
     724:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w f0ff60 <_end+0xefc284>,d0
     72a:	|  |  |  |  |  |  |  |  |  |  |  |                        cmpi.w #20153,d0
     72e:	|  |  |  |  |  |  |  |  |  |  |  |                    ,-- beq.w 846 <main+0x7ba>
     732:	|  |  |  |  |  |  |  |  |  |  |  |                    |   cmpi.w #-24562,d0
     736:	|  |  |  |  |  |  |  |  |  |  |  |                    +-- beq.w 846 <main+0x7ba>
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
     73a:	|  |  |  |  |  |  |  |  |  |  |  |  ,-----------------|-> move.b bfe001 <_end+0xbea325>,d0
	while(!MouseLeft()) {
     740:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   btst #6,d0
     744:	|  |  |  |  |  |  |  |  |  |  |  +--|-----------------|-- bne.w 5d8 <main+0x54c>
		register volatile const void* _a3 ASM("a3") = player;
     748:	|  |  |  |  |  |  |  |  |  |  >--|--|-----------------|-> lea 152c <incbin_player_start>,a3
		register volatile const void* _a6 ASM("a6") = (void*)0xdff000;
     74e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l #14675968,a6
		__asm volatile (
     754:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movem.l d0-d1/a0-a1,-(sp)
     758:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr 8(a3)
     75c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movem.l (sp)+,d0-d1/a0-a1
	WaitVbl();
     760:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr (a2)
	WaitBlit();
     762:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc8 <GfxBase>,a6
     768:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -228(a6)
	custom->intena=0x7fff;//disable all interrupts
     76c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cd6 <custom>,a0
     772:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
     778:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
     77e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,150(a0)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
     784:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc0 <VBR>,a1
     78a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.l 13cbc <SystemIrq>,108(a1)
	custom->cop1lc=(ULONG)GfxBase->copinit;
     792:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc8 <GfxBase>,a6
     798:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.l 38(a6),128(a0)
	custom->cop2lc=(ULONG)GfxBase->LOFlist;
     79e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.l 50(a6),132(a0)
	custom->copjmp1=0x7fff; //start coppper
     7a4:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,136(a0)
	custom->intena=SystemInts|0x8000;
     7aa:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w 13cba <SystemInts>,d0
     7b0:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
     7b4:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w d0,154(a0)
	custom->dmacon=SystemDMA|0x8000;
     7b8:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w 13cb8 <SystemDMA>,d0
     7be:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
     7c2:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w d0,150(a0)
	custom->adkcon=SystemADKCON|0x8000;
     7c6:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w 13cb6 <SystemADKCON>,d0
     7cc:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
     7d0:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w d0,158(a0)
	WaitBlit();	
     7d4:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -228(a6)
	DisownBlitter();
     7d8:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc8 <GfxBase>,a6
     7de:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -462(a6)
	Enable();
     7e2:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <SysBase>,a6
     7e8:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -126(a6)
	LoadView(ActiView);
     7ec:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc8 <GfxBase>,a6
     7f2:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cb2 <ActiView>,a1
     7f8:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -222(a6)
	WaitTOF();
     7fc:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc8 <GfxBase>,a6
     802:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -270(a6)
	WaitTOF();
     806:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc8 <GfxBase>,a6
     80c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -270(a6)
	Permit();
     810:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <SysBase>,a6
     816:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -138(a6)
#endif

	// END
	FreeSystem();

	CloseLibrary((struct Library*)DOSBase);
     81a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <SysBase>,a6
     820:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc4 <DOSBase>,a1
     826:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -414(a6)
	CloseLibrary((struct Library*)GfxBase);
     82a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <SysBase>,a6
     830:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc8 <GfxBase>,a1
     836:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -414(a6)
}
     83a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   moveq #0,d0
     83c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movem.l -92(a5),d2-d7/a2-a4/a6
     842:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   unlk a5
     844:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   rts
		UaeLib(88, arg1, arg2, arg3, arg4);
     846:	|  |  |  |  |  |  |  |  |  |  |  |  |                 '-> clr.l -(sp)
     848:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.l -(sp)
     84a:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.l -(sp)
     84c:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.l -(sp)
     84e:	|  |  |  |  |  |  |  |  |  |  |  |  |                     pea 58 <_start+0x58>
     852:	|  |  |  |  |  |  |  |  |  |  |  |  |                     movea.l #15794016,a6
     858:	|  |  |  |  |  |  |  |  |  |  |  |  |                     jsr (a6)
		debug_filled_rect(f + 100, 200*2, f + 400, 220*2, 0x0000ff00); // 0x00RRGGBB
     85a:	|  |  |  |  |  |  |  |  |  |  |  |  |                     andi.w #255,d7
     85e:	|  |  |  |  |  |  |  |  |  |  |  |  |                     move.w d7,d2
     860:	|  |  |  |  |  |  |  |  |  |  |  |  |                     addi.w #400,d2
	debug_cmd(barto_cmd_filled_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
     864:	|  |  |  |  |  |  |  |  |  |  |  |  |                     swap d2
     866:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.w d2
     868:	|  |  |  |  |  |  |  |  |  |  |  |  |                     ori.w #440,d2
     86c:	|  |  |  |  |  |  |  |  |  |  |  |  |                     move.w d7,d0
     86e:	|  |  |  |  |  |  |  |  |  |  |  |  |                     addi.w #100,d0
     872:	|  |  |  |  |  |  |  |  |  |  |  |  |                     swap d0
     874:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.w d0
     876:	|  |  |  |  |  |  |  |  |  |  |  |  |                     ori.w #400,d0
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     87a:	|  |  |  |  |  |  |  |  |  |  |  |  |                     move.w (a6),d1
     87c:	|  |  |  |  |  |  |  |  |  |  |  |  |                     lea 20(sp),sp
     880:	|  |  |  |  |  |  |  |  |  |  |  |  |                     cmpi.w #20153,d1
     884:	|  |  |  |  |  |  |  |  |  |  |  |  |              ,----- bne.w 94a <main+0x8be>
		UaeLib(88, arg1, arg2, arg3, arg4);
     888:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.l #65280,-(sp)
     88e:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.l d2,-(sp)
     890:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.l d0,-(sp)
     892:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      pea 2 <_start+0x2>
     896:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      pea 58 <_start+0x58>
     89a:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      movea.l #15794016,a6
     8a0:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      jsr (a6)
		debug_rect(f + 90, 190*2, f + 400, 220*2, 0x000000ff); // 0x00RRGGBB
     8a2:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.w d7,d0
     8a4:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      addi.w #90,d0
	debug_cmd(barto_cmd_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
     8a8:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      swap d0
     8aa:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      clr.w d0
     8ac:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      ori.w #380,d0
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     8b0:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.w (a6),d1
     8b2:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      lea 20(sp),sp
     8b6:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      cmpi.w #20153,d1
     8ba:	|  |  |  |  |  |  |  |  |  |  |  |  |        ,-----|----- bne.w 988 <main+0x8fc>
		UaeLib(88, arg1, arg2, arg3, arg4);
     8be:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  ,--|----> pea ff <main+0x73>
     8c2:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      move.l d2,-(sp)
     8c4:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      move.l d0,-(sp)
     8c6:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      pea 1 <_start+0x1>
     8ca:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      pea 58 <_start+0x58>
     8ce:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      movea.l #15794016,a6
     8d4:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      jsr (a6)
		debug_text(f+ 130, 209*2, "This is a WinUAE debug overlay", 0x00ff00ff);
     8d6:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      addi.w #130,d7
	debug_cmd(barto_cmd_text, (((unsigned int)left) << 16) | ((unsigned int)top), (unsigned int)text, color);
     8da:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      swap d7
     8dc:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      clr.w d7
     8de:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      ori.w #418,d7
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     8e2:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      move.w (a6),d0
     8e4:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      lea 20(sp),sp
     8e8:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      cmpi.w #20153,d0
     8ec:	|  |  |  |  |  |  |  |  |  |  |  |  |  ,-----|--|--|----- bne.s 920 <main+0x894>
		UaeLib(88, arg1, arg2, arg3, arg4);
     8ee:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  ,--|--|--|----> move.l #16711935,-(sp)
     8f4:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      pea 2fe2 <incbin_player_end+0x150>
     8fa:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      move.l d7,-(sp)
     8fc:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      pea 3 <_start+0x3>
     900:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      pea 58 <_start+0x58>
     904:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      jsr f0ff60 <_end+0xefc284>
}
     90a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      lea 20(sp),sp
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
     90e:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ,-> move.b bfe001 <_end+0xbea325>,d0
	while(!MouseLeft()) {
     914:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   btst #6,d0
     918:	|  |  |  |  |  |  |  |  |  |  |  '--|--|--|--|--|--|--|-- bne.w 5d8 <main+0x54c>
     91c:	|  |  |  |  |  |  |  |  |  |  '-----|--|--|--|--|--|--|-- bra.w 748 <main+0x6bc>
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     920:	|  |  |  |  |  |  |  |  |  |        |  >--|--|--|--|--|-> cmpi.w #-24562,d0
     924:	|  |  |  |  |  |  |  |  |  |        +--|--|--|--|--|--|-- bne.w 73a <main+0x6ae>
		UaeLib(88, arg1, arg2, arg3, arg4);
     928:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   move.l #16711935,-(sp)
     92e:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   pea 2fe2 <incbin_player_end+0x150>
     934:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   move.l d7,-(sp)
     936:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   pea 3 <_start+0x3>
     93a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   pea 58 <_start+0x58>
     93e:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   jsr f0ff60 <_end+0xefc284>
}
     944:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   lea 20(sp),sp
     948:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  '-- bra.s 90e <main+0x882>
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     94a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  '----> cmpi.w #-24562,d1
     94e:	|  |  |  |  |  |  |  |  |  |        +--|--|--|--|-------- bne.w 73a <main+0x6ae>
		UaeLib(88, arg1, arg2, arg3, arg4);
     952:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.l #65280,-(sp)
     958:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.l d2,-(sp)
     95a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.l d0,-(sp)
     95c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         pea 2 <_start+0x2>
     960:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         pea 58 <_start+0x58>
     964:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         movea.l #15794016,a6
     96a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         jsr (a6)
		debug_rect(f + 90, 190*2, f + 400, 220*2, 0x000000ff); // 0x00RRGGBB
     96c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.w d7,d0
     96e:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         addi.w #90,d0
	debug_cmd(barto_cmd_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
     972:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         swap d0
     974:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         clr.w d0
     976:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         ori.w #380,d0
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     97a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.w (a6),d1
     97c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         lea 20(sp),sp
     980:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         cmpi.w #20153,d1
     984:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  '-------- beq.w 8be <main+0x832>
     988:	|  |  |  |  |  |  |  |  |  |        |  |  |  '----------> cmpi.w #-24562,d1
     98c:	|  |  |  |  |  |  |  |  |  |        '--|--|-------------- bne.w 73a <main+0x6ae>
		UaeLib(88, arg1, arg2, arg3, arg4);
     990:	|  |  |  |  |  |  |  |  |  |           |  |               pea ff <main+0x73>
     994:	|  |  |  |  |  |  |  |  |  |           |  |               move.l d2,-(sp)
     996:	|  |  |  |  |  |  |  |  |  |           |  |               move.l d0,-(sp)
     998:	|  |  |  |  |  |  |  |  |  |           |  |               pea 1 <_start+0x1>
     99c:	|  |  |  |  |  |  |  |  |  |           |  |               pea 58 <_start+0x58>
     9a0:	|  |  |  |  |  |  |  |  |  |           |  |               movea.l #15794016,a6
     9a6:	|  |  |  |  |  |  |  |  |  |           |  |               jsr (a6)
		debug_text(f+ 130, 209*2, "This is a WinUAE debug overlay", 0x00ff00ff);
     9a8:	|  |  |  |  |  |  |  |  |  |           |  |               addi.w #130,d7
	debug_cmd(barto_cmd_text, (((unsigned int)left) << 16) | ((unsigned int)top), (unsigned int)text, color);
     9ac:	|  |  |  |  |  |  |  |  |  |           |  |               swap d7
     9ae:	|  |  |  |  |  |  |  |  |  |           |  |               clr.w d7
     9b0:	|  |  |  |  |  |  |  |  |  |           |  |               ori.w #418,d7
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     9b4:	|  |  |  |  |  |  |  |  |  |           |  |               move.w (a6),d0
     9b6:	|  |  |  |  |  |  |  |  |  |           |  |               lea 20(sp),sp
     9ba:	|  |  |  |  |  |  |  |  |  |           |  |               cmpi.w #20153,d0
     9be:	|  |  |  |  |  |  |  |  |  |           |  '-------------- beq.w 8ee <main+0x862>
     9c2:	|  |  |  |  |  |  |  |  |  |           '----------------- bra.w 920 <main+0x894>
     9c6:	|  |  |  |  |  |  |  |  |  '----------------------------> clr.l -(sp)
     9c8:	|  |  |  |  |  |  |  |  |                                 clr.l -(sp)
     9ca:	|  |  |  |  |  |  |  |  |                                 pea -50(a5)
     9ce:	|  |  |  |  |  |  |  |  |                                 pea 4 <_start+0x4>
     9d2:	|  |  |  |  |  |  |  |  |                                 jsr eae <debug_cmd.part.0>
     9d8:	|  |  |  |  |  |  |  |  |                                 lea 16(sp),sp
	debug_register_copperlist(copper1, "copper1", 1024, 0);
     9dc:	|  |  |  |  |  |  |  |  |                                 pea 400 <main+0x374>
     9e0:	|  |  |  |  |  |  |  |  |                                 pea 2fd2 <incbin_player_end+0x140>
     9e6:	|  |  |  |  |  |  |  |  |                                 move.l a3,-(sp)
     9e8:	|  |  |  |  |  |  |  |  |                                 lea 1226 <debug_register_copperlist.constprop.0>,a4
     9ee:	|  |  |  |  |  |  |  |  |                                 jsr (a4)
	debug_register_copperlist(copper2, "copper2", sizeof(copper2), 0);
     9f0:	|  |  |  |  |  |  |  |  |                                 pea 80 <_start+0x80>
     9f4:	|  |  |  |  |  |  |  |  |                                 pea 2fda <incbin_player_end+0x148>
     9fa:	|  |  |  |  |  |  |  |  |                                 pea 30b4 <copper2>
     a00:	|  |  |  |  |  |  |  |  |                                 jsr (a4)
	*copListEnd++ = offsetof(struct Custom, ddfstrt);
     a02:	|  |  |  |  |  |  |  |  |                                 move.w #146,(a3)
	*copListEnd++ = fw;
     a06:	|  |  |  |  |  |  |  |  |                                 move.w #56,2(a3)
	*copListEnd++ = offsetof(struct Custom, ddfstop);
     a0c:	|  |  |  |  |  |  |  |  |                                 move.w #148,4(a3)
	*copListEnd++ = fw+(((width>>4)-1)<<3);
     a12:	|  |  |  |  |  |  |  |  |                                 move.w #208,6(a3)
	*copListEnd++ = offsetof(struct Custom, diwstrt);
     a18:	|  |  |  |  |  |  |  |  |                                 move.w #142,8(a3)
	*copListEnd++ = x+(y<<8);
     a1e:	|  |  |  |  |  |  |  |  |                                 move.w #11393,10(a3)
	*copListEnd++ = offsetof(struct Custom, diwstop);
     a24:	|  |  |  |  |  |  |  |  |                                 move.w #144,12(a3)
	*copListEnd++ = (xstop-256)+((ystop-256)<<8);
     a2a:	|  |  |  |  |  |  |  |  |                                 move.w #11457,14(a3)
	*copPtr++ = offsetof(struct Custom, bplcon0);
     a30:	|  |  |  |  |  |  |  |  |                                 move.w #256,16(a3)
	*copPtr++ = (0<<10)/*dual pf*/|(1<<9)/*color*/|((5)<<12)/*num bitplanes*/;
     a36:	|  |  |  |  |  |  |  |  |                                 move.w #20992,18(a3)
	*copPtr++ = offsetof(struct Custom, bplcon1);	//scrolling
     a3c:	|  |  |  |  |  |  |  |  |                                 move.w #258,20(a3)
     a42:	|  |  |  |  |  |  |  |  |                                 lea 22(a3),a0
     a46:	|  |  |  |  |  |  |  |  |                                 move.l a0,13cd2 <scroll>
	*copPtr++ = 0;
     a4c:	|  |  |  |  |  |  |  |  |                                 clr.w 22(a3)
	*copPtr++ = offsetof(struct Custom, bplcon2);	//playfied priority
     a50:	|  |  |  |  |  |  |  |  |                                 move.w #260,24(a3)
	*copPtr++ = 1<<6;//0x24;			//Sprites have priority over playfields
     a56:	|  |  |  |  |  |  |  |  |                                 move.w #64,26(a3)
	*copPtr++=offsetof(struct Custom, bpl1mod); //odd planes   1,3,5
     a5c:	|  |  |  |  |  |  |  |  |                                 move.w #264,28(a3)
	*copPtr++=4*lineSize;
     a62:	|  |  |  |  |  |  |  |  |                                 move.w #160,30(a3)
	*copPtr++=offsetof(struct Custom, bpl2mod); //even  planes 2,4
     a68:	|  |  |  |  |  |  |  |  |                                 move.w #266,32(a3)
	*copPtr++=4*lineSize;
     a6e:	|  |  |  |  |  |  |  |  |                                 move.w #160,34(a3)
		ULONG addr=(ULONG)planes[i];
     a74:	|  |  |  |  |  |  |  |  |                                 move.l #20788,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     a7a:	|  |  |  |  |  |  |  |  |                                 move.w #224,36(a3)
		*copListEnd++=(UWORD)(addr>>16);
     a80:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     a82:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     a84:	|  |  |  |  |  |  |  |  |                                 swap d1
     a86:	|  |  |  |  |  |  |  |  |                                 move.w d1,38(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     a8a:	|  |  |  |  |  |  |  |  |                                 move.w #226,40(a3)
		*copListEnd++=(UWORD)addr;
     a90:	|  |  |  |  |  |  |  |  |                                 move.w d0,42(a3)
		ULONG addr=(ULONG)planes[i];
     a94:	|  |  |  |  |  |  |  |  |                                 move.l #20828,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     a9a:	|  |  |  |  |  |  |  |  |                                 move.w #228,44(a3)
		*copListEnd++=(UWORD)(addr>>16);
     aa0:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     aa2:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     aa4:	|  |  |  |  |  |  |  |  |                                 swap d1
     aa6:	|  |  |  |  |  |  |  |  |                                 move.w d1,46(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     aaa:	|  |  |  |  |  |  |  |  |                                 move.w #230,48(a3)
		*copListEnd++=(UWORD)addr;
     ab0:	|  |  |  |  |  |  |  |  |                                 move.w d0,50(a3)
		ULONG addr=(ULONG)planes[i];
     ab4:	|  |  |  |  |  |  |  |  |                                 move.l #20868,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     aba:	|  |  |  |  |  |  |  |  |                                 move.w #232,52(a3)
		*copListEnd++=(UWORD)(addr>>16);
     ac0:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     ac2:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     ac4:	|  |  |  |  |  |  |  |  |                                 swap d1
     ac6:	|  |  |  |  |  |  |  |  |                                 move.w d1,54(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     aca:	|  |  |  |  |  |  |  |  |                                 move.w #234,56(a3)
		*copListEnd++=(UWORD)addr;
     ad0:	|  |  |  |  |  |  |  |  |                                 move.w d0,58(a3)
		ULONG addr=(ULONG)planes[i];
     ad4:	|  |  |  |  |  |  |  |  |                                 move.l #20908,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     ada:	|  |  |  |  |  |  |  |  |                                 move.w #236,60(a3)
		*copListEnd++=(UWORD)(addr>>16);
     ae0:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     ae2:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     ae4:	|  |  |  |  |  |  |  |  |                                 swap d1
     ae6:	|  |  |  |  |  |  |  |  |                                 move.w d1,62(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     aea:	|  |  |  |  |  |  |  |  |                                 move.w #238,64(a3)
		*copListEnd++=(UWORD)addr;
     af0:	|  |  |  |  |  |  |  |  |                                 move.w d0,66(a3)
		ULONG addr=(ULONG)planes[i];
     af4:	|  |  |  |  |  |  |  |  |                                 move.l #20948,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     afa:	|  |  |  |  |  |  |  |  |                                 move.w #240,68(a3)
		*copListEnd++=(UWORD)(addr>>16);
     b00:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     b02:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     b04:	|  |  |  |  |  |  |  |  |                                 swap d1
     b06:	|  |  |  |  |  |  |  |  |                                 move.w d1,70(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     b0a:	|  |  |  |  |  |  |  |  |                                 move.w #242,72(a3)
		*copListEnd++=(UWORD)addr;
     b10:	|  |  |  |  |  |  |  |  |                                 move.w d0,74(a3)
	for (USHORT i=0;i<numPlanes;i++) {
     b14:	|  |  |  |  |  |  |  |  |                                 lea 76(a3),a1
     b18:	|  |  |  |  |  |  |  |  |                                 move.l #5418,d2
     b1e:	|  |  |  |  |  |  |  |  |                                 lea 24(sp),sp
		*copListEnd++=(UWORD)addr;
     b22:	|  |  |  |  |  |  |  |  |                                 lea 14ea <incbin_colors_start>,a0
     b28:	|  |  |  |  |  |  |  |  |                                 move.w #382,d0
     b2c:	|  |  |  |  |  |  |  |  |                                 sub.w d3,d0
     b2e:	|  |  |  |  |  |  |  |  '-------------------------------- bra.w 55c <main+0x4d0>
		KPrintF("p61Init failed!\n");
     b32:	|  |  |  >--|--|--|--|----------------------------------> pea 2faf <incbin_player_end+0x11d>
     b38:	|  |  |  |  |  |  |  |                                    jsr f88 <KPrintF>
     b3e:	|  |  |  |  |  |  |  |                                    addq.l #4,sp
	warpmode(0);
     b40:	|  |  |  |  |  |  |  |                                    clr.l -(sp)
     b42:	|  |  |  |  |  |  |  |                                    jsr (a4)
	Forbid();
     b44:	|  |  |  |  |  |  |  |                                    movea.l 13ccc <SysBase>,a6
     b4a:	|  |  |  |  |  |  |  |                                    jsr -132(a6)
	SystemADKCON=custom->adkconr;
     b4e:	|  |  |  |  |  |  |  |                                    movea.l 13cd6 <custom>,a0
     b54:	|  |  |  |  |  |  |  |                                    move.w 16(a0),d0
     b58:	|  |  |  |  |  |  |  |                                    move.w d0,13cb6 <SystemADKCON>
	SystemInts=custom->intenar;
     b5e:	|  |  |  |  |  |  |  |                                    move.w 28(a0),d0
     b62:	|  |  |  |  |  |  |  |                                    move.w d0,13cba <SystemInts>
	SystemDMA=custom->dmaconr;
     b68:	|  |  |  |  |  |  |  |                                    move.w 2(a0),d0
     b6c:	|  |  |  |  |  |  |  |                                    move.w d0,13cb8 <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
     b72:	|  |  |  |  |  |  |  |                                    movea.l 13cc8 <GfxBase>,a6
     b78:	|  |  |  |  |  |  |  |                                    move.l 34(a6),13cb2 <ActiView>
	LoadView(0);
     b80:	|  |  |  |  |  |  |  |                                    suba.l a1,a1
     b82:	|  |  |  |  |  |  |  |                                    jsr -222(a6)
	WaitTOF();
     b86:	|  |  |  |  |  |  |  |                                    movea.l 13cc8 <GfxBase>,a6
     b8c:	|  |  |  |  |  |  |  |                                    jsr -270(a6)
	WaitTOF();
     b90:	|  |  |  |  |  |  |  |                                    movea.l 13cc8 <GfxBase>,a6
     b96:	|  |  |  |  |  |  |  |                                    jsr -270(a6)
	WaitVbl();
     b9a:	|  |  |  |  |  |  |  |                                    lea ece <WaitVbl>,a2
     ba0:	|  |  |  |  |  |  |  |                                    jsr (a2)
	WaitVbl();
     ba2:	|  |  |  |  |  |  |  |                                    jsr (a2)
	OwnBlitter();
     ba4:	|  |  |  |  |  |  |  |                                    movea.l 13cc8 <GfxBase>,a6
     baa:	|  |  |  |  |  |  |  |                                    jsr -456(a6)
	WaitBlit();	
     bae:	|  |  |  |  |  |  |  |                                    movea.l 13cc8 <GfxBase>,a6
     bb4:	|  |  |  |  |  |  |  |                                    jsr -228(a6)
	Disable();
     bb8:	|  |  |  |  |  |  |  |                                    movea.l 13ccc <SysBase>,a6
     bbe:	|  |  |  |  |  |  |  |                                    jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
     bc2:	|  |  |  |  |  |  |  |                                    movea.l 13cd6 <custom>,a0
     bc8:	|  |  |  |  |  |  |  |                                    move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
     bce:	|  |  |  |  |  |  |  |                                    move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
     bd4:	|  |  |  |  |  |  |  |                                    move.w #32767,150(a0)
     bda:	|  |  |  |  |  |  |  |                                    addq.l #4,sp
	for(int a=0;a<32;a++)
     bdc:	|  |  |  |  |  |  |  |                                    moveq #0,d1
     bde:	|  |  |  |  |  |  |  '----------------------------------- bra.w 1e0 <main+0x154>
		Exit(0);
     be2:	>--|--|--|--|--|--|-------------------------------------> suba.l a6,a6
     be4:	|  |  |  |  |  |  |                                       moveq #0,d1
     be6:	|  |  |  |  |  |  |                                       jsr -144(a6)
	KPrintF("Hello debugger from Amiga!\n");
     bea:	|  |  |  |  |  |  |                                       pea 2f83 <incbin_player_end+0xf1>
     bf0:	|  |  |  |  |  |  |                                       jsr f88 <KPrintF>
	Write(Output(), (APTR)"Hello console!\n", 15);
     bf6:	|  |  |  |  |  |  |                                       movea.l 13cc4 <DOSBase>,a6
     bfc:	|  |  |  |  |  |  |                                       jsr -60(a6)
     c00:	|  |  |  |  |  |  |                                       movea.l 13cc4 <DOSBase>,a6
     c06:	|  |  |  |  |  |  |                                       move.l d0,d1
     c08:	|  |  |  |  |  |  |                                       move.l #12191,d2
     c0e:	|  |  |  |  |  |  |                                       moveq #15,d3
     c10:	|  |  |  |  |  |  |                                       jsr -48(a6)
	Delay(2000);
     c14:	|  |  |  |  |  |  |                                       movea.l 13cc4 <DOSBase>,a6
     c1a:	|  |  |  |  |  |  |                                       move.l #2000,d1
     c20:	|  |  |  |  |  |  |                                       jsr -198(a6)
	warpmode(1);
     c24:	|  |  |  |  |  |  |                                       pea 1 <_start+0x1>
     c28:	|  |  |  |  |  |  |                                       lea ffa <warpmode>,a4
     c2e:	|  |  |  |  |  |  |                                       jsr (a4)
		register volatile const void* _a0 ASM("a0") = module;
     c30:	|  |  |  |  |  |  |                                       lea 12838 <incbin_module_start>,a0
		register volatile const void* _a1 ASM("a1") = NULL;
     c36:	|  |  |  |  |  |  |                                       suba.l a1,a1
		register volatile const void* _a2 ASM("a2") = NULL;
     c38:	|  |  |  |  |  |  |                                       suba.l a2,a2
		register volatile const void* _a3 ASM("a3") = player;
     c3a:	|  |  |  |  |  |  |                                       lea 152c <incbin_player_start>,a3
		__asm volatile (
     c40:	|  |  |  |  |  |  |                                       movem.l d1-d7/a4-a6,-(sp)
     c44:	|  |  |  |  |  |  |                                       jsr (a3)
     c46:	|  |  |  |  |  |  |                                       movem.l (sp)+,d1-d7/a4-a6
	if(p61Init(module) != 0)
     c4a:	|  |  |  |  |  |  |                                       addq.l #8,sp
     c4c:	|  |  |  |  |  |  |                                       tst.l d0
     c4e:	|  |  |  |  '--|--|-------------------------------------- beq.w 142 <main+0xb6>
     c52:	|  |  |  '-----|--|-------------------------------------- bra.w b32 <main+0xaa6>
		Exit(0);
     c56:	|  |  '--------|--|-------------------------------------> movea.l 13cc4 <DOSBase>,a6
     c5c:	|  |           |  |                                       moveq #0,d1
     c5e:	|  |           |  |                                       jsr -144(a6)
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
     c62:	|  |           |  |                                       movea.l 13ccc <SysBase>,a6
     c68:	|  |           |  |                                       lea 2f77 <incbin_player_end+0xe5>,a1
     c6e:	|  |           |  |                                       moveq #0,d0
     c70:	|  |           |  |                                       jsr -552(a6)
     c74:	|  |           |  |                                       move.l d0,13cc4 <DOSBase>
	if (!DOSBase)
     c7a:	|  '-----------|--|-------------------------------------- bne.w da <main+0x4e>
     c7e:	'--------------|--|-------------------------------------- bra.w be2 <main+0xb56>
	APTR vbr = 0;
     c82:	               '--|-------------------------------------> moveq #0,d0
	VBR=GetVBR();
     c84:	                  |                                       move.l d0,13cc0 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
     c8a:	                  |                                       movea.l 13cc0 <VBR>,a0
     c90:	                  |                                       move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
     c94:	                  |                                       move.l d0,13cbc <SystemIrq>
	WaitVbl();
     c9a:	                  |                                       jsr (a2)
	char* test = (char*)AllocMem(2502, MEMF_ANY);
     c9c:	                  |                                       movea.l 13ccc <SysBase>,a6
     ca2:	                  |                                       move.l #2502,d0
     ca8:	                  |                                       moveq #0,d1
     caa:	                  |                                       jsr -198(a6)
     cae:	                  |                                       move.l d0,d4
	memset(test, 0xcd, 2502);
     cb0:	                  |                                       pea 9c6 <main+0x93a>
     cb4:	                  |                                       pea cd <main+0x41>
     cb8:	                  |                                       move.l d0,-(sp)
     cba:	                  |                                       jsr 12c0 <memset>
	memclr(test + 2, 2502 - 4);
     cc0:	                  |                                       movea.l d4,a0
     cc2:	                  |                                       addq.l #2,a0
	__asm volatile (
     cc4:	                  |                                       move.l #2498,d5
     cca:	                  |                                       adda.l d5,a0
     ccc:	                  |                                       moveq #0,d0
     cce:	                  |                                       moveq #0,d1
     cd0:	                  |                                       moveq #0,d2
     cd2:	                  |                                       moveq #0,d3
     cd4:	                  |                                       cmpi.l #256,d5
     cda:	                  |                                ,----- blt.w d2e <main+0xca2>
     cde:	                  |                                |  ,-> movem.l d0-d3,-(a0)
     ce2:	                  |                                |  |   movem.l d0-d3,-(a0)
     ce6:	                  |                                |  |   movem.l d0-d3,-(a0)
     cea:	                  |                                |  |   movem.l d0-d3,-(a0)
     cee:	                  |                                |  |   movem.l d0-d3,-(a0)
     cf2:	                  |                                |  |   movem.l d0-d3,-(a0)
     cf6:	                  |                                |  |   movem.l d0-d3,-(a0)
     cfa:	                  |                                |  |   movem.l d0-d3,-(a0)
     cfe:	                  |                                |  |   movem.l d0-d3,-(a0)
     d02:	                  |                                |  |   movem.l d0-d3,-(a0)
     d06:	                  |                                |  |   movem.l d0-d3,-(a0)
     d0a:	                  |                                |  |   movem.l d0-d3,-(a0)
     d0e:	                  |                                |  |   movem.l d0-d3,-(a0)
     d12:	                  |                                |  |   movem.l d0-d3,-(a0)
     d16:	                  |                                |  |   movem.l d0-d3,-(a0)
     d1a:	                  |                                |  |   movem.l d0-d3,-(a0)
     d1e:	                  |                                |  |   subi.l #256,d5
     d24:	                  |                                |  |   cmpi.l #256,d5
     d2a:	                  |                                |  '-- bge.w cde <main+0xc52>
     d2e:	                  |                                >----> cmpi.w #64,d5
     d32:	                  |                                |  ,-- blt.w d4e <main+0xcc2>
     d36:	                  |                                |  |   movem.l d0-d3,-(a0)
     d3a:	                  |                                |  |   movem.l d0-d3,-(a0)
     d3e:	                  |                                |  |   movem.l d0-d3,-(a0)
     d42:	                  |                                |  |   movem.l d0-d3,-(a0)
     d46:	                  |                                |  |   subi.w #64,d5
     d4a:	                  |                                '--|-- bra.w d2e <main+0xca2>
     d4e:	                  |                                   '-> lsr.w #2,d5
     d50:	                  |                                   ,-- bcc.w d56 <main+0xcca>
     d54:	                  |                                   |   move.w d0,-(a0)
     d56:	                  |                                   '-> moveq #16,d1
     d58:	                  |                                       sub.w d5,d1
     d5a:	                  |                                       add.w d1,d1
     d5c:	                  |                                       jmp (d60 <main+0xcd4>,pc,d1.w)
     d60:	                  |                                       move.l d0,-(a0)
     d62:	                  |                                       move.l d0,-(a0)
     d64:	                  |                                       move.l d0,-(a0)
     d66:	                  |                                       move.l d0,-(a0)
     d68:	                  |                                       move.l d0,-(a0)
     d6a:	                  |                                       move.l d0,-(a0)
     d6c:	                  |                                       move.l d0,-(a0)
     d6e:	                  |                                       move.l d0,-(a0)
     d70:	                  |                                       move.l d0,-(a0)
     d72:	                  |                                       move.l d0,-(a0)
     d74:	                  |                                       move.l d0,-(a0)
     d76:	                  |                                       move.l d0,-(a0)
     d78:	                  |                                       move.l d0,-(a0)
     d7a:	                  |                                       move.l d0,-(a0)
     d7c:	                  |                                       move.l d0,-(a0)
     d7e:	                  |                                       move.l d0,-(a0)
	FreeMem(test, 2502);
     d80:	                  |                                       movea.l 13ccc <SysBase>,a6
     d86:	                  |                                       movea.l d4,a1
     d88:	                  |                                       move.l #2502,d0
     d8e:	                  |                                       jsr -210(a6)
	USHORT* copper1 = (USHORT*)AllocMem(1024, MEMF_CHIP);
     d92:	                  |                                       movea.l 13ccc <SysBase>,a6
     d98:	                  |                                       move.l #1024,d0
     d9e:	                  |                                       moveq #2,d1
     da0:	                  |                                       jsr -198(a6)
     da4:	                  |                                       movea.l d0,a3
	debug_register_bitmap(image, "image.bpl", 320, 256, 5, debug_resource_bitmap_interleaved);
     da6:	                  |                                       pea 1 <_start+0x1>
     daa:	                  |                                       pea 100 <main+0x74>
     dae:	                  |                                       pea 140 <main+0xb4>
     db2:	                  |                                       pea 2fc0 <incbin_player_end+0x12e>
     db8:	                  |                                       pea 5134 <incbin_image_start>
     dbe:	                  |                                       lea 1156 <debug_register_bitmap.constprop.0>,a4
     dc4:	                  |                                       jsr (a4)
	debug_register_bitmap(bob, "bob.bpl", 32, 96, 5, debug_resource_bitmap_interleaved | debug_resource_bitmap_masked);
     dc6:	                  |                                       lea 32(sp),sp
     dca:	                  |                                       pea 3 <_start+0x3>
     dce:	                  |                                       pea 60 <_start+0x60>
     dd2:	                  |                                       pea 20 <_start+0x20>
     dd6:	                  |                                       pea 2fca <incbin_player_end+0x138>
     ddc:	                  |                                       pea 11936 <incbin_bob_start>
     de2:	                  |                                       jsr (a4)
	struct debug_resource resource = {
     de4:	                  |                                       clr.l -42(a5)
     de8:	                  |                                       clr.l -38(a5)
     dec:	                  |                                       clr.l -34(a5)
     df0:	                  |                                       clr.l -30(a5)
     df4:	                  |                                       clr.l -26(a5)
     df8:	                  |                                       clr.l -22(a5)
     dfc:	                  |                                       clr.l -18(a5)
     e00:	                  |                                       clr.l -14(a5)
     e04:	                  |                                       clr.l -10(a5)
     e08:	                  |                                       clr.l -6(a5)
     e0c:	                  |                                       clr.w -2(a5)
		.address = (unsigned int)addr,
     e10:	                  |                                       move.l #5354,d3
	struct debug_resource resource = {
     e16:	                  |                                       move.l d3,-50(a5)
     e1a:	                  |                                       moveq #64,d1
     e1c:	                  |                                       move.l d1,-46(a5)
     e20:	                  |                                       move.w #1,-10(a5)
     e26:	                  |                                       move.w #32,-6(a5)
     e2c:	                  |                                       lea 20(sp),sp
	while(*source && --num > 0)
     e30:	                  |                                       moveq #105,d0
	struct debug_resource resource = {
     e32:	                  |                                       lea -42(a5),a1
     e36:	                  |                                       lea 2f5c <incbin_player_end+0xca>,a0
     e3c:	                  '-------------------------------------- bra.w 3e2 <main+0x356>

00000e40 <interruptHandler>:
static __attribute__((interrupt)) void interruptHandler() {
     e40:	    movem.l d0-d1/a0-a1/a3/a6,-(sp)
	custom->intreq=(1<<INTB_VERTB); custom->intreq=(1<<INTB_VERTB); //reset vbl req. twice for a4000 bug.
     e44:	    movea.l 13cd6 <custom>,a0
     e4a:	    move.w #32,156(a0)
     e50:	    move.w #32,156(a0)
	if(scroll) {
     e56:	    movea.l 13cd2 <scroll>,a0
     e5c:	    cmpa.w #0,a0
     e60:	,-- beq.s e82 <interruptHandler+0x42>
		int sin = sinus15[frameCounter & 63];
     e62:	|   move.w 13cd0 <frameCounter>,d0
     e68:	|   moveq #63,d1
     e6a:	|   and.l d1,d0
		*scroll = sin | (sin << 4);
     e6c:	|   lea 3074 <sinus15>,a1
     e72:	|   move.b (0,a1,d0.l),d0
     e76:	|   andi.w #255,d0
     e7a:	|   move.w d0,d1
     e7c:	|   lsl.w #4,d1
     e7e:	|   or.w d0,d1
     e80:	|   move.w d1,(a0)
		register volatile const void* _a3 ASM("a3") = player;
     e82:	'-> lea 152c <incbin_player_start>,a3
		register volatile const void* _a6 ASM("a6") = (void*)0xdff000;
     e88:	    movea.l #14675968,a6
		__asm volatile (
     e8e:	    movem.l d0-a2/a4-a5,-(sp)
     e92:	    jsr 4(a3)
     e96:	    movem.l (sp)+,d0-a2/a4-a5
	frameCounter++;
     e9a:	    move.w 13cd0 <frameCounter>,d0
     ea0:	    addq.w #1,d0
     ea2:	    move.w d0,13cd0 <frameCounter>
}
     ea8:	    movem.l (sp)+,d0-d1/a0-a1/a3/a6
     eac:	    rte

00000eae <debug_cmd.part.0>:
		UaeLib(88, arg1, arg2, arg3, arg4);
     eae:	move.l 16(sp),-(sp)
     eb2:	move.l 16(sp),-(sp)
     eb6:	move.l 16(sp),-(sp)
     eba:	move.l 16(sp),-(sp)
     ebe:	pea 58 <_start+0x58>
     ec2:	jsr f0ff60 <_end+0xefc284>
}
     ec8:	lea 20(sp),sp
     ecc:	rts

00000ece <WaitVbl>:
void WaitVbl() {
     ece:	             subq.l #8,sp
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     ed0:	             move.w f0ff60 <_end+0xefc284>,d0
     ed6:	             cmpi.w #20153,d0
     eda:	      ,----- beq.s f50 <WaitVbl+0x82>
     edc:	      |      cmpi.w #-24562,d0
     ee0:	      +----- beq.s f50 <WaitVbl+0x82>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     ee2:	,-----|----> move.l dff004 <_end+0xdeb328>,d0
     ee8:	|     |      move.l d0,(sp)
		vpos&=0x1ff00;
     eea:	|     |      move.l (sp),d0
     eec:	|     |      andi.l #130816,d0
     ef2:	|     |      move.l d0,(sp)
		if (vpos!=(311<<8))
     ef4:	|     |      move.l (sp),d0
     ef6:	|     |      cmpi.l #79616,d0
     efc:	+-----|----- beq.s ee2 <WaitVbl+0x14>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     efe:	|  ,--|----> move.l dff004 <_end+0xdeb328>,d0
     f04:	|  |  |      move.l d0,4(sp)
		vpos&=0x1ff00;
     f08:	|  |  |      move.l 4(sp),d0
     f0c:	|  |  |      andi.l #130816,d0
     f12:	|  |  |      move.l d0,4(sp)
		if (vpos==(311<<8))
     f16:	|  |  |      move.l 4(sp),d0
     f1a:	|  |  |      cmpi.l #79616,d0
     f20:	|  +--|----- bne.s efe <WaitVbl+0x30>
     f22:	|  |  |      move.w f0ff60 <_end+0xefc284>,d0
     f28:	|  |  |      cmpi.w #20153,d0
     f2c:	|  |  |  ,-- beq.s f38 <WaitVbl+0x6a>
     f2e:	|  |  |  |   cmpi.w #-24562,d0
     f32:	|  |  |  +-- beq.s f38 <WaitVbl+0x6a>
}
     f34:	|  |  |  |   addq.l #8,sp
     f36:	|  |  |  |   rts
     f38:	|  |  |  '-> clr.l -(sp)
     f3a:	|  |  |      clr.l -(sp)
     f3c:	|  |  |      clr.l -(sp)
     f3e:	|  |  |      pea 5 <_start+0x5>
     f42:	|  |  |      jsr eae <debug_cmd.part.0>
}
     f48:	|  |  |      lea 16(sp),sp
     f4c:	|  |  |      addq.l #8,sp
     f4e:	|  |  |      rts
     f50:	|  |  '----> clr.l -(sp)
     f52:	|  |         clr.l -(sp)
     f54:	|  |         pea 1 <_start+0x1>
     f58:	|  |         pea 5 <_start+0x5>
     f5c:	|  |         jsr eae <debug_cmd.part.0>
}
     f62:	|  |         lea 16(sp),sp
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     f66:	|  |         move.l dff004 <_end+0xdeb328>,d0
     f6c:	|  |         move.l d0,(sp)
		vpos&=0x1ff00;
     f6e:	|  |         move.l (sp),d0
     f70:	|  |         andi.l #130816,d0
     f76:	|  |         move.l d0,(sp)
		if (vpos!=(311<<8))
     f78:	|  |         move.l (sp),d0
     f7a:	|  |         cmpi.l #79616,d0
     f80:	'--|-------- beq.w ee2 <WaitVbl+0x14>
     f84:	   '-------- bra.w efe <WaitVbl+0x30>

00000f88 <KPrintF>:
void KPrintF(const char* fmt, ...) {
     f88:	    lea -128(sp),sp
     f8c:	    movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
     f90:	    move.w f0ff60 <_end+0xefc284>,d0
     f96:	    cmpi.w #20153,d0
     f9a:	,-- beq.s fc6 <KPrintF+0x3e>
     f9c:	|   cmpi.w #-24562,d0
     fa0:	+-- beq.s fc6 <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
     fa2:	|   movea.l 13ccc <SysBase>,a6
     fa8:	|   movea.l 144(sp),a0
     fac:	|   lea 148(sp),a1
     fb0:	|   lea 14d8 <KPutCharX>,a2
     fb6:	|   suba.l a3,a3
     fb8:	|   jsr -522(a6)
}
     fbc:	|   movem.l (sp)+,a2-a3/a6
     fc0:	|   lea 128(sp),sp
     fc4:	|   rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
     fc6:	'-> movea.l 13ccc <SysBase>,a6
     fcc:	    movea.l 144(sp),a0
     fd0:	    lea 148(sp),a1
     fd4:	    lea 14e6 <PutChar>,a2
     fda:	    lea 12(sp),a3
     fde:	    jsr -522(a6)
		UaeDbgLog(86, temp);
     fe2:	    move.l a3,-(sp)
     fe4:	    pea 56 <_start+0x56>
     fe8:	    jsr f0ff60 <_end+0xefc284>
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
     fee:	    addq.l #8,sp
}
     ff0:	    movem.l (sp)+,a2-a3/a6
     ff4:	    lea 128(sp),sp
     ff8:	    rts

00000ffa <warpmode>:
void warpmode(int on) { // bool
     ffa:	       subq.l #4,sp
     ffc:	       move.l a2,-(sp)
     ffe:	       move.l d2,-(sp)
	if(*((UWORD *)UaeConf) == 0x4eb9 || *((UWORD *)UaeConf) == 0xa00e) {
    1000:	       move.w f0ff60 <_end+0xefc284>,d0
    1006:	       cmpi.w #20153,d0
    100a:	   ,-- beq.s 101a <warpmode+0x20>
    100c:	   |   cmpi.w #-24562,d0
    1010:	   +-- beq.s 101a <warpmode+0x20>
}
    1012:	   |   move.l (sp)+,d2
    1014:	   |   movea.l (sp)+,a2
    1016:	   |   addq.l #4,sp
    1018:	   |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
    101a:	   '-> tst.l 16(sp)
    101e:	,----- beq.w 10be <warpmode+0xc4>
    1022:	|      pea 1 <_start+0x1>
    1026:	|      moveq #15,d2
    1028:	|      add.l sp,d2
    102a:	|      move.l d2,-(sp)
    102c:	|      clr.l -(sp)
    102e:	|      pea 2f01 <incbin_player_end+0x6f>
    1034:	|      pea ffffffff <_end+0xfffec323>
    1038:	|      pea 52 <_start+0x52>
    103c:	|      movea.l #15794016,a2
    1042:	|      jsr (a2)
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
    1044:	|      pea 1 <_start+0x1>
    1048:	|      move.l d2,-(sp)
    104a:	|      clr.l -(sp)
    104c:	|      pea 2f0f <incbin_player_end+0x7d>
    1052:	|      pea ffffffff <_end+0xfffec323>
    1056:	|      pea 52 <_start+0x52>
    105a:	|      jsr (a2)
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
    105c:	|      lea 48(sp),sp
    1060:	|      pea 1 <_start+0x1>
    1064:	|      move.l d2,-(sp)
    1066:	|      clr.l -(sp)
    1068:	|      pea 2f25 <incbin_player_end+0x93>
    106e:	|      pea ffffffff <_end+0xfffec323>
    1072:	|      pea 52 <_start+0x52>
    1076:	|      jsr (a2)
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
    1078:	|      pea 1 <_start+0x1>
    107c:	|      move.l d2,-(sp)
    107e:	|      clr.l -(sp)
    1080:	|      pea 2f42 <incbin_player_end+0xb0>
    1086:	|      pea ffffffff <_end+0xfffec323>
    108a:	|      pea 52 <_start+0x52>
    108e:	|      jsr (a2)
    1090:	|      lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
    1094:	|      move.l #11923,d0
    109a:	|      pea 1 <_start+0x1>
    109e:	|      move.l d2,-(sp)
    10a0:	|      clr.l -(sp)
    10a2:	|      move.l d0,-(sp)
    10a4:	|      pea ffffffff <_end+0xfffec323>
    10a8:	|      pea 52 <_start+0x52>
    10ac:	|      jsr f0ff60 <_end+0xefc284>
}
    10b2:	|      lea 24(sp),sp
    10b6:	|  ,-> move.l (sp)+,d2
    10b8:	|  |   movea.l (sp)+,a2
    10ba:	|  |   addq.l #4,sp
    10bc:	|  |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
    10be:	'--|-> pea 1 <_start+0x1>
    10c2:	   |   moveq #15,d2
    10c4:	   |   add.l sp,d2
    10c6:	   |   move.l d2,-(sp)
    10c8:	   |   clr.l -(sp)
    10ca:	   |   pea 2ea8 <incbin_player_end+0x16>
    10d0:	   |   pea ffffffff <_end+0xfffec323>
    10d4:	   |   pea 52 <_start+0x52>
    10d8:	   |   movea.l #15794016,a2
    10de:	   |   jsr (a2)
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
    10e0:	   |   pea 1 <_start+0x1>
    10e4:	   |   move.l d2,-(sp)
    10e6:	   |   clr.l -(sp)
    10e8:	   |   pea 2eb7 <incbin_player_end+0x25>
    10ee:	   |   pea ffffffff <_end+0xfffec323>
    10f2:	   |   pea 52 <_start+0x52>
    10f6:	   |   jsr (a2)
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
    10f8:	   |   lea 48(sp),sp
    10fc:	   |   pea 1 <_start+0x1>
    1100:	   |   move.l d2,-(sp)
    1102:	   |   clr.l -(sp)
    1104:	   |   pea 2ecc <incbin_player_end+0x3a>
    110a:	   |   pea ffffffff <_end+0xfffec323>
    110e:	   |   pea 52 <_start+0x52>
    1112:	   |   jsr (a2)
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
    1114:	   |   pea 1 <_start+0x1>
    1118:	   |   move.l d2,-(sp)
    111a:	   |   clr.l -(sp)
    111c:	   |   pea 2ee8 <incbin_player_end+0x56>
    1122:	   |   pea ffffffff <_end+0xfffec323>
    1126:	   |   pea 52 <_start+0x52>
    112a:	   |   jsr (a2)
    112c:	   |   lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
    1130:	   |   move.l #11933,d0
    1136:	   |   pea 1 <_start+0x1>
    113a:	   |   move.l d2,-(sp)
    113c:	   |   clr.l -(sp)
    113e:	   |   move.l d0,-(sp)
    1140:	   |   pea ffffffff <_end+0xfffec323>
    1144:	   |   pea 52 <_start+0x52>
    1148:	   |   jsr f0ff60 <_end+0xefc284>
}
    114e:	   |   lea 24(sp),sp
    1152:	   '-- bra.w 10b6 <warpmode+0xbc>

00001156 <debug_register_bitmap.constprop.0>:
void debug_register_bitmap(const void* addr, const char* name, short width, short height, short numPlanes, unsigned short flags) {
    1156:	       link.w a5,#-52
    115a:	       movem.l d2-d3/a2,-(sp)
    115e:	       movea.l 12(a5),a1
    1162:	       move.l 16(a5),d3
    1166:	       move.l 20(a5),d2
    116a:	       move.l 24(a5),d1
	struct debug_resource resource = {
    116e:	       clr.l -42(a5)
    1172:	       clr.l -38(a5)
    1176:	       clr.l -34(a5)
    117a:	       clr.l -30(a5)
    117e:	       clr.l -26(a5)
    1182:	       clr.l -22(a5)
    1186:	       clr.l -18(a5)
    118a:	       clr.l -14(a5)
    118e:	       clr.w -10(a5)
    1192:	       move.l 8(a5),-50(a5)
		.size = width / 8 * height * numPlanes,
    1198:	       move.w d3,d0
    119a:	       asr.w #3,d0
    119c:	       muls.w d2,d0
    119e:	       movea.w d0,a0
    11a0:	       move.l a0,d0
    11a2:	       add.l a0,d0
    11a4:	       add.l d0,d0
    11a6:	       adda.l d0,a0
	struct debug_resource resource = {
    11a8:	       move.l a0,-46(a5)
    11ac:	       move.w d1,-8(a5)
    11b0:	       move.w d3,-6(a5)
    11b4:	       move.w d2,-4(a5)
    11b8:	       move.w #5,-2(a5)
	if (flags & debug_resource_bitmap_masked)
    11be:	       cmpi.w #1,d1
    11c2:	   ,-- beq.s 11d0 <debug_register_bitmap.constprop.0+0x7a>
		resource.size *= 2;
    11c4:	   |   moveq #0,d0
    11c6:	   |   move.w a0,d0
    11c8:	   |   movea.l d0,a0
    11ca:	   |   adda.l a0,a0
    11cc:	   |   move.l a0,-46(a5)
	while(*source && --num > 0)
    11d0:	   '-> move.b (a1),d0
    11d2:	       lea -42(a5),a0
    11d6:	,----- beq.s 11e8 <debug_register_bitmap.constprop.0+0x92>
    11d8:	|      lea -11(a5),a2
		*destination++ = *source++;
    11dc:	|  ,-> addq.l #1,a1
    11de:	|  |   move.b d0,(a0)+
	while(*source && --num > 0)
    11e0:	|  |   move.b (a1),d0
    11e2:	+--|-- beq.s 11e8 <debug_register_bitmap.constprop.0+0x92>
    11e4:	|  |   cmpa.l a0,a2
    11e6:	|  '-- bne.s 11dc <debug_register_bitmap.constprop.0+0x86>
	*destination = '\0';
    11e8:	'----> clr.b (a0)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
    11ea:	       move.w f0ff60 <_end+0xefc284>,d0
    11f0:	       cmpi.w #20153,d0
    11f4:	   ,-- beq.s 1206 <debug_register_bitmap.constprop.0+0xb0>
    11f6:	   |   cmpi.w #-24562,d0
    11fa:	   +-- beq.s 1206 <debug_register_bitmap.constprop.0+0xb0>
}
    11fc:	   |   movem.l -64(a5),d2-d3/a2
    1202:	   |   unlk a5
    1204:	   |   rts
    1206:	   '-> clr.l -(sp)
    1208:	       clr.l -(sp)
    120a:	       pea -50(a5)
    120e:	       pea 4 <_start+0x4>
    1212:	       jsr eae <debug_cmd.part.0>
    1218:	       lea 16(sp),sp
    121c:	       movem.l -64(a5),d2-d3/a2
    1222:	       unlk a5
    1224:	       rts

00001226 <debug_register_copperlist.constprop.0>:
	};
	my_strncpy(resource.name, name, sizeof(resource.name));
	debug_cmd(barto_cmd_register_resource, (unsigned int)&resource, 0, 0);
}

void debug_register_copperlist(const void* addr, const char* name, unsigned int size, unsigned short flags) {
    1226:	       link.w a5,#-52
    122a:	       move.l a2,-(sp)
    122c:	       movea.l 12(a5),a1
	struct debug_resource resource = {
    1230:	       clr.l -42(a5)
    1234:	       clr.l -38(a5)
    1238:	       clr.l -34(a5)
    123c:	       clr.l -30(a5)
    1240:	       clr.l -26(a5)
    1244:	       clr.l -22(a5)
    1248:	       clr.l -18(a5)
    124c:	       clr.l -14(a5)
    1250:	       clr.l -10(a5)
    1254:	       clr.l -6(a5)
    1258:	       clr.w -2(a5)
    125c:	       move.l 8(a5),-50(a5)
    1262:	       move.l 16(a5),-46(a5)
    1268:	       move.w #2,-10(a5)
	while(*source && --num > 0)
    126e:	       move.b (a1),d0
    1270:	       lea -42(a5),a0
    1274:	,----- beq.s 1286 <debug_register_copperlist.constprop.0+0x60>
    1276:	|      lea -11(a5),a2
		*destination++ = *source++;
    127a:	|  ,-> addq.l #1,a1
    127c:	|  |   move.b d0,(a0)+
	while(*source && --num > 0)
    127e:	|  |   move.b (a1),d0
    1280:	+--|-- beq.s 1286 <debug_register_copperlist.constprop.0+0x60>
    1282:	|  |   cmpa.l a0,a2
    1284:	|  '-- bne.s 127a <debug_register_copperlist.constprop.0+0x54>
	*destination = '\0';
    1286:	'----> clr.b (a0)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
    1288:	       move.w f0ff60 <_end+0xefc284>,d0
    128e:	       cmpi.w #20153,d0
    1292:	   ,-- beq.s 12a2 <debug_register_copperlist.constprop.0+0x7c>
    1294:	   |   cmpi.w #-24562,d0
    1298:	   +-- beq.s 12a2 <debug_register_copperlist.constprop.0+0x7c>
		.type = debug_resource_type_copperlist,
		.flags = flags,
	};
	my_strncpy(resource.name, name, sizeof(resource.name));
	debug_cmd(barto_cmd_register_resource, (unsigned int)&resource, 0, 0);
}
    129a:	   |   movea.l -56(a5),a2
    129e:	   |   unlk a5
    12a0:	   |   rts
    12a2:	   '-> clr.l -(sp)
    12a4:	       clr.l -(sp)
    12a6:	       pea -50(a5)
    12aa:	       pea 4 <_start+0x4>
    12ae:	       jsr eae <debug_cmd.part.0>
    12b4:	       lea 16(sp),sp
    12b8:	       movea.l -56(a5),a2
    12bc:	       unlk a5
    12be:	       rts

000012c0 <memset>:
void* memset(void *dest, int val, unsigned long len) {
    12c0:	                      movem.l d2-d7/a2,-(sp)
    12c4:	                      move.l 32(sp),d0
    12c8:	                      move.l 36(sp),d3
    12cc:	                      movea.l 40(sp),a0
	while(len-- > 0)
    12d0:	                      lea -1(a0),a1
    12d4:	                      cmpa.w #0,a0
    12d8:	               ,----- beq.w 1386 <memset+0xc6>
		*ptr++ = val;
    12dc:	               |      move.b d3,d7
    12de:	               |      move.l d0,d2
    12e0:	               |      neg.l d2
    12e2:	               |      moveq #3,d1
    12e4:	               |      and.l d2,d1
    12e6:	               |      moveq #5,d4
    12e8:	               |      cmp.l a1,d4
    12ea:	,--------------|----- bcc.w 1426 <memset+0x166>
    12ee:	|              |      tst.l d1
    12f0:	|           ,--|----- beq.w 13c0 <memset+0x100>
    12f4:	|           |  |      movea.l d0,a1
    12f6:	|           |  |      move.b d3,(a1)
	while(len-- > 0)
    12f8:	|           |  |      btst #1,d2
    12fc:	|           |  |  ,-- beq.w 138c <memset+0xcc>
		*ptr++ = val;
    1300:	|           |  |  |   move.b d3,1(a1)
	while(len-- > 0)
    1304:	|           |  |  |   moveq #3,d2
    1306:	|           |  |  |   cmp.l d1,d2
    1308:	|  ,--------|--|--|-- bne.w 13f0 <memset+0x130>
		*ptr++ = val;
    130c:	|  |        |  |  |   lea 3(a1),a2
    1310:	|  |        |  |  |   move.b d3,2(a1)
	while(len-- > 0)
    1314:	|  |        |  |  |   lea -4(a0),a1
    1318:	|  |        |  |  |   move.l a0,d5
    131a:	|  |        |  |  |   sub.l d1,d5
    131c:	|  |        |  |  |   moveq #0,d4
    131e:	|  |        |  |  |   move.b d3,d4
    1320:	|  |        |  |  |   move.l d4,d6
    1322:	|  |        |  |  |   swap d6
    1324:	|  |        |  |  |   clr.w d6
    1326:	|  |        |  |  |   move.l d3,d2
    1328:	|  |        |  |  |   lsl.w #8,d2
    132a:	|  |        |  |  |   swap d2
    132c:	|  |        |  |  |   clr.w d2
    132e:	|  |        |  |  |   lsl.l #8,d4
    1330:	|  |        |  |  |   or.l d6,d2
    1332:	|  |        |  |  |   or.l d4,d2
    1334:	|  |        |  |  |   move.b d7,d2
    1336:	|  |        |  |  |   movea.l d0,a0
    1338:	|  |        |  |  |   adda.l d1,a0
    133a:	|  |        |  |  |   moveq #-4,d4
    133c:	|  |        |  |  |   and.l d5,d4
    133e:	|  |        |  |  |   move.l d4,d1
    1340:	|  |        |  |  |   add.l a0,d1
		*ptr++ = val;
    1342:	|  |  ,-----|--|--|-> move.l d2,(a0)+
	while(len-- > 0)
    1344:	|  |  |     |  |  |   cmp.l a0,d1
    1346:	|  |  +-----|--|--|-- bne.s 1342 <memset+0x82>
    1348:	|  |  |     |  |  |   cmp.l d4,d5
    134a:	|  |  |     |  +--|-- beq.s 1386 <memset+0xc6>
    134c:	|  |  |     |  |  |   suba.l d4,a1
    134e:	|  |  |     |  |  |   lea (0,a2,d4.l),a0
		*ptr++ = val;
    1352:	|  |  |  ,--|--|--|-> move.b d3,(a0)
	while(len-- > 0)
    1354:	|  |  |  |  |  |  |   cmpa.w #0,a1
    1358:	|  |  |  |  |  +--|-- beq.s 1386 <memset+0xc6>
		*ptr++ = val;
    135a:	|  |  |  |  |  |  |   move.b d3,1(a0)
	while(len-- > 0)
    135e:	|  |  |  |  |  |  |   moveq #1,d1
    1360:	|  |  |  |  |  |  |   cmp.l a1,d1
    1362:	|  |  |  |  |  +--|-- beq.s 1386 <memset+0xc6>
		*ptr++ = val;
    1364:	|  |  |  |  |  |  |   move.b d3,2(a0)
	while(len-- > 0)
    1368:	|  |  |  |  |  |  |   moveq #2,d2
    136a:	|  |  |  |  |  |  |   cmp.l a1,d2
    136c:	|  |  |  |  |  +--|-- beq.s 1386 <memset+0xc6>
		*ptr++ = val;
    136e:	|  |  |  |  |  |  |   move.b d3,3(a0)
	while(len-- > 0)
    1372:	|  |  |  |  |  |  |   moveq #3,d4
    1374:	|  |  |  |  |  |  |   cmp.l a1,d4
    1376:	|  |  |  |  |  +--|-- beq.s 1386 <memset+0xc6>
		*ptr++ = val;
    1378:	|  |  |  |  |  |  |   move.b d3,4(a0)
	while(len-- > 0)
    137c:	|  |  |  |  |  |  |   moveq #4,d1
    137e:	|  |  |  |  |  |  |   cmp.l a1,d1
    1380:	|  |  |  |  |  +--|-- beq.s 1386 <memset+0xc6>
		*ptr++ = val;
    1382:	|  |  |  |  |  |  |   move.b d3,5(a0)
}
    1386:	|  |  |  |  |  '--|-> movem.l (sp)+,d2-d7/a2
    138a:	|  |  |  |  |     |   rts
		*ptr++ = val;
    138c:	|  |  |  |  |     '-> lea 1(a1),a2
	while(len-- > 0)
    1390:	|  |  |  |  |         lea -2(a0),a1
    1394:	|  |  |  |  |         move.l a0,d5
    1396:	|  |  |  |  |         sub.l d1,d5
    1398:	|  |  |  |  |         moveq #0,d4
    139a:	|  |  |  |  |         move.b d3,d4
    139c:	|  |  |  |  |         move.l d4,d6
    139e:	|  |  |  |  |         swap d6
    13a0:	|  |  |  |  |         clr.w d6
    13a2:	|  |  |  |  |         move.l d3,d2
    13a4:	|  |  |  |  |         lsl.w #8,d2
    13a6:	|  |  |  |  |         swap d2
    13a8:	|  |  |  |  |         clr.w d2
    13aa:	|  |  |  |  |         lsl.l #8,d4
    13ac:	|  |  |  |  |         or.l d6,d2
    13ae:	|  |  |  |  |         or.l d4,d2
    13b0:	|  |  |  |  |         move.b d7,d2
    13b2:	|  |  |  |  |         movea.l d0,a0
    13b4:	|  |  |  |  |         adda.l d1,a0
    13b6:	|  |  |  |  |         moveq #-4,d4
    13b8:	|  |  |  |  |         and.l d5,d4
    13ba:	|  |  |  |  |         move.l d4,d1
    13bc:	|  |  |  |  |         add.l a0,d1
    13be:	|  |  +--|--|-------- bra.s 1342 <memset+0x82>
	unsigned char *ptr = (unsigned char *)dest;
    13c0:	|  |  |  |  '-------> movea.l d0,a2
    13c2:	|  |  |  |            move.l a0,d5
    13c4:	|  |  |  |            sub.l d1,d5
    13c6:	|  |  |  |            moveq #0,d4
    13c8:	|  |  |  |            move.b d3,d4
    13ca:	|  |  |  |            move.l d4,d6
    13cc:	|  |  |  |            swap d6
    13ce:	|  |  |  |            clr.w d6
    13d0:	|  |  |  |            move.l d3,d2
    13d2:	|  |  |  |            lsl.w #8,d2
    13d4:	|  |  |  |            swap d2
    13d6:	|  |  |  |            clr.w d2
    13d8:	|  |  |  |            lsl.l #8,d4
    13da:	|  |  |  |            or.l d6,d2
    13dc:	|  |  |  |            or.l d4,d2
    13de:	|  |  |  |            move.b d7,d2
    13e0:	|  |  |  |            movea.l d0,a0
    13e2:	|  |  |  |            adda.l d1,a0
    13e4:	|  |  |  |            moveq #-4,d4
    13e6:	|  |  |  |            and.l d5,d4
    13e8:	|  |  |  |            move.l d4,d1
    13ea:	|  |  |  |            add.l a0,d1
    13ec:	|  |  +--|----------- bra.w 1342 <memset+0x82>
		*ptr++ = val;
    13f0:	|  '--|--|----------> lea 2(a1),a2
	while(len-- > 0)
    13f4:	|     |  |            lea -3(a0),a1
    13f8:	|     |  |            move.l a0,d5
    13fa:	|     |  |            sub.l d1,d5
    13fc:	|     |  |            moveq #0,d4
    13fe:	|     |  |            move.b d3,d4
    1400:	|     |  |            move.l d4,d6
    1402:	|     |  |            swap d6
    1404:	|     |  |            clr.w d6
    1406:	|     |  |            move.l d3,d2
    1408:	|     |  |            lsl.w #8,d2
    140a:	|     |  |            swap d2
    140c:	|     |  |            clr.w d2
    140e:	|     |  |            lsl.l #8,d4
    1410:	|     |  |            or.l d6,d2
    1412:	|     |  |            or.l d4,d2
    1414:	|     |  |            move.b d7,d2
    1416:	|     |  |            movea.l d0,a0
    1418:	|     |  |            adda.l d1,a0
    141a:	|     |  |            moveq #-4,d4
    141c:	|     |  |            and.l d5,d4
    141e:	|     |  |            move.l d4,d1
    1420:	|     |  |            add.l a0,d1
    1422:	|     '--|----------- bra.w 1342 <memset+0x82>
	unsigned char *ptr = (unsigned char *)dest;
    1426:	'--------|----------> movea.l d0,a0
    1428:	         '----------- bra.w 1352 <memset+0x92>

0000142c <__mulsi3>:
	.section .text.__mulsi3,"ax",@progbits
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    142c:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1430:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1434:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    1438:	mulu.w 8(sp),d1
	addw	d1, d0
    143c:	add.w d1,d0
	swap	d0
    143e:	swap d0
	clrw	d0
    1440:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1442:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    1446:	mulu.w 10(sp),d1
	addl	d1, d0
    144a:	add.l d1,d0
	rts
    144c:	rts

0000144e <__udivsi3>:
	.section .text.__udivsi3,"ax",@progbits
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    144e:	       move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1450:	       move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1454:	       move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    1458:	       cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    145e:	   ,-- bcc.s 1476 <__udivsi3+0x28>
	movel	d0, d2
    1460:	   |   move.l d0,d2
	clrw	d2
    1462:	   |   clr.w d2
	swap	d2
    1464:	   |   swap d2
	divu	d1, d2          /* high quotient in lower word */
    1466:	   |   divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    1468:	   |   move.w d2,d0
	swap	d0
    146a:	   |   swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    146c:	   |   move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1470:	   |   divu.w d1,d2
	movew	d2, d0
    1472:	   |   move.w d2,d0
	jra	6f
    1474:	,--|-- bra.s 14a6 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    1476:	|  '-> move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    1478:	|  ,-> lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    147a:	|  |   lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    147c:	|  |   cmpi.l #65536,d1
	jcc	4b
    1482:	|  '-- bcc.s 1478 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    1484:	|      divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    1486:	|      andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    148c:	|      move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    148e:	|      mulu.w d0,d1
	swap	d2
    1490:	|      swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    1492:	|      mulu.w d0,d2
	swap	d2		/* align high part with low part */
    1494:	|      swap d2
	tstw	d2		/* high part 17 bits? */
    1496:	|      tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    1498:	|  ,-- bne.s 14a4 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    149a:	|  |   add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    149c:	|  +-- bcs.s 14a4 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    149e:	|  |   cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    14a2:	+--|-- bls.s 14a6 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    14a4:	|  '-> subq.l #1,d0

6:	movel	sp@+, d2
    14a6:	'----> move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    14a8:	       rts

000014aa <__umodsi3>:
	.section .text.__umodsi3,"ax",@progbits
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    14aa:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    14ae:	move.l 4(sp),d0
	movel	d1, sp@-
    14b2:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    14b4:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    14b6:	jsr 144e <__udivsi3>
	addql	#8, sp
    14bc:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    14be:	move.l 8(sp),d1
	movel	d1, sp@-
    14c2:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    14c4:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    14c6:	jsr 142c <__mulsi3>
	addql	#8, sp
    14cc:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    14ce:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    14d2:	sub.l d0,d1
	movel	d1, d0
    14d4:	move.l d1,d0
	rts
    14d6:	rts

000014d8 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    14d8:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    14da:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    14de:	jsr -516(a6)
    move.l (sp)+, a6
    14e2:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    14e4:	rts

000014e6 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    14e6:	move.b d0,(a3)+
	rts
    14e8:	rts
