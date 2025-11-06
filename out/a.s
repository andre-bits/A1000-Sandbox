
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
   4:	       move.l #9200,d3
   a:	       subi.l #9200,d3
  10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	       move.l #9200,d0
  18:	       cmpi.l #9200,d0
  1e:	,----- beq.s 32 <_start+0x32>
  20:	|      lea 23f0 <buttonBorderData>,a2
  26:	|      moveq #0,d2
		__preinit_array_start[i]();
  28:	|  ,-> movea.l (a2)+,a0
  2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  2c:	|  |   addq.l #1,d2
  2e:	|  |   cmp.l d3,d2
  30:	|  '-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
  32:	'----> move.l #9200,d3
  38:	       subi.l #9200,d3
  3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  40:	       move.l #9200,d0
  46:	       cmpi.l #9200,d0
  4c:	,----- beq.s 60 <_start+0x60>
  4e:	|      lea 23f0 <buttonBorderData>,a2
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
  66:	       move.l #9200,d2
  6c:	       subi.l #9200,d2
  72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  74:	,----- beq.s 86 <_start+0x86>
  76:	|      lea 23f0 <buttonBorderData>,a2
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
	}
	
	CloseWindow(window);
}

int main() {
  8c:	                                        lea -48(sp),sp
  90:	                                        movem.l d2-d5/a2-a4/a6,-(sp)
	SysBase = *(struct ExecBase**)4;
  94:	                                        movea.l 4 <_start+0x4>,a6
  98:	                                        move.l a6,2460 <SysBase>

	// Open required libraries
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  9e:	                                        lea 396 <main+0x30a>,a1
  a4:	                                        moveq #0,d0
  a6:	                                        jsr -552(a6)
  aa:	                                        move.l d0,245c <DOSBase>
	if (!DOSBase)
  b0:	      ,-------------------------------- beq.w 370 <main+0x2e4>
		Exit(0);

	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
  b4:	      |                                 movea.l 2460 <SysBase>,a6
  ba:	      |                                 lea 3a2 <main+0x316>,a1
  c0:	      |                                 moveq #0,d0
  c2:	      |                                 jsr -552(a6)
  c6:	      |                                 move.l d0,2458 <IntuitionBase>
	if (!IntuitionBase) {
  cc:	,-----|-------------------------------- beq.w 336 <main+0x2aa>
		CloseLibrary((struct Library*)DOSBase);
		Exit(0);
	}

	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
  d0:	|  ,--|-------------------------------> movea.l 2460 <SysBase>,a6
  d6:	|  |  |                                 lea 3b4 <main+0x328>,a1
  dc:	|  |  |                                 moveq #0,d0
  de:	|  |  |                                 jsr -552(a6)
  e2:	|  |  |                                 move.l d0,2454 <GfxBase>
	if (!GfxBase) {
  e8:	|  |  |  ,----------------------------- beq.w 306 <main+0x27a>
	nw.LeftEdge = 50;
  ec:	|  |  |  |  ,-------------------------> move.w #50,32(sp)
	nw.TopEdge = 50;
  f2:	|  |  |  |  |                           move.w #50,34(sp)
	nw.Width = 400;
  f8:	|  |  |  |  |                           move.w #400,36(sp)
	nw.Height = 150;
  fe:	|  |  |  |  |                           move.w #150,38(sp)
	nw.DetailPen = 0;
 104:	|  |  |  |  |                           move.w #1,40(sp)
	nw.IDCMPFlags = CLOSEWINDOW | MOUSEBUTTONS | VANILLAKEY | REFRESHWINDOW | GADGETUP;
 10a:	|  |  |  |  |                           move.l #2097740,42(sp)
	nw.Flags = WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH | ACTIVATE | SMART_REFRESH;
 112:	|  |  |  |  |                           move.l #4110,46(sp)
	nw.FirstGadget = &colorButton;
 11a:	|  |  |  |  |                           move.l #9256,50(sp)
	nw.CheckMark = NULL;
 122:	|  |  |  |  |                           clr.l 54(sp)
	nw.Title = (UBYTE *)"AMIGA SANDBOX";
 126:	|  |  |  |  |                           move.l #965,58(sp)
	nw.Screen = NULL;  // Use default Workbench screen
 12e:	|  |  |  |  |                           clr.l 62(sp)
	nw.BitMap = NULL;
 132:	|  |  |  |  |                           clr.l 66(sp)
	nw.MinWidth = 200;
 136:	|  |  |  |  |                           move.w #200,70(sp)
	nw.MinHeight = 100;
 13c:	|  |  |  |  |                           move.w #100,72(sp)
	nw.MaxWidth = 640;
 142:	|  |  |  |  |                           move.w #640,74(sp)
	nw.MaxHeight = 400;
 148:	|  |  |  |  |                           move.w #400,76(sp)
	nw.Type = WBENCHSCREEN;
 14e:	|  |  |  |  |                           move.w #1,78(sp)
	window = OpenWindow(&nw);
 154:	|  |  |  |  |                           movea.l 2458 <IntuitionBase>,a6
 15a:	|  |  |  |  |                           lea 32(sp),a0
 15e:	|  |  |  |  |                           jsr -204(a6)
 162:	|  |  |  |  |                           movea.l d0,a4
	if (!window) {
 164:	|  |  |  |  |                           tst.l d0
 166:	|  |  |  |  |              ,----------- beq.w 226 <main+0x19a>
		Wait(1L << window->UserPort->mp_SigBit);
 16a:	|  |  |  |  |              |            moveq #1,d5
					SetWindowTitles(window, (UBYTE *)"Button Clicked!", (UBYTE *)-1);
 16c:	|  |  |  |  |              |            move.l #979,d4
					SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX", (UBYTE *)-1);
 172:	|  |  |  |  |              |            move.l #965,d3
		Wait(1L << window->UserPort->mp_SigBit);
 178:	|  |  |  |  |              |        ,-> movea.l 86(a4),a0
 17c:	|  |  |  |  |              |        |   moveq #0,d0
 17e:	|  |  |  |  |              |        |   move.b 15(a0),d0
 182:	|  |  |  |  |              |        |   movea.l 2460 <SysBase>,a6
 188:	|  |  |  |  |              |        |   move.l d5,d1
 18a:	|  |  |  |  |              |        |   lsl.l d0,d1
 18c:	|  |  |  |  |              |        |   move.l d1,d0
 18e:	|  |  |  |  |              |        |   jsr -318(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 192:	|  |  |  |  |              |        |   movea.l 2460 <SysBase>,a6
 198:	|  |  |  |  |              |        |   movea.l 86(a4),a0
 19c:	|  |  |  |  |              |        |   jsr -372(a6)
 1a0:	|  |  |  |  |              |        |   movea.l d0,a3
 1a2:	|  |  |  |  |              |        |   tst.l d0
 1a4:	|  |  |  |  |              |        +-- beq.s 178 <main+0xec>
 1a6:	|  |  |  |  |              |        |   clr.w d2
			switch (message->Class) {
 1a8:	|  |  |  |  |  ,-----------|--------|-> move.l 20(a3),d1
 1ac:	|  |  |  |  |  |           |        |   cmpi.l #512,d1
 1b2:	|  |  |  |  |  |        ,--|--------|-- beq.w 29e <main+0x212>
 1b6:	|  |  |  |  |  |        |  |  ,-----|-- bhi.w 262 <main+0x1d6>
 1ba:	|  |  |  |  |  |        |  |  |     |   moveq #4,d0
 1bc:	|  |  |  |  |  |        |  |  |     |   cmp.l d1,d0
 1be:	|  |  |  |  |  |  ,-----|--|--|-----|-- beq.w 2c6 <main+0x23a>
 1c2:	|  |  |  |  |  |  |     |  |  |     |   moveq #64,d0
 1c4:	|  |  |  |  |  |  |     |  |  |     |   cmp.l d1,d0
 1c6:	|  |  |  |  |  |  |     |  |  |  ,--|-- bne.s 1f4 <main+0x168>
					SetWindowTitles(window, (UBYTE *)"Button Clicked!", (UBYTE *)-1);
 1c8:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l 2458 <IntuitionBase>,a6
 1ce:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l a4,a0
 1d0:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l d4,a1
 1d2:	|  |  |  |  |  |  |     |  |  |  |  |   movea.w #-1,a2
 1d6:	|  |  |  |  |  |  |     |  |  |  |  |   jsr -276(a6)
					Delay(30); // Brief delay
 1da:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l 245c <DOSBase>,a6
 1e0:	|  |  |  |  |  |  |     |  |  |  |  |   moveq #30,d1
 1e2:	|  |  |  |  |  |  |     |  |  |  |  |   jsr -198(a6)
					SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX", (UBYTE *)-1);
 1e6:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l 2458 <IntuitionBase>,a6
 1ec:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l a4,a0
 1ee:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l d3,a1
 1f0:	|  |  |  |  |  |  |     |  |  |  |  |   jsr -276(a6)
			ReplyMsg((struct Message *)message);
 1f4:	|  |  |  |  |  |  |     |  |  |  >--|-> movea.l 2460 <SysBase>,a6
 1fa:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l a3,a1
 1fc:	|  |  |  |  |  |  |     |  |  |  |  |   jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 200:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l 2460 <SysBase>,a6
 206:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l 86(a4),a0
 20a:	|  |  |  |  |  |  |     |  |  |  |  |   jsr -372(a6)
 20e:	|  |  |  |  |  |  |     |  |  |  |  |   movea.l d0,a3
 210:	|  |  |  |  |  |  |     |  |  |  |  |   tst.l d0
 212:	|  |  |  |  |  +--|-----|--|--|--|--|-- bne.s 1a8 <main+0x11c>
	while (!done) {
 214:	|  |  |  |  |  |  |  ,--|--|--|--|--|-> tst.w d2
 216:	|  |  |  |  |  |  |  |  |  |  |  |  '-- beq.w 178 <main+0xec>
	CloseWindow(window);
 21a:	|  |  |  |  |  |  |  |  |  |  |  |      movea.l 2458 <IntuitionBase>,a6
 220:	|  |  |  |  |  |  |  |  |  |  |  |      movea.l a4,a0
 222:	|  |  |  |  |  |  |  |  |  |  |  |      jsr -72(a6)
	// 	Write(Output(), (APTR)"This program was started from CLI/Shell.\n", 41);
	// 	Write(Output(), (APTR)"Try running it from Workbench for GUI mode.\n", 45);
	// }

	// Clean up libraries
	CloseLibrary((struct Library*)GfxBase);
 226:	|  |  |  |  |  |  |  |  |  '--|--|----> movea.l 2460 <SysBase>,a6
 22c:	|  |  |  |  |  |  |  |  |     |  |      movea.l 2454 <GfxBase>,a1
 232:	|  |  |  |  |  |  |  |  |     |  |      jsr -414(a6)
	CloseLibrary((struct Library*)IntuitionBase);
 236:	|  |  |  |  |  |  |  |  |     |  |      movea.l 2460 <SysBase>,a6
 23c:	|  |  |  |  |  |  |  |  |     |  |      movea.l 2458 <IntuitionBase>,a1
 242:	|  |  |  |  |  |  |  |  |     |  |      jsr -414(a6)
	CloseLibrary((struct Library*)DOSBase);
 246:	|  |  |  |  |  |  |  |  |     |  |      movea.l 2460 <SysBase>,a6
 24c:	|  |  |  |  |  |  |  |  |     |  |      movea.l 245c <DOSBase>,a1
 252:	|  |  |  |  |  |  |  |  |     |  |      jsr -414(a6)
	
	return 0;
}
 256:	|  |  |  |  |  |  |  |  |     |  |      moveq #0,d0
 258:	|  |  |  |  |  |  |  |  |     |  |      movem.l (sp)+,d2-d5/a2-a4/a6
 25c:	|  |  |  |  |  |  |  |  |     |  |      lea 48(sp),sp
 260:	|  |  |  |  |  |  |  |  |     |  |      rts
			switch (message->Class) {
 262:	|  |  |  |  |  |  |  |  |     '--|----> cmpi.l #2097152,d1
 268:	|  |  |  |  |  |  |  |  |        '----- bne.s 1f4 <main+0x168>
					if (message->Code == 27) {  // ESC key
 26a:	|  |  |  |  |  |  |  |  |               cmpi.w #27,24(a3)
 270:	|  |  |  |  |  |  |  |  |               seq d0
 272:	|  |  |  |  |  |  |  |  |               ext.w d0
 274:	|  |  |  |  |  |  |  |  |               neg.w d0
 276:	|  |  |  |  |  |  |  |  |               or.w d0,d2
			ReplyMsg((struct Message *)message);
 278:	|  |  |  |  |  |  |  |  |               movea.l 2460 <SysBase>,a6
 27e:	|  |  |  |  |  |  |  |  |               movea.l a3,a1
 280:	|  |  |  |  |  |  |  |  |               jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 284:	|  |  |  |  |  |  |  |  |               movea.l 2460 <SysBase>,a6
 28a:	|  |  |  |  |  |  |  |  |               movea.l 86(a4),a0
 28e:	|  |  |  |  |  |  |  |  |               jsr -372(a6)
 292:	|  |  |  |  |  |  |  |  |               movea.l d0,a3
 294:	|  |  |  |  |  |  |  |  |               tst.l d0
 296:	|  |  |  |  |  +--|--|--|-------------- bne.w 1a8 <main+0x11c>
 29a:	|  |  |  |  |  |  |  +--|-------------- bra.w 214 <main+0x188>
			switch (message->Class) {
 29e:	|  |  |  |  |  |  |  |  '-------------> moveq #1,d2
			ReplyMsg((struct Message *)message);
 2a0:	|  |  |  |  |  |  |  |                  movea.l 2460 <SysBase>,a6
 2a6:	|  |  |  |  |  |  |  |                  movea.l a3,a1
 2a8:	|  |  |  |  |  |  |  |                  jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 2ac:	|  |  |  |  |  |  |  |                  movea.l 2460 <SysBase>,a6
 2b2:	|  |  |  |  |  |  |  |                  movea.l 86(a4),a0
 2b6:	|  |  |  |  |  |  |  |                  jsr -372(a6)
 2ba:	|  |  |  |  |  |  |  |                  movea.l d0,a3
 2bc:	|  |  |  |  |  |  |  |                  tst.l d0
 2be:	|  |  |  |  |  +--|--|----------------- bne.w 1a8 <main+0x11c>
 2c2:	|  |  |  |  |  |  |  +----------------- bra.w 214 <main+0x188>
					BeginRefresh(window);
 2c6:	|  |  |  |  |  |  '--|----------------> movea.l 2458 <IntuitionBase>,a6
 2cc:	|  |  |  |  |  |     |                  movea.l a4,a0
 2ce:	|  |  |  |  |  |     |                  jsr -354(a6)
					EndRefresh(window, TRUE);
 2d2:	|  |  |  |  |  |     |                  movea.l 2458 <IntuitionBase>,a6
 2d8:	|  |  |  |  |  |     |                  movea.l a4,a0
 2da:	|  |  |  |  |  |     |                  moveq #1,d0
 2dc:	|  |  |  |  |  |     |                  jsr -366(a6)
			ReplyMsg((struct Message *)message);
 2e0:	|  |  |  |  |  |     |                  movea.l 2460 <SysBase>,a6
 2e6:	|  |  |  |  |  |     |                  movea.l a3,a1
 2e8:	|  |  |  |  |  |     |                  jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 2ec:	|  |  |  |  |  |     |                  movea.l 2460 <SysBase>,a6
 2f2:	|  |  |  |  |  |     |                  movea.l 86(a4),a0
 2f6:	|  |  |  |  |  |     |                  jsr -372(a6)
 2fa:	|  |  |  |  |  |     |                  movea.l d0,a3
 2fc:	|  |  |  |  |  |     |                  tst.l d0
 2fe:	|  |  |  |  |  '-----|----------------- bne.w 1a8 <main+0x11c>
 302:	|  |  |  |  |        '----------------- bra.w 214 <main+0x188>
		CloseLibrary((struct Library*)IntuitionBase);
 306:	|  |  |  >--|-------------------------> movea.l 2460 <SysBase>,a6
 30c:	|  |  |  |  |                           movea.l 2458 <IntuitionBase>,a1
 312:	|  |  |  |  |                           jsr -414(a6)
		CloseLibrary((struct Library*)DOSBase);
 316:	|  |  |  |  |                           movea.l 2460 <SysBase>,a6
 31c:	|  |  |  |  |                           movea.l 245c <DOSBase>,a1
 322:	|  |  |  |  |                           jsr -414(a6)
		Exit(0);
 326:	|  |  |  |  |                           movea.l 245c <DOSBase>,a6
 32c:	|  |  |  |  |                           moveq #0,d1
 32e:	|  |  |  |  |                           jsr -144(a6)
 332:	|  |  |  |  +-------------------------- bra.w ec <main+0x60>
		CloseLibrary((struct Library*)DOSBase);
 336:	>--|--|--|--|-------------------------> movea.l 2460 <SysBase>,a6
 33c:	|  |  |  |  |                           movea.l 245c <DOSBase>,a1
 342:	|  |  |  |  |                           jsr -414(a6)
		Exit(0);
 346:	|  |  |  |  |                           movea.l 245c <DOSBase>,a6
 34c:	|  |  |  |  |                           moveq #0,d1
 34e:	|  |  |  |  |                           jsr -144(a6)
	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
 352:	|  |  |  |  |                           movea.l 2460 <SysBase>,a6
 358:	|  |  |  |  |                           lea 3b4 <main+0x328>,a1
 35e:	|  |  |  |  |                           moveq #0,d0
 360:	|  |  |  |  |                           jsr -552(a6)
 364:	|  |  |  |  |                           move.l d0,2454 <GfxBase>
	if (!GfxBase) {
 36a:	|  |  |  |  '-------------------------- bne.w ec <main+0x60>
 36e:	|  |  |  '----------------------------- bra.s 306 <main+0x27a>
		Exit(0);
 370:	|  |  '-------------------------------> suba.l a6,a6
 372:	|  |                                    moveq #0,d1
 374:	|  |                                    jsr -144(a6)
	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
 378:	|  |                                    movea.l 2460 <SysBase>,a6
 37e:	|  |                                    lea 3a2 <main+0x316>,a1
 384:	|  |                                    moveq #0,d0
 386:	|  |                                    jsr -552(a6)
 38a:	|  |                                    move.l d0,2458 <IntuitionBase>
	if (!IntuitionBase) {
 390:	|  '----------------------------------- bne.w d0 <main+0x44>
 394:	'-------------------------------------- bra.s 336 <main+0x2aa>
