
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
       4:	       move.l #20792,d3
       a:	       subi.l #20792,d3
      10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	       move.l #20792,d0
      18:	       cmpi.l #20792,d0
      1e:	/----- beq.s 32 <_start+0x32>
      20:	|      lea 5138 <incbin_image_start>,a2
      26:	|      moveq #0,d2
		__preinit_array_start[i]();
      28:	|  /-> movea.l (a2)+,a0
      2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
      2c:	|  |   addq.l #1,d2
      2e:	|  |   cmp.l d3,d2
      30:	|  \-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
      32:	\----> move.l #20792,d3
      38:	       subi.l #20792,d3
      3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
      40:	       move.l #20792,d0
      46:	       cmpi.l #20792,d0
      4c:	/----- beq.s 60 <_start+0x60>
      4e:	|      lea 5138 <incbin_image_start>,a2
      54:	|      moveq #0,d2
		__init_array_start[i]();
      56:	|  /-> movea.l (a2)+,a0
      58:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
      5a:	|  |   addq.l #1,d2
      5c:	|  |   cmp.l d3,d2
      5e:	|  \-- bcs.s 56 <_start+0x56>

	main();
      60:	\----> jsr 8c <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      66:	       move.l #20792,d2
      6c:	       subi.l #20792,d2
      72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
      74:	/----- beq.s 86 <_start+0x86>
      76:	|      lea 5138 <incbin_image_start>,a2
		__fini_array_start[i - 1]();
      7c:	|  /-> subq.l #1,d2
      7e:	|  |   movea.l -(a2),a0
      80:	|  |   jsr (a0)
	for (i = count; i > 0; i--)
      82:	|  |   tst.l d2
      84:	|  \-- bne.s 7c <_start+0x7c>
}
      86:	\----> movem.l (sp)+,d2-d3/a2
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
      98:	                                                          move.l a6,13cd0 <SysBase>
	custom = (struct Custom*)0xdff000;
      9e:	                                                          move.l #14675968,13cda <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR)"graphics.library",0);
      a8:	                                                          lea 2f6a <incbin_player_end+0xd4>,a1
      ae:	                                                          moveq #0,d0
      b0:	                                                          jsr -552(a6)
      b4:	                                                          move.l d0,13ccc <GfxBase>
	if (!GfxBase)
      ba:	      /-------------------------------------------------- beq.w c5e <main+0xbd2>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
      be:	      |                                                   movea.l 13cd0 <SysBase>,a6
      c4:	      |                                                   lea 2f7b <incbin_player_end+0xe5>,a1
      ca:	      |                                                   moveq #0,d0
      cc:	      |                                                   jsr -552(a6)
      d0:	      |                                                   move.l d0,13cc8 <DOSBase>
	if (!DOSBase)
      d6:	/-----|-------------------------------------------------- beq.w bea <main+0xb5e>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      da:	|  /--|-------------------------------------------------> pea 2f87 <incbin_player_end+0xf1>
      e0:	|  |  |                                                   jsr f94 <KPrintF>
#endif
	Write(Output(), (APTR)"Hello console!\n", 15);
      e6:	|  |  |                                                   movea.l 13cc8 <DOSBase>,a6
      ec:	|  |  |                                                   jsr -60(a6)
      f0:	|  |  |                                                   movea.l 13cc8 <DOSBase>,a6
      f6:	|  |  |                                                   move.l d0,d1
      f8:	|  |  |                                                   move.l #12195,d2
      fe:	|  |  |                                                   moveq #15,d3
     100:	|  |  |                                                   jsr -48(a6)
	Delay(2000);
     104:	|  |  |                                                   movea.l 13cc8 <DOSBase>,a6
     10a:	|  |  |                                                   move.l #2000,d1
     110:	|  |  |                                                   jsr -198(a6)

	warpmode(1);
     114:	|  |  |                                                   pea 1 <_start+0x1>
     118:	|  |  |                                                   lea 1006 <warpmode>,a4
     11e:	|  |  |                                                   jsr (a4)
		register volatile const void* _a0 ASM("a0") = module;
     120:	|  |  |                                                   lea 1283c <incbin_module_start>,a0
		register volatile const void* _a1 ASM("a1") = NULL;
     126:	|  |  |                                                   suba.l a1,a1
		register volatile const void* _a2 ASM("a2") = NULL;
     128:	|  |  |                                                   suba.l a2,a2
		register volatile const void* _a3 ASM("a3") = player;
     12a:	|  |  |                                                   lea 1530 <incbin_player_start>,a3
		__asm volatile (
     130:	|  |  |                                                   movem.l d1-d7/a4-a6,-(sp)
     134:	|  |  |                                                   jsr (a3)
     136:	|  |  |                                                   movem.l (sp)+,d1-d7/a4-a6
	// TODO: precalc stuff here
#ifdef MUSIC
	if(p61Init(module) != 0)
     13a:	|  |  |                                                   addq.l #8,sp
     13c:	|  |  |                                                   tst.l d0
     13e:	|  |  |  /----------------------------------------------- bne.w b3a <main+0xaae>
		KPrintF("p61Init failed!\n");
#endif
	warpmode(0);
     142:	|  |  |  |  /-------------------------------------------> clr.l -(sp)
     144:	|  |  |  |  |                                             jsr (a4)
	Forbid();
     146:	|  |  |  |  |                                             movea.l 13cd0 <SysBase>,a6
     14c:	|  |  |  |  |                                             jsr -132(a6)
	SystemADKCON=custom->adkconr;
     150:	|  |  |  |  |                                             movea.l 13cda <custom>,a0
     156:	|  |  |  |  |                                             move.w 16(a0),d0
     15a:	|  |  |  |  |                                             move.w d0,13cba <SystemADKCON>
	SystemInts=custom->intenar;
     160:	|  |  |  |  |                                             move.w 28(a0),d0
     164:	|  |  |  |  |                                             move.w d0,13cbe <SystemInts>
	SystemDMA=custom->dmaconr;
     16a:	|  |  |  |  |                                             move.w 2(a0),d0
     16e:	|  |  |  |  |                                             move.w d0,13cbc <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
     174:	|  |  |  |  |                                             movea.l 13ccc <GfxBase>,a6
     17a:	|  |  |  |  |                                             move.l 34(a6),13cb6 <ActiView>
	LoadView(0);
     182:	|  |  |  |  |                                             suba.l a1,a1
     184:	|  |  |  |  |                                             jsr -222(a6)
	WaitTOF();
     188:	|  |  |  |  |                                             movea.l 13ccc <GfxBase>,a6
     18e:	|  |  |  |  |                                             jsr -270(a6)
	WaitTOF();
     192:	|  |  |  |  |                                             movea.l 13ccc <GfxBase>,a6
     198:	|  |  |  |  |                                             jsr -270(a6)
	WaitVbl();
     19c:	|  |  |  |  |                                             lea eda <WaitVbl>,a2
     1a2:	|  |  |  |  |                                             jsr (a2)
	WaitVbl();
     1a4:	|  |  |  |  |                                             jsr (a2)
	OwnBlitter();
     1a6:	|  |  |  |  |                                             movea.l 13ccc <GfxBase>,a6
     1ac:	|  |  |  |  |                                             jsr -456(a6)
	WaitBlit();	
     1b0:	|  |  |  |  |                                             movea.l 13ccc <GfxBase>,a6
     1b6:	|  |  |  |  |                                             jsr -228(a6)
	Disable();
     1ba:	|  |  |  |  |                                             movea.l 13cd0 <SysBase>,a6
     1c0:	|  |  |  |  |                                             jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
     1c4:	|  |  |  |  |                                             movea.l 13cda <custom>,a0
     1ca:	|  |  |  |  |                                             move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
     1d0:	|  |  |  |  |                                             move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
     1d6:	|  |  |  |  |                                             move.w #32767,150(a0)
     1dc:	|  |  |  |  |                                             addq.l #4,sp
	for(int a=0;a<32;a++)
     1de:	|  |  |  |  |                                             moveq #0,d1
		custom->color[a]=0;
     1e0:	|  |  |  |  |        /----------------------------------> move.l d1,d0
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
     20e:	|  |  |  |  |        |                                    movea.l 13cd0 <SysBase>,a6
     214:	|  |  |  |  |        |                                    btst #0,297(a6)
     21a:	|  |  |  |  |  /-----|----------------------------------- beq.w c8a <main+0xbfe>
		vbr = (APTR)Supervisor((ULONG (*)())getvbr);
     21e:	|  |  |  |  |  |     |                                    moveq #-50,d7
     220:	|  |  |  |  |  |     |                                    add.l a5,d7
     222:	|  |  |  |  |  |     |                                    exg d7,a5
     224:	|  |  |  |  |  |     |                                    jsr -30(a6)
     228:	|  |  |  |  |  |     |                                    exg d7,a5
	VBR=GetVBR();
     22a:	|  |  |  |  |  |     |                                    move.l d0,13cc4 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
     230:	|  |  |  |  |  |     |                                    movea.l 13cc4 <VBR>,a0
     236:	|  |  |  |  |  |     |                                    move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
     23a:	|  |  |  |  |  |     |                                    move.l d0,13cc0 <SystemIrq>

	TakeSystem();
	WaitVbl();
     240:	|  |  |  |  |  |     |                                    jsr (a2)

	char* test = (char*)AllocMem(2502, MEMF_ANY);
     242:	|  |  |  |  |  |     |                                    movea.l 13cd0 <SysBase>,a6
     248:	|  |  |  |  |  |     |                                    move.l #2502,d0
     24e:	|  |  |  |  |  |     |                                    moveq #0,d1
     250:	|  |  |  |  |  |     |                                    jsr -198(a6)
     254:	|  |  |  |  |  |     |                                    move.l d0,d4
	memset(test, 0xcd, 2502);
     256:	|  |  |  |  |  |     |                                    pea 9c6 <main+0x93a>
     25a:	|  |  |  |  |  |     |                                    pea cd <main+0x41>
     25e:	|  |  |  |  |  |     |                                    move.l d0,-(sp)
     260:	|  |  |  |  |  |     |                                    jsr 12c4 <memset>
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
     280:	|  |  |  |  |  |     |                             /----- blt.w 2d4 <main+0x248>
     284:	|  |  |  |  |  |     |                             |  /-> movem.l d0-d3,-(a0)
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
     2d0:	|  |  |  |  |  |     |                             |  \-- bge.w 284 <main+0x1f8>
     2d4:	|  |  |  |  |  |     |                             >----> cmpi.w #64,d5
     2d8:	|  |  |  |  |  |     |                             |  /-- blt.w 2f4 <main+0x268>
     2dc:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2e0:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2e4:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2e8:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2ec:	|  |  |  |  |  |     |                             |  |   subi.w #64,d5
     2f0:	|  |  |  |  |  |     |                             \--|-- bra.w 2d4 <main+0x248>
     2f4:	|  |  |  |  |  |     |                                \-> lsr.w #2,d5
     2f6:	|  |  |  |  |  |     |                                /-- bcc.w 2fc <main+0x270>
     2fa:	|  |  |  |  |  |     |                                |   move.w d0,-(a0)
     2fc:	|  |  |  |  |  |     |                                \-> moveq #16,d1
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
     326:	|  |  |  |  |  |     |                                    movea.l 13cd0 <SysBase>,a6
     32c:	|  |  |  |  |  |     |                                    movea.l d4,a1
     32e:	|  |  |  |  |  |     |                                    move.l #2502,d0
     334:	|  |  |  |  |  |     |                                    jsr -210(a6)

	USHORT* copper1 = (USHORT*)AllocMem(1024, MEMF_CHIP);
     338:	|  |  |  |  |  |     |                                    movea.l 13cd0 <SysBase>,a6
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
     358:	|  |  |  |  |  |     |                                    pea 2fc4 <incbin_player_end+0x12e>
     35e:	|  |  |  |  |  |     |                                    pea 5138 <incbin_image_start>
     364:	|  |  |  |  |  |     |                                    lea 1162 <debug_register_bitmap.constprop.0>,a4
     36a:	|  |  |  |  |  |     |                                    jsr (a4)
	debug_register_bitmap(bob, "bob.bpl", 32, 96, 5, debug_resource_bitmap_interleaved | debug_resource_bitmap_masked);
     36c:	|  |  |  |  |  |     |                                    lea 32(sp),sp
     370:	|  |  |  |  |  |     |                                    pea 3 <_start+0x3>
     374:	|  |  |  |  |  |     |                                    pea 60 <_start+0x60>
     378:	|  |  |  |  |  |     |                                    pea 20 <_start+0x20>
     37c:	|  |  |  |  |  |     |                                    pea 2fce <incbin_player_end+0x138>
     382:	|  |  |  |  |  |     |                                    pea 1193a <incbin_bob_start>
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
     3b6:	|  |  |  |  |  |     |                                    move.l #5358,d3
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
     3d8:	|  |  |  |  |  |     |                                    lea -42(a5),a0
     3dc:	|  |  |  |  |  |     |                                    lea 2f60 <incbin_player_end+0xca>,a1
	while(*source && --num > 0)
     3e2:	|  |  |  |  |  |     |                                    lea -11(a5),a4
		*destination++ = *source++;
     3e6:	|  |  |  |  |  |  /--|----------------------------------> addq.l #1,a1
     3e8:	|  |  |  |  |  |  |  |                                    move.b d0,(a0)+
	while(*source && --num > 0)
     3ea:	|  |  |  |  |  |  |  |                                    move.b (a1),d0
     3ec:	|  |  |  |  |  |  |  |                                /-- beq.s 3f2 <main+0x366>
     3ee:	|  |  |  |  |  |  |  |                                |   cmpa.l a0,a4
     3f0:	|  |  |  |  |  |  +--|--------------------------------|-- bne.s 3e6 <main+0x35a>
	*destination = '\0';
     3f2:	|  |  |  |  |  |  |  |                                \-> clr.b (a0)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     3f4:	|  |  |  |  |  |  |  |                                    move.w f0ff60 <_end+0xefc280>,d0
     3fa:	|  |  |  |  |  |  |  |                                    cmpi.w #20153,d0
     3fe:	|  |  |  |  |  |  |  |     /----------------------------- beq.w 9ce <main+0x942>
     402:	|  |  |  |  |  |  |  |     |                              cmpi.w #-24562,d0
     406:	|  |  |  |  |  |  |  |     +----------------------------- beq.w 9ce <main+0x942>
	debug_register_palette(colors, "image.pal", 32, 0);
	debug_register_copperlist(copper1, "copper1", 1024, 0);
     40a:	|  |  |  |  |  |  |  |     |                              pea 400 <main+0x374>
     40e:	|  |  |  |  |  |  |  |     |                              pea 2fd6 <incbin_player_end+0x140>
     414:	|  |  |  |  |  |  |  |     |                              move.l a3,-(sp)
     416:	|  |  |  |  |  |  |  |     |                              lea 122a <debug_register_copperlist.constprop.0>,a4
     41c:	|  |  |  |  |  |  |  |     |                              jsr (a4)
	debug_register_copperlist(copper2, "copper2", sizeof(copper2), 0);
     41e:	|  |  |  |  |  |  |  |     |                              pea 80 <_start+0x80>
     422:	|  |  |  |  |  |  |  |     |                              pea 2fde <incbin_player_end+0x148>
     428:	|  |  |  |  |  |  |  |     |                              pea 30b8 <copper2>
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
     474:	|  |  |  |  |  |  |  |     |                              move.l a0,13cd6 <scroll>
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
     4a2:	|  |  |  |  |  |  |  |     |                              move.l #20792,d0
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
     4c2:	|  |  |  |  |  |  |  |     |                              move.l #20832,d0
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
     4e2:	|  |  |  |  |  |  |  |     |                              move.l #20872,d0
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
     502:	|  |  |  |  |  |  |  |     |                              move.l #20912,d0
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
     522:	|  |  |  |  |  |  |  |     |                              move.l #20952,d0
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
     546:	|  |  |  |  |  |  |  |     |                              move.l #5422,d2
     54c:	|  |  |  |  |  |  |  |     |                              lea 24(sp),sp
		*copListEnd++=(UWORD)addr;
     550:	|  |  |  |  |  |  |  |     |                              lea 14ee <incbin_colors_start>,a0
     556:	|  |  |  |  |  |  |  |     |                              move.w #382,d0
     55a:	|  |  |  |  |  |  |  |     |                              sub.w d3,d0
		planes[a]=(UBYTE*)image + lineSize * a;
	copPtr = copSetPlanes(0, copPtr, planes, 5);

	// set colors
	for(int a=0; a < 32; a++)
		copPtr = copSetColor(copPtr, a, ((USHORT*)colors)[a]);
     55c:	|  |  |  |  |  |  |  |  /--|----------------------------> move.w (a0)+,d1
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
     57a:	|  |  |  |  |  |  |  |  |  |                              movea.l 13cda <custom>,a0
     580:	|  |  |  |  |  |  |  |  |  |                              move.l a3,128(a0)
	custom->cop2lc = (ULONG)copper2;
     584:	|  |  |  |  |  |  |  |  |  |                              move.l #12472,132(a0)
	custom->dmacon = DMAF_BLITTER;//disable blitter dma for copjmp bug
     58c:	|  |  |  |  |  |  |  |  |  |                              move.w #64,150(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     592:	|  |  |  |  |  |  |  |  |  |                              move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER;
     598:	|  |  |  |  |  |  |  |  |  |                              move.w #-31808,150(a0)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
     59e:	|  |  |  |  |  |  |  |  |  |                              movea.l 13cc4 <VBR>,a1
     5a4:	|  |  |  |  |  |  |  |  |  |                              move.l #3660,108(a1)

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
     5be:	|  |  |  |  |  |  |  |  |  |                              move.b bfe001 <_end+0xbea321>,d0

	while(!MouseLeft()) {
     5c4:	|  |  |  |  |  |  |  |  |  |                              btst #6,d0
     5c8:	|  |  |  |  |  |  |  |  |  |  /-------------------------- beq.w 750 <main+0x6c4>
     5cc:	|  |  |  |  |  |  |  |  |  |  |                           lea 14ae <__umodsi3>,a4
     5d2:	|  |  |  |  |  |  |  |  |  |  |                           lea 3005 <sinus40>,a3
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     5d8:	|  |  |  |  |  |  |  |  |  |  |  /----------------------> move.l dff004 <_end+0xdeb324>,d0
     5de:	|  |  |  |  |  |  |  |  |  |  |  |                        move.l d0,-50(a5)
		if(((vpos >> 8) & 511) == line)
     5e2:	|  |  |  |  |  |  |  |  |  |  |  |                        move.l -50(a5),d0
     5e6:	|  |  |  |  |  |  |  |  |  |  |  |                        andi.l #130816,d0
     5ec:	|  |  |  |  |  |  |  |  |  |  |  |                        cmpi.l #4096,d0
     5f2:	|  |  |  |  |  |  |  |  |  |  |  +----------------------- bne.s 5d8 <main+0x54c>
		Wait10();
		int f = frameCounter & 255;
     5f4:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w 13cd4 <frameCounter>,d7

		// clear
		WaitBlit();
     5fa:	|  |  |  |  |  |  |  |  |  |  |  |                        movea.l 13ccc <GfxBase>,a6
     600:	|  |  |  |  |  |  |  |  |  |  |  |                        jsr -228(a6)
		custom->bltcon0 = A_TO_D | DEST;
     604:	|  |  |  |  |  |  |  |  |  |  |  |                        movea.l 13cda <custom>,a0
     60a:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #496,64(a0)
		custom->bltcon1 = 0;
     610:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #0,66(a0)
		custom->bltadat = 0;
     616:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #0,116(a0)
		custom->bltdpt = (UBYTE*)image + 320 / 8 * 200 * 5;
     61c:	|  |  |  |  |  |  |  |  |  |  |  |                        move.l #60792,84(a0)
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
     640:	|  |  |  |  |  |  |  |  |  |  |  |                    /-> movea.w 13cd4 <frameCounter>,a0
     646:	|  |  |  |  |  |  |  |  |  |  |  |                    |   pea 33 <_start+0x33>
     64a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.w a0,a6
     64c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   pea (0,a6,d5.l)
     650:	|  |  |  |  |  |  |  |  |  |  |  |                    |   jsr (a4)
     652:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #8,sp
     654:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lea 3045 <sinus32>,a0
     65a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #0,d3
     65c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.b (0,a0,d0.l),d3
     660:	|  |  |  |  |  |  |  |  |  |  |  |                    |   add.l d6,d3
     662:	|  |  |  |  |  |  |  |  |  |  |  |                    |   add.w d3,d3
			const short y = sinus40[((frameCounter + i) * 2) & 63] / 2;
     664:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.w 13cd4 <frameCounter>,a0
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
     68e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addi.l #71994,d4

			WaitBlit();
     694:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.l 13ccc <GfxBase>,a6
     69a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   jsr -228(a6)
			custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | ((x & 15) << ASHIFTSHIFT); // A = source, B = mask, C = background, D = destination
     69e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.l 13cda <custom>,a0
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
     6da:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d2,d0
     6dc:	|  |  |  |  |  |  |  |  |  |  |  |                    |   add.l d2,d0
     6de:	|  |  |  |  |  |  |  |  |  |  |  |                    |   add.l d2,d0
     6e0:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lsl.l #3,d0
     6e2:	|  |  |  |  |  |  |  |  |  |  |  |                    |   add.l d2,d0
     6e4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lsl.l #3,d0
     6e6:	|  |  |  |  |  |  |  |  |  |  |  |                    |   asr.w #3,d3
     6e8:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d3,d1
     6ea:	|  |  |  |  |  |  |  |  |  |  |  |                    |   ext.l d1
     6ec:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.l d0,a6
     6ee:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lea (0,a6,d1.l),a1
     6f2:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l a1,d0
     6f4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addi.l #20792,d0
     6fa:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d0,84(a0)
     6fe:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d0,72(a0)
			custom->bltcmod = custom->bltdmod = (320 - 32) / 8;
     702:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #36,102(a0)
     708:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #36,96(a0)
			custom->bltafwm = custom->bltalwm = 0xffff;
     70e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #-1,70(a0)
     714:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #-1,68(a0)
			custom->bltsize = ((16 * 5) << HSIZEBITS) | (32/16);
     71a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #5122,88(a0)
		for(short i = 0; i < 16; i++) {
     720:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #1,d5
     722:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #8,d6
     724:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #16,d3
     726:	|  |  |  |  |  |  |  |  |  |  |  |                    |   cmp.l d5,d3
     728:	|  |  |  |  |  |  |  |  |  |  |  |                    \-- bne.w 640 <main+0x5b4>
     72c:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w f0ff60 <_end+0xefc280>,d0
     732:	|  |  |  |  |  |  |  |  |  |  |  |                        cmpi.w #20153,d0
     736:	|  |  |  |  |  |  |  |  |  |  |  |                    /-- beq.w 84e <main+0x7c2>
     73a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   cmpi.w #-24562,d0
     73e:	|  |  |  |  |  |  |  |  |  |  |  |                    +-- beq.w 84e <main+0x7c2>
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
     742:	|  |  |  |  |  |  |  |  |  |  |  |  /-----------------|-> move.b bfe001 <_end+0xbea321>,d0
	while(!MouseLeft()) {
     748:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   btst #6,d0
     74c:	|  |  |  |  |  |  |  |  |  |  |  +--|-----------------|-- bne.w 5d8 <main+0x54c>
		register volatile const void* _a3 ASM("a3") = player;
     750:	|  |  |  |  |  |  |  |  |  |  >--|--|-----------------|-> lea 1530 <incbin_player_start>,a3
		register volatile const void* _a6 ASM("a6") = (void*)0xdff000;
     756:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l #14675968,a6
		__asm volatile (
     75c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movem.l d0-d1/a0-a1,-(sp)
     760:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr 8(a3)
     764:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movem.l (sp)+,d0-d1/a0-a1
	WaitVbl();
     768:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr (a2)
	WaitBlit();
     76a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <GfxBase>,a6
     770:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -228(a6)
	custom->intena=0x7fff;//disable all interrupts
     774:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cda <custom>,a0
     77a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
     780:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
     786:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,150(a0)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
     78c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc4 <VBR>,a1
     792:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.l 13cc0 <SystemIrq>,108(a1)
	custom->cop1lc=(ULONG)GfxBase->copinit;
     79a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <GfxBase>,a6
     7a0:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.l 38(a6),128(a0)
	custom->cop2lc=(ULONG)GfxBase->LOFlist;
     7a6:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.l 50(a6),132(a0)
	custom->copjmp1=0x7fff; //start coppper
     7ac:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,136(a0)
	custom->intena=SystemInts|0x8000;
     7b2:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w 13cbe <SystemInts>,d0
     7b8:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
     7bc:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w d0,154(a0)
	custom->dmacon=SystemDMA|0x8000;
     7c0:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w 13cbc <SystemDMA>,d0
     7c6:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
     7ca:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w d0,150(a0)
	custom->adkcon=SystemADKCON|0x8000;
     7ce:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w 13cba <SystemADKCON>,d0
     7d4:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
     7d8:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w d0,158(a0)
	WaitBlit();	
     7dc:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -228(a6)
	DisownBlitter();
     7e0:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <GfxBase>,a6
     7e6:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -462(a6)
	Enable();
     7ea:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cd0 <SysBase>,a6
     7f0:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -126(a6)
	LoadView(ActiView);
     7f4:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <GfxBase>,a6
     7fa:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cb6 <ActiView>,a1
     800:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -222(a6)
	WaitTOF();
     804:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <GfxBase>,a6
     80a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -270(a6)
	WaitTOF();
     80e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <GfxBase>,a6
     814:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -270(a6)
	Permit();
     818:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cd0 <SysBase>,a6
     81e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -138(a6)
#endif

	// END
	FreeSystem();

	CloseLibrary((struct Library*)DOSBase);
     822:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cd0 <SysBase>,a6
     828:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc8 <DOSBase>,a1
     82e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -414(a6)
	CloseLibrary((struct Library*)GfxBase);
     832:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cd0 <SysBase>,a6
     838:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13ccc <GfxBase>,a1
     83e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -414(a6)
}
     842:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   moveq #0,d0
     844:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movem.l -92(a5),d2-d7/a2-a4/a6
     84a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   unlk a5
     84c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   rts
		UaeLib(88, arg1, arg2, arg3, arg4);
     84e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 \-> clr.l -(sp)
     850:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.l -(sp)
     852:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.l -(sp)
     854:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.l -(sp)
     856:	|  |  |  |  |  |  |  |  |  |  |  |  |                     pea 58 <_start+0x58>
     85a:	|  |  |  |  |  |  |  |  |  |  |  |  |                     movea.l #15794016,a6
     860:	|  |  |  |  |  |  |  |  |  |  |  |  |                     jsr (a6)
		debug_filled_rect(f + 100, 200*2, f + 400, 220*2, 0x0000ff00); // 0x00RRGGBB
     862:	|  |  |  |  |  |  |  |  |  |  |  |  |                     andi.w #255,d7
     866:	|  |  |  |  |  |  |  |  |  |  |  |  |                     move.w d7,d2
     868:	|  |  |  |  |  |  |  |  |  |  |  |  |                     addi.w #400,d2
	debug_cmd(barto_cmd_filled_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
     86c:	|  |  |  |  |  |  |  |  |  |  |  |  |                     swap d2
     86e:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.w d2
     870:	|  |  |  |  |  |  |  |  |  |  |  |  |                     ori.w #440,d2
     874:	|  |  |  |  |  |  |  |  |  |  |  |  |                     move.w d7,d0
     876:	|  |  |  |  |  |  |  |  |  |  |  |  |                     addi.w #100,d0
     87a:	|  |  |  |  |  |  |  |  |  |  |  |  |                     swap d0
     87c:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.w d0
     87e:	|  |  |  |  |  |  |  |  |  |  |  |  |                     ori.w #400,d0
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     882:	|  |  |  |  |  |  |  |  |  |  |  |  |                     move.w (a6),d1
     884:	|  |  |  |  |  |  |  |  |  |  |  |  |                     lea 20(sp),sp
     888:	|  |  |  |  |  |  |  |  |  |  |  |  |                     cmpi.w #20153,d1
     88c:	|  |  |  |  |  |  |  |  |  |  |  |  |              /----- bne.w 952 <main+0x8c6>
		UaeLib(88, arg1, arg2, arg3, arg4);
     890:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.l #65280,-(sp)
     896:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.l d2,-(sp)
     898:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.l d0,-(sp)
     89a:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      pea 2 <_start+0x2>
     89e:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      pea 58 <_start+0x58>
     8a2:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      movea.l #15794016,a6
     8a8:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      jsr (a6)
		debug_rect(f + 90, 190*2, f + 400, 220*2, 0x000000ff); // 0x00RRGGBB
     8aa:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.w d7,d0
     8ac:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      addi.w #90,d0
	debug_cmd(barto_cmd_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
     8b0:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      swap d0
     8b2:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      clr.w d0
     8b4:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      ori.w #380,d0
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     8b8:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.w (a6),d1
     8ba:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      lea 20(sp),sp
     8be:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      cmpi.w #20153,d1
     8c2:	|  |  |  |  |  |  |  |  |  |  |  |  |        /-----|----- bne.w 990 <main+0x904>
		UaeLib(88, arg1, arg2, arg3, arg4);
     8c6:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  /--|----> pea ff <main+0x73>
     8ca:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      move.l d2,-(sp)
     8cc:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      move.l d0,-(sp)
     8ce:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      pea 1 <_start+0x1>
     8d2:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      pea 58 <_start+0x58>
     8d6:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      movea.l #15794016,a6
     8dc:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      jsr (a6)
		debug_text(f+ 130, 209*2, "This is a WinUAE debug overlay", 0x00ff00ff);
     8de:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      addi.w #130,d7
	debug_cmd(barto_cmd_text, (((unsigned int)left) << 16) | ((unsigned int)top), (unsigned int)text, color);
     8e2:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      swap d7
     8e4:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      clr.w d7
     8e6:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      ori.w #418,d7
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     8ea:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      move.w (a6),d0
     8ec:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      lea 20(sp),sp
     8f0:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      cmpi.w #20153,d0
     8f4:	|  |  |  |  |  |  |  |  |  |  |  |  |  /-----|--|--|----- bne.s 928 <main+0x89c>
		UaeLib(88, arg1, arg2, arg3, arg4);
     8f6:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  /--|--|--|----> move.l #16711935,-(sp)
     8fc:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      pea 2fe6 <incbin_player_end+0x150>
     902:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      move.l d7,-(sp)
     904:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      pea 3 <_start+0x3>
     908:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      pea 58 <_start+0x58>
     90c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      jsr f0ff60 <_end+0xefc280>
}
     912:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      lea 20(sp),sp
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
     916:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /-> move.b bfe001 <_end+0xbea321>,d0
	while(!MouseLeft()) {
     91c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   btst #6,d0
     920:	|  |  |  |  |  |  |  |  |  |  |  \--|--|--|--|--|--|--|-- bne.w 5d8 <main+0x54c>
     924:	|  |  |  |  |  |  |  |  |  |  \-----|--|--|--|--|--|--|-- bra.w 750 <main+0x6c4>
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     928:	|  |  |  |  |  |  |  |  |  |        |  >--|--|--|--|--|-> cmpi.w #-24562,d0
     92c:	|  |  |  |  |  |  |  |  |  |        +--|--|--|--|--|--|-- bne.w 742 <main+0x6b6>
		UaeLib(88, arg1, arg2, arg3, arg4);
     930:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   move.l #16711935,-(sp)
     936:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   pea 2fe6 <incbin_player_end+0x150>
     93c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   move.l d7,-(sp)
     93e:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   pea 3 <_start+0x3>
     942:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   pea 58 <_start+0x58>
     946:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   jsr f0ff60 <_end+0xefc280>
}
     94c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   lea 20(sp),sp
     950:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  \-- bra.s 916 <main+0x88a>
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     952:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  \----> cmpi.w #-24562,d1
     956:	|  |  |  |  |  |  |  |  |  |        +--|--|--|--|-------- bne.w 742 <main+0x6b6>
		UaeLib(88, arg1, arg2, arg3, arg4);
     95a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.l #65280,-(sp)
     960:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.l d2,-(sp)
     962:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.l d0,-(sp)
     964:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         pea 2 <_start+0x2>
     968:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         pea 58 <_start+0x58>
     96c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         movea.l #15794016,a6
     972:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         jsr (a6)
		debug_rect(f + 90, 190*2, f + 400, 220*2, 0x000000ff); // 0x00RRGGBB
     974:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.w d7,d0
     976:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         addi.w #90,d0
	debug_cmd(barto_cmd_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
     97a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         swap d0
     97c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         clr.w d0
     97e:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         ori.w #380,d0
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     982:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.w (a6),d1
     984:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         lea 20(sp),sp
     988:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         cmpi.w #20153,d1
     98c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  \-------- beq.w 8c6 <main+0x83a>
     990:	|  |  |  |  |  |  |  |  |  |        |  |  |  \----------> cmpi.w #-24562,d1
     994:	|  |  |  |  |  |  |  |  |  |        \--|--|-------------- bne.w 742 <main+0x6b6>
		UaeLib(88, arg1, arg2, arg3, arg4);
     998:	|  |  |  |  |  |  |  |  |  |           |  |               pea ff <main+0x73>
     99c:	|  |  |  |  |  |  |  |  |  |           |  |               move.l d2,-(sp)
     99e:	|  |  |  |  |  |  |  |  |  |           |  |               move.l d0,-(sp)
     9a0:	|  |  |  |  |  |  |  |  |  |           |  |               pea 1 <_start+0x1>
     9a4:	|  |  |  |  |  |  |  |  |  |           |  |               pea 58 <_start+0x58>
     9a8:	|  |  |  |  |  |  |  |  |  |           |  |               movea.l #15794016,a6
     9ae:	|  |  |  |  |  |  |  |  |  |           |  |               jsr (a6)
		debug_text(f+ 130, 209*2, "This is a WinUAE debug overlay", 0x00ff00ff);
     9b0:	|  |  |  |  |  |  |  |  |  |           |  |               addi.w #130,d7
	debug_cmd(barto_cmd_text, (((unsigned int)left) << 16) | ((unsigned int)top), (unsigned int)text, color);
     9b4:	|  |  |  |  |  |  |  |  |  |           |  |               swap d7
     9b6:	|  |  |  |  |  |  |  |  |  |           |  |               clr.w d7
     9b8:	|  |  |  |  |  |  |  |  |  |           |  |               ori.w #418,d7
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     9bc:	|  |  |  |  |  |  |  |  |  |           |  |               move.w (a6),d0
     9be:	|  |  |  |  |  |  |  |  |  |           |  |               lea 20(sp),sp
     9c2:	|  |  |  |  |  |  |  |  |  |           |  |               cmpi.w #20153,d0
     9c6:	|  |  |  |  |  |  |  |  |  |           |  \-------------- beq.w 8f6 <main+0x86a>
     9ca:	|  |  |  |  |  |  |  |  |  |           \----------------- bra.w 928 <main+0x89c>
     9ce:	|  |  |  |  |  |  |  |  |  \----------------------------> clr.l -(sp)
     9d0:	|  |  |  |  |  |  |  |  |                                 clr.l -(sp)
     9d2:	|  |  |  |  |  |  |  |  |                                 pea -50(a5)
     9d6:	|  |  |  |  |  |  |  |  |                                 pea 4 <_start+0x4>
     9da:	|  |  |  |  |  |  |  |  |                                 jsr eba <debug_cmd.part.0>
     9e0:	|  |  |  |  |  |  |  |  |                                 lea 16(sp),sp
	debug_register_copperlist(copper1, "copper1", 1024, 0);
     9e4:	|  |  |  |  |  |  |  |  |                                 pea 400 <main+0x374>
     9e8:	|  |  |  |  |  |  |  |  |                                 pea 2fd6 <incbin_player_end+0x140>
     9ee:	|  |  |  |  |  |  |  |  |                                 move.l a3,-(sp)
     9f0:	|  |  |  |  |  |  |  |  |                                 lea 122a <debug_register_copperlist.constprop.0>,a4
     9f6:	|  |  |  |  |  |  |  |  |                                 jsr (a4)
	debug_register_copperlist(copper2, "copper2", sizeof(copper2), 0);
     9f8:	|  |  |  |  |  |  |  |  |                                 pea 80 <_start+0x80>
     9fc:	|  |  |  |  |  |  |  |  |                                 pea 2fde <incbin_player_end+0x148>
     a02:	|  |  |  |  |  |  |  |  |                                 pea 30b8 <copper2>
     a08:	|  |  |  |  |  |  |  |  |                                 jsr (a4)
	*copListEnd++ = offsetof(struct Custom, ddfstrt);
     a0a:	|  |  |  |  |  |  |  |  |                                 move.w #146,(a3)
	*copListEnd++ = fw;
     a0e:	|  |  |  |  |  |  |  |  |                                 move.w #56,2(a3)
	*copListEnd++ = offsetof(struct Custom, ddfstop);
     a14:	|  |  |  |  |  |  |  |  |                                 move.w #148,4(a3)
	*copListEnd++ = fw+(((width>>4)-1)<<3);
     a1a:	|  |  |  |  |  |  |  |  |                                 move.w #208,6(a3)
	*copListEnd++ = offsetof(struct Custom, diwstrt);
     a20:	|  |  |  |  |  |  |  |  |                                 move.w #142,8(a3)
	*copListEnd++ = x+(y<<8);
     a26:	|  |  |  |  |  |  |  |  |                                 move.w #11393,10(a3)
	*copListEnd++ = offsetof(struct Custom, diwstop);
     a2c:	|  |  |  |  |  |  |  |  |                                 move.w #144,12(a3)
	*copListEnd++ = (xstop-256)+((ystop-256)<<8);
     a32:	|  |  |  |  |  |  |  |  |                                 move.w #11457,14(a3)
	*copPtr++ = offsetof(struct Custom, bplcon0);
     a38:	|  |  |  |  |  |  |  |  |                                 move.w #256,16(a3)
	*copPtr++ = (0<<10)/*dual pf*/|(1<<9)/*color*/|((5)<<12)/*num bitplanes*/;
     a3e:	|  |  |  |  |  |  |  |  |                                 move.w #20992,18(a3)
	*copPtr++ = offsetof(struct Custom, bplcon1);	//scrolling
     a44:	|  |  |  |  |  |  |  |  |                                 move.w #258,20(a3)
     a4a:	|  |  |  |  |  |  |  |  |                                 lea 22(a3),a0
     a4e:	|  |  |  |  |  |  |  |  |                                 move.l a0,13cd6 <scroll>
	*copPtr++ = 0;
     a54:	|  |  |  |  |  |  |  |  |                                 clr.w 22(a3)
	*copPtr++ = offsetof(struct Custom, bplcon2);	//playfied priority
     a58:	|  |  |  |  |  |  |  |  |                                 move.w #260,24(a3)
	*copPtr++ = 1<<6;//0x24;			//Sprites have priority over playfields
     a5e:	|  |  |  |  |  |  |  |  |                                 move.w #64,26(a3)
	*copPtr++=offsetof(struct Custom, bpl1mod); //odd planes   1,3,5
     a64:	|  |  |  |  |  |  |  |  |                                 move.w #264,28(a3)
	*copPtr++=4*lineSize;
     a6a:	|  |  |  |  |  |  |  |  |                                 move.w #160,30(a3)
	*copPtr++=offsetof(struct Custom, bpl2mod); //even  planes 2,4
     a70:	|  |  |  |  |  |  |  |  |                                 move.w #266,32(a3)
	*copPtr++=4*lineSize;
     a76:	|  |  |  |  |  |  |  |  |                                 move.w #160,34(a3)
		ULONG addr=(ULONG)planes[i];
     a7c:	|  |  |  |  |  |  |  |  |                                 move.l #20792,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     a82:	|  |  |  |  |  |  |  |  |                                 move.w #224,36(a3)
		*copListEnd++=(UWORD)(addr>>16);
     a88:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     a8a:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     a8c:	|  |  |  |  |  |  |  |  |                                 swap d1
     a8e:	|  |  |  |  |  |  |  |  |                                 move.w d1,38(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     a92:	|  |  |  |  |  |  |  |  |                                 move.w #226,40(a3)
		*copListEnd++=(UWORD)addr;
     a98:	|  |  |  |  |  |  |  |  |                                 move.w d0,42(a3)
		ULONG addr=(ULONG)planes[i];
     a9c:	|  |  |  |  |  |  |  |  |                                 move.l #20832,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     aa2:	|  |  |  |  |  |  |  |  |                                 move.w #228,44(a3)
		*copListEnd++=(UWORD)(addr>>16);
     aa8:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     aaa:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     aac:	|  |  |  |  |  |  |  |  |                                 swap d1
     aae:	|  |  |  |  |  |  |  |  |                                 move.w d1,46(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     ab2:	|  |  |  |  |  |  |  |  |                                 move.w #230,48(a3)
		*copListEnd++=(UWORD)addr;
     ab8:	|  |  |  |  |  |  |  |  |                                 move.w d0,50(a3)
		ULONG addr=(ULONG)planes[i];
     abc:	|  |  |  |  |  |  |  |  |                                 move.l #20872,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     ac2:	|  |  |  |  |  |  |  |  |                                 move.w #232,52(a3)
		*copListEnd++=(UWORD)(addr>>16);
     ac8:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     aca:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     acc:	|  |  |  |  |  |  |  |  |                                 swap d1
     ace:	|  |  |  |  |  |  |  |  |                                 move.w d1,54(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     ad2:	|  |  |  |  |  |  |  |  |                                 move.w #234,56(a3)
		*copListEnd++=(UWORD)addr;
     ad8:	|  |  |  |  |  |  |  |  |                                 move.w d0,58(a3)
		ULONG addr=(ULONG)planes[i];
     adc:	|  |  |  |  |  |  |  |  |                                 move.l #20912,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     ae2:	|  |  |  |  |  |  |  |  |                                 move.w #236,60(a3)
		*copListEnd++=(UWORD)(addr>>16);
     ae8:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     aea:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     aec:	|  |  |  |  |  |  |  |  |                                 swap d1
     aee:	|  |  |  |  |  |  |  |  |                                 move.w d1,62(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     af2:	|  |  |  |  |  |  |  |  |                                 move.w #238,64(a3)
		*copListEnd++=(UWORD)addr;
     af8:	|  |  |  |  |  |  |  |  |                                 move.w d0,66(a3)
		ULONG addr=(ULONG)planes[i];
     afc:	|  |  |  |  |  |  |  |  |                                 move.l #20952,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     b02:	|  |  |  |  |  |  |  |  |                                 move.w #240,68(a3)
		*copListEnd++=(UWORD)(addr>>16);
     b08:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     b0a:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     b0c:	|  |  |  |  |  |  |  |  |                                 swap d1
     b0e:	|  |  |  |  |  |  |  |  |                                 move.w d1,70(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     b12:	|  |  |  |  |  |  |  |  |                                 move.w #242,72(a3)
		*copListEnd++=(UWORD)addr;
     b18:	|  |  |  |  |  |  |  |  |                                 move.w d0,74(a3)
	for (USHORT i=0;i<numPlanes;i++) {
     b1c:	|  |  |  |  |  |  |  |  |                                 lea 76(a3),a1
     b20:	|  |  |  |  |  |  |  |  |                                 move.l #5422,d2
     b26:	|  |  |  |  |  |  |  |  |                                 lea 24(sp),sp
		*copListEnd++=(UWORD)addr;
     b2a:	|  |  |  |  |  |  |  |  |                                 lea 14ee <incbin_colors_start>,a0
     b30:	|  |  |  |  |  |  |  |  |                                 move.w #382,d0
     b34:	|  |  |  |  |  |  |  |  |                                 sub.w d3,d0
     b36:	|  |  |  |  |  |  |  |  \-------------------------------- bra.w 55c <main+0x4d0>
		KPrintF("p61Init failed!\n");
     b3a:	|  |  |  >--|--|--|--|----------------------------------> pea 2fb3 <incbin_player_end+0x11d>
     b40:	|  |  |  |  |  |  |  |                                    jsr f94 <KPrintF>
     b46:	|  |  |  |  |  |  |  |                                    addq.l #4,sp
	warpmode(0);
     b48:	|  |  |  |  |  |  |  |                                    clr.l -(sp)
     b4a:	|  |  |  |  |  |  |  |                                    jsr (a4)
	Forbid();
     b4c:	|  |  |  |  |  |  |  |                                    movea.l 13cd0 <SysBase>,a6
     b52:	|  |  |  |  |  |  |  |                                    jsr -132(a6)
	SystemADKCON=custom->adkconr;
     b56:	|  |  |  |  |  |  |  |                                    movea.l 13cda <custom>,a0
     b5c:	|  |  |  |  |  |  |  |                                    move.w 16(a0),d0
     b60:	|  |  |  |  |  |  |  |                                    move.w d0,13cba <SystemADKCON>
	SystemInts=custom->intenar;
     b66:	|  |  |  |  |  |  |  |                                    move.w 28(a0),d0
     b6a:	|  |  |  |  |  |  |  |                                    move.w d0,13cbe <SystemInts>
	SystemDMA=custom->dmaconr;
     b70:	|  |  |  |  |  |  |  |                                    move.w 2(a0),d0
     b74:	|  |  |  |  |  |  |  |                                    move.w d0,13cbc <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
     b7a:	|  |  |  |  |  |  |  |                                    movea.l 13ccc <GfxBase>,a6
     b80:	|  |  |  |  |  |  |  |                                    move.l 34(a6),13cb6 <ActiView>
	LoadView(0);
     b88:	|  |  |  |  |  |  |  |                                    suba.l a1,a1
     b8a:	|  |  |  |  |  |  |  |                                    jsr -222(a6)
	WaitTOF();
     b8e:	|  |  |  |  |  |  |  |                                    movea.l 13ccc <GfxBase>,a6
     b94:	|  |  |  |  |  |  |  |                                    jsr -270(a6)
	WaitTOF();
     b98:	|  |  |  |  |  |  |  |                                    movea.l 13ccc <GfxBase>,a6
     b9e:	|  |  |  |  |  |  |  |                                    jsr -270(a6)
	WaitVbl();
     ba2:	|  |  |  |  |  |  |  |                                    lea eda <WaitVbl>,a2
     ba8:	|  |  |  |  |  |  |  |                                    jsr (a2)
	WaitVbl();
     baa:	|  |  |  |  |  |  |  |                                    jsr (a2)
	OwnBlitter();
     bac:	|  |  |  |  |  |  |  |                                    movea.l 13ccc <GfxBase>,a6
     bb2:	|  |  |  |  |  |  |  |                                    jsr -456(a6)
	WaitBlit();	
     bb6:	|  |  |  |  |  |  |  |                                    movea.l 13ccc <GfxBase>,a6
     bbc:	|  |  |  |  |  |  |  |                                    jsr -228(a6)
	Disable();
     bc0:	|  |  |  |  |  |  |  |                                    movea.l 13cd0 <SysBase>,a6
     bc6:	|  |  |  |  |  |  |  |                                    jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
     bca:	|  |  |  |  |  |  |  |                                    movea.l 13cda <custom>,a0
     bd0:	|  |  |  |  |  |  |  |                                    move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
     bd6:	|  |  |  |  |  |  |  |                                    move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
     bdc:	|  |  |  |  |  |  |  |                                    move.w #32767,150(a0)
     be2:	|  |  |  |  |  |  |  |                                    addq.l #4,sp
	for(int a=0;a<32;a++)
     be4:	|  |  |  |  |  |  |  |                                    moveq #0,d1
     be6:	|  |  |  |  |  |  |  \----------------------------------- bra.w 1e0 <main+0x154>
		Exit(0);
     bea:	>--|--|--|--|--|--|-------------------------------------> suba.l a6,a6
     bec:	|  |  |  |  |  |  |                                       moveq #0,d1
     bee:	|  |  |  |  |  |  |                                       jsr -144(a6)
	KPrintF("Hello debugger from Amiga!\n");
     bf2:	|  |  |  |  |  |  |                                       pea 2f87 <incbin_player_end+0xf1>
     bf8:	|  |  |  |  |  |  |                                       jsr f94 <KPrintF>
	Write(Output(), (APTR)"Hello console!\n", 15);
     bfe:	|  |  |  |  |  |  |                                       movea.l 13cc8 <DOSBase>,a6
     c04:	|  |  |  |  |  |  |                                       jsr -60(a6)
     c08:	|  |  |  |  |  |  |                                       movea.l 13cc8 <DOSBase>,a6
     c0e:	|  |  |  |  |  |  |                                       move.l d0,d1
     c10:	|  |  |  |  |  |  |                                       move.l #12195,d2
     c16:	|  |  |  |  |  |  |                                       moveq #15,d3
     c18:	|  |  |  |  |  |  |                                       jsr -48(a6)
	Delay(2000);
     c1c:	|  |  |  |  |  |  |                                       movea.l 13cc8 <DOSBase>,a6
     c22:	|  |  |  |  |  |  |                                       move.l #2000,d1
     c28:	|  |  |  |  |  |  |                                       jsr -198(a6)
	warpmode(1);
     c2c:	|  |  |  |  |  |  |                                       pea 1 <_start+0x1>
     c30:	|  |  |  |  |  |  |                                       lea 1006 <warpmode>,a4
     c36:	|  |  |  |  |  |  |                                       jsr (a4)
		register volatile const void* _a0 ASM("a0") = module;
     c38:	|  |  |  |  |  |  |                                       lea 1283c <incbin_module_start>,a0
		register volatile const void* _a1 ASM("a1") = NULL;
     c3e:	|  |  |  |  |  |  |                                       suba.l a1,a1
		register volatile const void* _a2 ASM("a2") = NULL;
     c40:	|  |  |  |  |  |  |                                       suba.l a2,a2
		register volatile const void* _a3 ASM("a3") = player;
     c42:	|  |  |  |  |  |  |                                       lea 1530 <incbin_player_start>,a3
		__asm volatile (
     c48:	|  |  |  |  |  |  |                                       movem.l d1-d7/a4-a6,-(sp)
     c4c:	|  |  |  |  |  |  |                                       jsr (a3)
     c4e:	|  |  |  |  |  |  |                                       movem.l (sp)+,d1-d7/a4-a6
	if(p61Init(module) != 0)
     c52:	|  |  |  |  |  |  |                                       addq.l #8,sp
     c54:	|  |  |  |  |  |  |                                       tst.l d0
     c56:	|  |  |  |  \--|--|-------------------------------------- beq.w 142 <main+0xb6>
     c5a:	|  |  |  \-----|--|-------------------------------------- bra.w b3a <main+0xaae>
		Exit(0);
     c5e:	|  |  \--------|--|-------------------------------------> movea.l 13cc8 <DOSBase>,a6
     c64:	|  |           |  |                                       moveq #0,d1
     c66:	|  |           |  |                                       jsr -144(a6)
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
     c6a:	|  |           |  |                                       movea.l 13cd0 <SysBase>,a6
     c70:	|  |           |  |                                       lea 2f7b <incbin_player_end+0xe5>,a1
     c76:	|  |           |  |                                       moveq #0,d0
     c78:	|  |           |  |                                       jsr -552(a6)
     c7c:	|  |           |  |                                       move.l d0,13cc8 <DOSBase>
	if (!DOSBase)
     c82:	|  \-----------|--|-------------------------------------- bne.w da <main+0x4e>
     c86:	\--------------|--|-------------------------------------- bra.w bea <main+0xb5e>
	APTR vbr = 0;
     c8a:	               \--|-------------------------------------> moveq #0,d0
	VBR=GetVBR();
     c8c:	                  |                                       move.l d0,13cc4 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
     c92:	                  |                                       movea.l 13cc4 <VBR>,a0
     c98:	                  |                                       move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
     c9c:	                  |                                       move.l d0,13cc0 <SystemIrq>
	WaitVbl();
     ca2:	                  |                                       jsr (a2)
	char* test = (char*)AllocMem(2502, MEMF_ANY);
     ca4:	                  |                                       movea.l 13cd0 <SysBase>,a6
     caa:	                  |                                       move.l #2502,d0
     cb0:	                  |                                       moveq #0,d1
     cb2:	                  |                                       jsr -198(a6)
     cb6:	                  |                                       move.l d0,d4
	memset(test, 0xcd, 2502);
     cb8:	                  |                                       pea 9c6 <main+0x93a>
     cbc:	                  |                                       pea cd <main+0x41>
     cc0:	                  |                                       move.l d0,-(sp)
     cc2:	                  |                                       jsr 12c4 <memset>
	memclr(test + 2, 2502 - 4);
     cc8:	                  |                                       movea.l d4,a0
     cca:	                  |                                       addq.l #2,a0
	__asm volatile (
     ccc:	                  |                                       move.l #2498,d5
     cd2:	                  |                                       adda.l d5,a0
     cd4:	                  |                                       moveq #0,d0
     cd6:	                  |                                       moveq #0,d1
     cd8:	                  |                                       moveq #0,d2
     cda:	                  |                                       moveq #0,d3
     cdc:	                  |                                       cmpi.l #256,d5
     ce2:	                  |                                /----- blt.w d36 <main+0xcaa>
     ce6:	                  |                                |  /-> movem.l d0-d3,-(a0)
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
     d1e:	                  |                                |  |   movem.l d0-d3,-(a0)
     d22:	                  |                                |  |   movem.l d0-d3,-(a0)
     d26:	                  |                                |  |   subi.l #256,d5
     d2c:	                  |                                |  |   cmpi.l #256,d5
     d32:	                  |                                |  \-- bge.w ce6 <main+0xc5a>
     d36:	                  |                                >----> cmpi.w #64,d5
     d3a:	                  |                                |  /-- blt.w d56 <main+0xcca>
     d3e:	                  |                                |  |   movem.l d0-d3,-(a0)
     d42:	                  |                                |  |   movem.l d0-d3,-(a0)
     d46:	                  |                                |  |   movem.l d0-d3,-(a0)
     d4a:	                  |                                |  |   movem.l d0-d3,-(a0)
     d4e:	                  |                                |  |   subi.w #64,d5
     d52:	                  |                                \--|-- bra.w d36 <main+0xcaa>
     d56:	                  |                                   \-> lsr.w #2,d5
     d58:	                  |                                   /-- bcc.w d5e <main+0xcd2>
     d5c:	                  |                                   |   move.w d0,-(a0)
     d5e:	                  |                                   \-> moveq #16,d1
     d60:	                  |                                       sub.w d5,d1
     d62:	                  |                                       add.w d1,d1
     d64:	                  |                                       jmp (d68 <main+0xcdc>,pc,d1.w)
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
     d80:	                  |                                       move.l d0,-(a0)
     d82:	                  |                                       move.l d0,-(a0)
     d84:	                  |                                       move.l d0,-(a0)
     d86:	                  |                                       move.l d0,-(a0)
	FreeMem(test, 2502);
     d88:	                  |                                       movea.l 13cd0 <SysBase>,a6
     d8e:	                  |                                       movea.l d4,a1
     d90:	                  |                                       move.l #2502,d0
     d96:	                  |                                       jsr -210(a6)
	USHORT* copper1 = (USHORT*)AllocMem(1024, MEMF_CHIP);
     d9a:	                  |                                       movea.l 13cd0 <SysBase>,a6
     da0:	                  |                                       move.l #1024,d0
     da6:	                  |                                       moveq #2,d1
     da8:	                  |                                       jsr -198(a6)
     dac:	                  |                                       movea.l d0,a3
	debug_register_bitmap(image, "image.bpl", 320, 256, 5, debug_resource_bitmap_interleaved);
     dae:	                  |                                       pea 1 <_start+0x1>
     db2:	                  |                                       pea 100 <main+0x74>
     db6:	                  |                                       pea 140 <main+0xb4>
     dba:	                  |                                       pea 2fc4 <incbin_player_end+0x12e>
     dc0:	                  |                                       pea 5138 <incbin_image_start>
     dc6:	                  |                                       lea 1162 <debug_register_bitmap.constprop.0>,a4
     dcc:	                  |                                       jsr (a4)
	debug_register_bitmap(bob, "bob.bpl", 32, 96, 5, debug_resource_bitmap_interleaved | debug_resource_bitmap_masked);
     dce:	                  |                                       lea 32(sp),sp
     dd2:	                  |                                       pea 3 <_start+0x3>
     dd6:	                  |                                       pea 60 <_start+0x60>
     dda:	                  |                                       pea 20 <_start+0x20>
     dde:	                  |                                       pea 2fce <incbin_player_end+0x138>
     de4:	                  |                                       pea 1193a <incbin_bob_start>
     dea:	                  |                                       jsr (a4)
	struct debug_resource resource = {
     dec:	                  |                                       clr.l -42(a5)
     df0:	                  |                                       clr.l -38(a5)
     df4:	                  |                                       clr.l -34(a5)
     df8:	                  |                                       clr.l -30(a5)
     dfc:	                  |                                       clr.l -26(a5)
     e00:	                  |                                       clr.l -22(a5)
     e04:	                  |                                       clr.l -18(a5)
     e08:	                  |                                       clr.l -14(a5)
     e0c:	                  |                                       clr.l -10(a5)
     e10:	                  |                                       clr.l -6(a5)
     e14:	                  |                                       clr.w -2(a5)
		.address = (unsigned int)addr,
     e18:	                  |                                       move.l #5358,d3
	struct debug_resource resource = {
     e1e:	                  |                                       move.l d3,-50(a5)
     e22:	                  |                                       moveq #64,d1
     e24:	                  |                                       move.l d1,-46(a5)
     e28:	                  |                                       move.w #1,-10(a5)
     e2e:	                  |                                       move.w #32,-6(a5)
     e34:	                  |                                       lea 20(sp),sp
	while(*source && --num > 0)
     e38:	                  |                                       moveq #105,d0
	struct debug_resource resource = {
     e3a:	                  |                                       lea -42(a5),a0
     e3e:	                  |                                       lea 2f60 <incbin_player_end+0xca>,a1
	while(*source && --num > 0)
     e44:	                  |                                       lea -11(a5),a4
     e48:	                  \-------------------------------------- bra.w 3e6 <main+0x35a>

00000e4c <interruptHandler>:
static __attribute__((interrupt)) void interruptHandler() {
     e4c:	    movem.l d0-d1/a0-a1/a3/a6,-(sp)
	custom->intreq=(1<<INTB_VERTB); custom->intreq=(1<<INTB_VERTB); //reset vbl req. twice for a4000 bug.
     e50:	    movea.l 13cda <custom>,a0
     e56:	    move.w #32,156(a0)
     e5c:	    move.w #32,156(a0)
	if(scroll) {
     e62:	    movea.l 13cd6 <scroll>,a0
     e68:	    cmpa.w #0,a0
     e6c:	/-- beq.s e8e <interruptHandler+0x42>
		int sin = sinus15[frameCounter & 63];
     e6e:	|   move.w 13cd4 <frameCounter>,d0
     e74:	|   moveq #63,d1
     e76:	|   and.l d1,d0
		*scroll = sin | (sin << 4);
     e78:	|   lea 3078 <sinus15>,a1
     e7e:	|   move.b (0,a1,d0.l),d0
     e82:	|   andi.w #255,d0
     e86:	|   move.w d0,d1
     e88:	|   lsl.w #4,d1
     e8a:	|   or.w d0,d1
     e8c:	|   move.w d1,(a0)
		register volatile const void* _a3 ASM("a3") = player;
     e8e:	\-> lea 1530 <incbin_player_start>,a3
		register volatile const void* _a6 ASM("a6") = (void*)0xdff000;
     e94:	    movea.l #14675968,a6
		__asm volatile (
     e9a:	    movem.l d0-a2/a4-a5,-(sp)
     e9e:	    jsr 4(a3)
     ea2:	    movem.l (sp)+,d0-a2/a4-a5
	frameCounter++;
     ea6:	    move.w 13cd4 <frameCounter>,d0
     eac:	    addq.w #1,d0
     eae:	    move.w d0,13cd4 <frameCounter>
}
     eb4:	    movem.l (sp)+,d0-d1/a0-a1/a3/a6
     eb8:	    rte

00000eba <debug_cmd.part.0>:
		UaeLib(88, arg1, arg2, arg3, arg4);
     eba:	move.l 16(sp),-(sp)
     ebe:	move.l 16(sp),-(sp)
     ec2:	move.l 16(sp),-(sp)
     ec6:	move.l 16(sp),-(sp)
     eca:	pea 58 <_start+0x58>
     ece:	jsr f0ff60 <_end+0xefc280>
}
     ed4:	lea 20(sp),sp
     ed8:	rts

00000eda <WaitVbl>:
void WaitVbl() {
     eda:	             subq.l #8,sp
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     edc:	             move.w f0ff60 <_end+0xefc280>,d0
     ee2:	             cmpi.w #20153,d0
     ee6:	      /----- beq.s f5c <WaitVbl+0x82>
     ee8:	      |      cmpi.w #-24562,d0
     eec:	      +----- beq.s f5c <WaitVbl+0x82>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     eee:	/-----|----> move.l dff004 <_end+0xdeb324>,d0
     ef4:	|     |      move.l d0,(sp)
		vpos&=0x1ff00;
     ef6:	|     |      move.l (sp),d0
     ef8:	|     |      andi.l #130816,d0
     efe:	|     |      move.l d0,(sp)
		if (vpos!=(311<<8))
     f00:	|     |      move.l (sp),d0
     f02:	|     |      cmpi.l #79616,d0
     f08:	+-----|----- beq.s eee <WaitVbl+0x14>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     f0a:	|  /--|----> move.l dff004 <_end+0xdeb324>,d0
     f10:	|  |  |      move.l d0,4(sp)
		vpos&=0x1ff00;
     f14:	|  |  |      move.l 4(sp),d0
     f18:	|  |  |      andi.l #130816,d0
     f1e:	|  |  |      move.l d0,4(sp)
		if (vpos==(311<<8))
     f22:	|  |  |      move.l 4(sp),d0
     f26:	|  |  |      cmpi.l #79616,d0
     f2c:	|  +--|----- bne.s f0a <WaitVbl+0x30>
     f2e:	|  |  |      move.w f0ff60 <_end+0xefc280>,d0
     f34:	|  |  |      cmpi.w #20153,d0
     f38:	|  |  |  /-- beq.s f44 <WaitVbl+0x6a>
     f3a:	|  |  |  |   cmpi.w #-24562,d0
     f3e:	|  |  |  +-- beq.s f44 <WaitVbl+0x6a>
}
     f40:	|  |  |  |   addq.l #8,sp
     f42:	|  |  |  |   rts
     f44:	|  |  |  \-> clr.l -(sp)
     f46:	|  |  |      clr.l -(sp)
     f48:	|  |  |      clr.l -(sp)
     f4a:	|  |  |      pea 5 <_start+0x5>
     f4e:	|  |  |      jsr eba <debug_cmd.part.0>
}
     f54:	|  |  |      lea 16(sp),sp
     f58:	|  |  |      addq.l #8,sp
     f5a:	|  |  |      rts
     f5c:	|  |  \----> clr.l -(sp)
     f5e:	|  |         clr.l -(sp)
     f60:	|  |         pea 1 <_start+0x1>
     f64:	|  |         pea 5 <_start+0x5>
     f68:	|  |         jsr eba <debug_cmd.part.0>
}
     f6e:	|  |         lea 16(sp),sp
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     f72:	|  |         move.l dff004 <_end+0xdeb324>,d0
     f78:	|  |         move.l d0,(sp)
		vpos&=0x1ff00;
     f7a:	|  |         move.l (sp),d0
     f7c:	|  |         andi.l #130816,d0
     f82:	|  |         move.l d0,(sp)
		if (vpos!=(311<<8))
     f84:	|  |         move.l (sp),d0
     f86:	|  |         cmpi.l #79616,d0
     f8c:	\--|-------- beq.w eee <WaitVbl+0x14>
     f90:	   \-------- bra.w f0a <WaitVbl+0x30>

00000f94 <KPrintF>:
void KPrintF(const char* fmt, ...) {
     f94:	    lea -128(sp),sp
     f98:	    movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
     f9c:	    move.w f0ff60 <_end+0xefc280>,d0
     fa2:	    cmpi.w #20153,d0
     fa6:	/-- beq.s fd2 <KPrintF+0x3e>
     fa8:	|   cmpi.w #-24562,d0
     fac:	+-- beq.s fd2 <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
     fae:	|   movea.l 13cd0 <SysBase>,a6
     fb4:	|   movea.l 144(sp),a0
     fb8:	|   lea 148(sp),a1
     fbc:	|   lea 14dc <KPutCharX>,a2
     fc2:	|   suba.l a3,a3
     fc4:	|   jsr -522(a6)
}
     fc8:	|   movem.l (sp)+,a2-a3/a6
     fcc:	|   lea 128(sp),sp
     fd0:	|   rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
     fd2:	\-> movea.l 13cd0 <SysBase>,a6
     fd8:	    movea.l 144(sp),a0
     fdc:	    lea 148(sp),a1
     fe0:	    lea 14ea <PutChar>,a2
     fe6:	    lea 12(sp),a3
     fea:	    jsr -522(a6)
		UaeDbgLog(86, temp);
     fee:	    move.l a3,-(sp)
     ff0:	    pea 56 <_start+0x56>
     ff4:	    jsr f0ff60 <_end+0xefc280>
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
     ffa:	    addq.l #8,sp
}
     ffc:	    movem.l (sp)+,a2-a3/a6
    1000:	    lea 128(sp),sp
    1004:	    rts

00001006 <warpmode>:
void warpmode(int on) { // bool
    1006:	       subq.l #4,sp
    1008:	       move.l a2,-(sp)
    100a:	       move.l d2,-(sp)
	if(*((UWORD *)UaeConf) == 0x4eb9 || *((UWORD *)UaeConf) == 0xa00e) {
    100c:	       move.w f0ff60 <_end+0xefc280>,d0
    1012:	       cmpi.w #20153,d0
    1016:	   /-- beq.s 1026 <warpmode+0x20>
    1018:	   |   cmpi.w #-24562,d0
    101c:	   +-- beq.s 1026 <warpmode+0x20>
}
    101e:	   |   move.l (sp)+,d2
    1020:	   |   movea.l (sp)+,a2
    1022:	   |   addq.l #4,sp
    1024:	   |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
    1026:	   \-> tst.l 16(sp)
    102a:	/----- beq.w 10ca <warpmode+0xc4>
    102e:	|      pea 1 <_start+0x1>
    1032:	|      moveq #15,d2
    1034:	|      add.l sp,d2
    1036:	|      move.l d2,-(sp)
    1038:	|      clr.l -(sp)
    103a:	|      pea 2f05 <incbin_player_end+0x6f>
    1040:	|      pea ffffffff <_end+0xfffec31f>
    1044:	|      pea 52 <_start+0x52>
    1048:	|      movea.l #15794016,a2
    104e:	|      jsr (a2)
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
    1050:	|      pea 1 <_start+0x1>
    1054:	|      move.l d2,-(sp)
    1056:	|      clr.l -(sp)
    1058:	|      pea 2f13 <incbin_player_end+0x7d>
    105e:	|      pea ffffffff <_end+0xfffec31f>
    1062:	|      pea 52 <_start+0x52>
    1066:	|      jsr (a2)
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
    1068:	|      lea 48(sp),sp
    106c:	|      pea 1 <_start+0x1>
    1070:	|      move.l d2,-(sp)
    1072:	|      clr.l -(sp)
    1074:	|      pea 2f29 <incbin_player_end+0x93>
    107a:	|      pea ffffffff <_end+0xfffec31f>
    107e:	|      pea 52 <_start+0x52>
    1082:	|      jsr (a2)
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
    1084:	|      pea 1 <_start+0x1>
    1088:	|      move.l d2,-(sp)
    108a:	|      clr.l -(sp)
    108c:	|      pea 2f46 <incbin_player_end+0xb0>
    1092:	|      pea ffffffff <_end+0xfffec31f>
    1096:	|      pea 52 <_start+0x52>
    109a:	|      jsr (a2)
    109c:	|      lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
    10a0:	|      move.l #11927,d0
    10a6:	|      pea 1 <_start+0x1>
    10aa:	|      move.l d2,-(sp)
    10ac:	|      clr.l -(sp)
    10ae:	|      move.l d0,-(sp)
    10b0:	|      pea ffffffff <_end+0xfffec31f>
    10b4:	|      pea 52 <_start+0x52>
    10b8:	|      jsr f0ff60 <_end+0xefc280>
}
    10be:	|      lea 24(sp),sp
    10c2:	|  /-> move.l (sp)+,d2
    10c4:	|  |   movea.l (sp)+,a2
    10c6:	|  |   addq.l #4,sp
    10c8:	|  |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
    10ca:	\--|-> pea 1 <_start+0x1>
    10ce:	   |   moveq #15,d2
    10d0:	   |   add.l sp,d2
    10d2:	   |   move.l d2,-(sp)
    10d4:	   |   clr.l -(sp)
    10d6:	   |   pea 2eac <incbin_player_end+0x16>
    10dc:	   |   pea ffffffff <_end+0xfffec31f>
    10e0:	   |   pea 52 <_start+0x52>
    10e4:	   |   movea.l #15794016,a2
    10ea:	   |   jsr (a2)
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
    10ec:	   |   pea 1 <_start+0x1>
    10f0:	   |   move.l d2,-(sp)
    10f2:	   |   clr.l -(sp)
    10f4:	   |   pea 2ebb <incbin_player_end+0x25>
    10fa:	   |   pea ffffffff <_end+0xfffec31f>
    10fe:	   |   pea 52 <_start+0x52>
    1102:	   |   jsr (a2)
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
    1104:	   |   lea 48(sp),sp
    1108:	   |   pea 1 <_start+0x1>
    110c:	   |   move.l d2,-(sp)
    110e:	   |   clr.l -(sp)
    1110:	   |   pea 2ed0 <incbin_player_end+0x3a>
    1116:	   |   pea ffffffff <_end+0xfffec31f>
    111a:	   |   pea 52 <_start+0x52>
    111e:	   |   jsr (a2)
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
    1120:	   |   pea 1 <_start+0x1>
    1124:	   |   move.l d2,-(sp)
    1126:	   |   clr.l -(sp)
    1128:	   |   pea 2eec <incbin_player_end+0x56>
    112e:	   |   pea ffffffff <_end+0xfffec31f>
    1132:	   |   pea 52 <_start+0x52>
    1136:	   |   jsr (a2)
    1138:	   |   lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
    113c:	   |   move.l #11937,d0
    1142:	   |   pea 1 <_start+0x1>
    1146:	   |   move.l d2,-(sp)
    1148:	   |   clr.l -(sp)
    114a:	   |   move.l d0,-(sp)
    114c:	   |   pea ffffffff <_end+0xfffec31f>
    1150:	   |   pea 52 <_start+0x52>
    1154:	   |   jsr f0ff60 <_end+0xefc280>
}
    115a:	   |   lea 24(sp),sp
    115e:	   \-- bra.w 10c2 <warpmode+0xbc>

00001162 <debug_register_bitmap.constprop.0>:
void debug_register_bitmap(const void* addr, const char* name, short width, short height, short numPlanes, unsigned short flags) {
    1162:	       link.w a5,#-52
    1166:	       movem.l d2-d4/a2,-(sp)
    116a:	       movea.l 12(a5),a1
    116e:	       move.l 16(a5),d4
    1172:	       move.l 20(a5),d3
    1176:	       move.l 24(a5),d2
	struct debug_resource resource = {
    117a:	       clr.l -42(a5)
    117e:	       clr.l -38(a5)
    1182:	       clr.l -34(a5)
    1186:	       clr.l -30(a5)
    118a:	       clr.l -26(a5)
    118e:	       clr.l -22(a5)
    1192:	       clr.l -18(a5)
    1196:	       clr.l -14(a5)
    119a:	       clr.w -10(a5)
    119e:	       move.l 8(a5),-50(a5)
		.size = width / 8 * height * numPlanes,
    11a4:	       move.w d4,d0
    11a6:	       asr.w #3,d0
    11a8:	       muls.w d3,d0
    11aa:	       move.l d0,d1
    11ac:	       add.l d0,d1
    11ae:	       add.l d1,d1
    11b0:	       add.l d1,d0
	struct debug_resource resource = {
    11b2:	       move.l d0,-46(a5)
    11b6:	       move.w d2,-8(a5)
    11ba:	       move.w d4,-6(a5)
    11be:	       move.w d3,-4(a5)
    11c2:	       move.w #5,-2(a5)
	if (flags & debug_resource_bitmap_masked)
    11c8:	       btst #1,d2
    11cc:	   /-- beq.s 11d4 <debug_register_bitmap.constprop.0+0x72>
		resource.size *= 2;
    11ce:	   |   add.l d0,d0
    11d0:	   |   move.l d0,-46(a5)
	while(*source && --num > 0)
    11d4:	   \-> move.b (a1),d0
    11d6:	       lea -42(a5),a0
    11da:	/----- beq.s 11ec <debug_register_bitmap.constprop.0+0x8a>
    11dc:	|      lea -11(a5),a2
		*destination++ = *source++;
    11e0:	|  /-> addq.l #1,a1
    11e2:	|  |   move.b d0,(a0)+
	while(*source && --num > 0)
    11e4:	|  |   move.b (a1),d0
    11e6:	+--|-- beq.s 11ec <debug_register_bitmap.constprop.0+0x8a>
    11e8:	|  |   cmpa.l a0,a2
    11ea:	|  \-- bne.s 11e0 <debug_register_bitmap.constprop.0+0x7e>
	*destination = '\0';
    11ec:	\----> clr.b (a0)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
    11ee:	       move.w f0ff60 <_end+0xefc280>,d0
    11f4:	       cmpi.w #20153,d0
    11f8:	   /-- beq.s 120a <debug_register_bitmap.constprop.0+0xa8>
    11fa:	   |   cmpi.w #-24562,d0
    11fe:	   +-- beq.s 120a <debug_register_bitmap.constprop.0+0xa8>
}
    1200:	   |   movem.l -68(a5),d2-d4/a2
    1206:	   |   unlk a5
    1208:	   |   rts
    120a:	   \-> clr.l -(sp)
    120c:	       clr.l -(sp)
    120e:	       pea -50(a5)
    1212:	       pea 4 <_start+0x4>
    1216:	       jsr eba <debug_cmd.part.0>
    121c:	       lea 16(sp),sp
    1220:	       movem.l -68(a5),d2-d4/a2
    1226:	       unlk a5
    1228:	       rts

0000122a <debug_register_copperlist.constprop.0>:
	};
	my_strncpy(resource.name, name, sizeof(resource.name));
	debug_cmd(barto_cmd_register_resource, (unsigned int)&resource, 0, 0);
}

void debug_register_copperlist(const void* addr, const char* name, unsigned int size, unsigned short flags) {
    122a:	       link.w a5,#-52
    122e:	       move.l a2,-(sp)
    1230:	       movea.l 12(a5),a1
	struct debug_resource resource = {
    1234:	       clr.l -42(a5)
    1238:	       clr.l -38(a5)
    123c:	       clr.l -34(a5)
    1240:	       clr.l -30(a5)
    1244:	       clr.l -26(a5)
    1248:	       clr.l -22(a5)
    124c:	       clr.l -18(a5)
    1250:	       clr.l -14(a5)
    1254:	       clr.l -10(a5)
    1258:	       clr.l -6(a5)
    125c:	       clr.w -2(a5)
    1260:	       move.l 8(a5),-50(a5)
    1266:	       move.l 16(a5),-46(a5)
    126c:	       move.w #2,-10(a5)
	while(*source && --num > 0)
    1272:	       move.b (a1),d0
    1274:	       lea -42(a5),a0
    1278:	/----- beq.s 128a <debug_register_copperlist.constprop.0+0x60>
    127a:	|      lea -11(a5),a2
		*destination++ = *source++;
    127e:	|  /-> addq.l #1,a1
    1280:	|  |   move.b d0,(a0)+
	while(*source && --num > 0)
    1282:	|  |   move.b (a1),d0
    1284:	+--|-- beq.s 128a <debug_register_copperlist.constprop.0+0x60>
    1286:	|  |   cmpa.l a0,a2
    1288:	|  \-- bne.s 127e <debug_register_copperlist.constprop.0+0x54>
	*destination = '\0';
    128a:	\----> clr.b (a0)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
    128c:	       move.w f0ff60 <_end+0xefc280>,d0
    1292:	       cmpi.w #20153,d0
    1296:	   /-- beq.s 12a6 <debug_register_copperlist.constprop.0+0x7c>
    1298:	   |   cmpi.w #-24562,d0
    129c:	   +-- beq.s 12a6 <debug_register_copperlist.constprop.0+0x7c>
		.type = debug_resource_type_copperlist,
		.flags = flags,
	};
	my_strncpy(resource.name, name, sizeof(resource.name));
	debug_cmd(barto_cmd_register_resource, (unsigned int)&resource, 0, 0);
}
    129e:	   |   movea.l -56(a5),a2
    12a2:	   |   unlk a5
    12a4:	   |   rts
    12a6:	   \-> clr.l -(sp)
    12a8:	       clr.l -(sp)
    12aa:	       pea -50(a5)
    12ae:	       pea 4 <_start+0x4>
    12b2:	       jsr eba <debug_cmd.part.0>
    12b8:	       lea 16(sp),sp
    12bc:	       movea.l -56(a5),a2
    12c0:	       unlk a5
    12c2:	       rts

000012c4 <memset>:
void* memset(void *dest, int val, unsigned long len) {
    12c4:	                      movem.l d2-d7/a2,-(sp)
    12c8:	                      move.l 32(sp),d0
    12cc:	                      move.l 36(sp),d3
    12d0:	                      movea.l 40(sp),a0
	while(len-- > 0)
    12d4:	                      lea -1(a0),a1
    12d8:	                      cmpa.w #0,a0
    12dc:	               /----- beq.w 138a <memset+0xc6>
		*ptr++ = val;
    12e0:	               |      move.b d3,d7
    12e2:	               |      move.l d0,d2
    12e4:	               |      neg.l d2
    12e6:	               |      moveq #3,d1
    12e8:	               |      and.l d2,d1
    12ea:	               |      moveq #5,d4
    12ec:	               |      cmp.l a1,d4
    12ee:	/--------------|----- bcc.w 142a <memset+0x166>
    12f2:	|              |      tst.l d1
    12f4:	|           /--|----- beq.w 13c4 <memset+0x100>
    12f8:	|           |  |      movea.l d0,a1
    12fa:	|           |  |      move.b d3,(a1)
	while(len-- > 0)
    12fc:	|           |  |      btst #1,d2
    1300:	|           |  |  /-- beq.w 1390 <memset+0xcc>
		*ptr++ = val;
    1304:	|           |  |  |   move.b d3,1(a1)
	while(len-- > 0)
    1308:	|           |  |  |   moveq #3,d2
    130a:	|           |  |  |   cmp.l d1,d2
    130c:	|  /--------|--|--|-- bne.w 13f4 <memset+0x130>
		*ptr++ = val;
    1310:	|  |        |  |  |   lea 3(a1),a2
    1314:	|  |        |  |  |   move.b d3,2(a1)
	while(len-- > 0)
    1318:	|  |        |  |  |   lea -4(a0),a1
    131c:	|  |        |  |  |   move.l a0,d4
    131e:	|  |        |  |  |   sub.l d1,d4
    1320:	|  |        |  |  |   moveq #0,d5
    1322:	|  |        |  |  |   move.b d3,d5
    1324:	|  |        |  |  |   move.l d5,d6
    1326:	|  |        |  |  |   swap d6
    1328:	|  |        |  |  |   clr.w d6
    132a:	|  |        |  |  |   move.l d3,d2
    132c:	|  |        |  |  |   lsl.w #8,d2
    132e:	|  |        |  |  |   swap d2
    1330:	|  |        |  |  |   clr.w d2
    1332:	|  |        |  |  |   lsl.l #8,d5
    1334:	|  |        |  |  |   or.l d6,d2
    1336:	|  |        |  |  |   or.l d5,d2
    1338:	|  |        |  |  |   move.b d7,d2
    133a:	|  |        |  |  |   movea.l d0,a0
    133c:	|  |        |  |  |   adda.l d1,a0
    133e:	|  |        |  |  |   moveq #-4,d5
    1340:	|  |        |  |  |   and.l d4,d5
    1342:	|  |        |  |  |   move.l d5,d1
    1344:	|  |        |  |  |   add.l a0,d1
		*ptr++ = val;
    1346:	|  |  /-----|--|--|-> move.l d2,(a0)+
	while(len-- > 0)
    1348:	|  |  |     |  |  |   cmp.l a0,d1
    134a:	|  |  +-----|--|--|-- bne.s 1346 <memset+0x82>
    134c:	|  |  |     |  |  |   cmp.l d5,d4
    134e:	|  |  |     |  +--|-- beq.s 138a <memset+0xc6>
    1350:	|  |  |     |  |  |   lea (0,a2,d5.l),a0
    1354:	|  |  |     |  |  |   suba.l d5,a1
		*ptr++ = val;
    1356:	|  |  |  /--|--|--|-> move.b d3,(a0)
	while(len-- > 0)
    1358:	|  |  |  |  |  |  |   cmpa.w #0,a1
    135c:	|  |  |  |  |  +--|-- beq.s 138a <memset+0xc6>
		*ptr++ = val;
    135e:	|  |  |  |  |  |  |   move.b d3,1(a0)
	while(len-- > 0)
    1362:	|  |  |  |  |  |  |   moveq #1,d1
    1364:	|  |  |  |  |  |  |   cmp.l a1,d1
    1366:	|  |  |  |  |  +--|-- beq.s 138a <memset+0xc6>
		*ptr++ = val;
    1368:	|  |  |  |  |  |  |   move.b d3,2(a0)
	while(len-- > 0)
    136c:	|  |  |  |  |  |  |   moveq #2,d2
    136e:	|  |  |  |  |  |  |   cmp.l a1,d2
    1370:	|  |  |  |  |  +--|-- beq.s 138a <memset+0xc6>
		*ptr++ = val;
    1372:	|  |  |  |  |  |  |   move.b d3,3(a0)
	while(len-- > 0)
    1376:	|  |  |  |  |  |  |   moveq #3,d4
    1378:	|  |  |  |  |  |  |   cmp.l a1,d4
    137a:	|  |  |  |  |  +--|-- beq.s 138a <memset+0xc6>
		*ptr++ = val;
    137c:	|  |  |  |  |  |  |   move.b d3,4(a0)
	while(len-- > 0)
    1380:	|  |  |  |  |  |  |   moveq #4,d1
    1382:	|  |  |  |  |  |  |   cmp.l a1,d1
    1384:	|  |  |  |  |  +--|-- beq.s 138a <memset+0xc6>
		*ptr++ = val;
    1386:	|  |  |  |  |  |  |   move.b d3,5(a0)
}
    138a:	|  |  |  |  |  \--|-> movem.l (sp)+,d2-d7/a2
    138e:	|  |  |  |  |     |   rts
		*ptr++ = val;
    1390:	|  |  |  |  |     \-> lea 1(a1),a2
	while(len-- > 0)
    1394:	|  |  |  |  |         lea -2(a0),a1
    1398:	|  |  |  |  |         move.l a0,d4
    139a:	|  |  |  |  |         sub.l d1,d4
    139c:	|  |  |  |  |         moveq #0,d5
    139e:	|  |  |  |  |         move.b d3,d5
    13a0:	|  |  |  |  |         move.l d5,d6
    13a2:	|  |  |  |  |         swap d6
    13a4:	|  |  |  |  |         clr.w d6
    13a6:	|  |  |  |  |         move.l d3,d2
    13a8:	|  |  |  |  |         lsl.w #8,d2
    13aa:	|  |  |  |  |         swap d2
    13ac:	|  |  |  |  |         clr.w d2
    13ae:	|  |  |  |  |         lsl.l #8,d5
    13b0:	|  |  |  |  |         or.l d6,d2
    13b2:	|  |  |  |  |         or.l d5,d2
    13b4:	|  |  |  |  |         move.b d7,d2
    13b6:	|  |  |  |  |         movea.l d0,a0
    13b8:	|  |  |  |  |         adda.l d1,a0
    13ba:	|  |  |  |  |         moveq #-4,d5
    13bc:	|  |  |  |  |         and.l d4,d5
    13be:	|  |  |  |  |         move.l d5,d1
    13c0:	|  |  |  |  |         add.l a0,d1
    13c2:	|  |  +--|--|-------- bra.s 1346 <memset+0x82>
	unsigned char *ptr = (unsigned char *)dest;
    13c4:	|  |  |  |  \-------> movea.l d0,a2
    13c6:	|  |  |  |            move.l a0,d4
    13c8:	|  |  |  |            sub.l d1,d4
    13ca:	|  |  |  |            moveq #0,d5
    13cc:	|  |  |  |            move.b d3,d5
    13ce:	|  |  |  |            move.l d5,d6
    13d0:	|  |  |  |            swap d6
    13d2:	|  |  |  |            clr.w d6
    13d4:	|  |  |  |            move.l d3,d2
    13d6:	|  |  |  |            lsl.w #8,d2
    13d8:	|  |  |  |            swap d2
    13da:	|  |  |  |            clr.w d2
    13dc:	|  |  |  |            lsl.l #8,d5
    13de:	|  |  |  |            or.l d6,d2
    13e0:	|  |  |  |            or.l d5,d2
    13e2:	|  |  |  |            move.b d7,d2
    13e4:	|  |  |  |            movea.l d0,a0
    13e6:	|  |  |  |            adda.l d1,a0
    13e8:	|  |  |  |            moveq #-4,d5
    13ea:	|  |  |  |            and.l d4,d5
    13ec:	|  |  |  |            move.l d5,d1
    13ee:	|  |  |  |            add.l a0,d1
    13f0:	|  |  +--|----------- bra.w 1346 <memset+0x82>
		*ptr++ = val;
    13f4:	|  \--|--|----------> lea 2(a1),a2
	while(len-- > 0)
    13f8:	|     |  |            lea -3(a0),a1
    13fc:	|     |  |            move.l a0,d4
    13fe:	|     |  |            sub.l d1,d4
    1400:	|     |  |            moveq #0,d5
    1402:	|     |  |            move.b d3,d5
    1404:	|     |  |            move.l d5,d6
    1406:	|     |  |            swap d6
    1408:	|     |  |            clr.w d6
    140a:	|     |  |            move.l d3,d2
    140c:	|     |  |            lsl.w #8,d2
    140e:	|     |  |            swap d2
    1410:	|     |  |            clr.w d2
    1412:	|     |  |            lsl.l #8,d5
    1414:	|     |  |            or.l d6,d2
    1416:	|     |  |            or.l d5,d2
    1418:	|     |  |            move.b d7,d2
    141a:	|     |  |            movea.l d0,a0
    141c:	|     |  |            adda.l d1,a0
    141e:	|     |  |            moveq #-4,d5
    1420:	|     |  |            and.l d4,d5
    1422:	|     |  |            move.l d5,d1
    1424:	|     |  |            add.l a0,d1
    1426:	|     \--|----------- bra.w 1346 <memset+0x82>
	unsigned char *ptr = (unsigned char *)dest;
    142a:	\--------|----------> movea.l d0,a0
    142c:	         \----------- bra.w 1356 <memset+0x92>

00001430 <__mulsi3>:
	.section .text.__mulsi3,"ax",@progbits
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1430:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1434:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1438:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    143c:	mulu.w 8(sp),d1
	addw	d1, d0
    1440:	add.w d1,d0
	swap	d0
    1442:	swap d0
	clrw	d0
    1444:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1446:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    144a:	mulu.w 10(sp),d1
	addl	d1, d0
    144e:	add.l d1,d0
	rts
    1450:	rts

00001452 <__udivsi3>:
	.section .text.__udivsi3,"ax",@progbits
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    1452:	       move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1454:	       move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1458:	       move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    145c:	       cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    1462:	   /-- bcc.s 147a <__udivsi3+0x28>
	movel	d0, d2
    1464:	   |   move.l d0,d2
	clrw	d2
    1466:	   |   clr.w d2
	swap	d2
    1468:	   |   swap d2
	divu	d1, d2          /* high quotient in lower word */
    146a:	   |   divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    146c:	   |   move.w d2,d0
	swap	d0
    146e:	   |   swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    1470:	   |   move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1474:	   |   divu.w d1,d2
	movew	d2, d0
    1476:	   |   move.w d2,d0
	jra	6f
    1478:	/--|-- bra.s 14aa <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    147a:	|  \-> move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    147c:	|  /-> lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    147e:	|  |   lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    1480:	|  |   cmpi.l #65536,d1
	jcc	4b
    1486:	|  \-- bcc.s 147c <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    1488:	|      divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    148a:	|      andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    1490:	|      move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    1492:	|      mulu.w d0,d1
	swap	d2
    1494:	|      swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    1496:	|      mulu.w d0,d2
	swap	d2		/* align high part with low part */
    1498:	|      swap d2
	tstw	d2		/* high part 17 bits? */
    149a:	|      tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    149c:	|  /-- bne.s 14a8 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    149e:	|  |   add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    14a0:	|  +-- bcs.s 14a8 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    14a2:	|  |   cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    14a6:	+--|-- bls.s 14aa <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    14a8:	|  \-> subq.l #1,d0

6:	movel	sp@+, d2
    14aa:	\----> move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    14ac:	       rts

000014ae <__umodsi3>:
	.section .text.__umodsi3,"ax",@progbits
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    14ae:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    14b2:	move.l 4(sp),d0
	movel	d1, sp@-
    14b6:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    14b8:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    14ba:	jsr 1452 <__udivsi3>
	addql	#8, sp
    14c0:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    14c2:	move.l 8(sp),d1
	movel	d1, sp@-
    14c6:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    14c8:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    14ca:	jsr 1430 <__mulsi3>
	addql	#8, sp
    14d0:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    14d2:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    14d6:	sub.l d0,d1
	movel	d1, d0
    14d8:	move.l d1,d0
	rts
    14da:	rts

000014dc <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    14dc:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    14de:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    14e2:	jsr -516(a6)
    move.l (sp)+, a6
    14e6:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    14e8:	rts

000014ea <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    14ea:	move.b d0,(a3)+
	rts
    14ec:	rts
