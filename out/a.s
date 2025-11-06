
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
   4:	       move.l #9354,d3
   a:	       subi.l #9354,d3
  10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	       move.l #9354,d0
  18:	       cmpi.l #9354,d0
  1e:	,----- beq.s 32 <_start+0x32>
  20:	|      lea 248a <buttonBorderData>,a2
  26:	|      moveq #0,d2
		__preinit_array_start[i]();
  28:	|  ,-> movea.l (a2)+,a0
  2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  2c:	|  |   addq.l #1,d2
  2e:	|  |   cmp.l d3,d2
  30:	|  '-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
  32:	'----> move.l #9354,d3
  38:	       subi.l #9354,d3
  3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  40:	       move.l #9354,d0
  46:	       cmpi.l #9354,d0
  4c:	,----- beq.s 60 <_start+0x60>
  4e:	|      lea 248a <buttonBorderData>,a2
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
  66:	       move.l #9354,d2
  6c:	       subi.l #9354,d2
  72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  74:	,----- beq.s 86 <_start+0x86>
  76:	|      lea 248a <buttonBorderData>,a2
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
  90:	                                        movem.l d2-d7/a2-a6,-(sp)
	SysBase = *(struct ExecBase**)4;
  94:	                                        movea.l 4 <_start+0x4>,a6
  98:	                                        move.l a6,24fa <SysBase>

	// Open required libraries
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  9e:	                                        lea 430 <main+0x3a4>,a1
  a4:	                                        moveq #0,d0
  a6:	                                        jsr -552(a6)
  aa:	                                        move.l d0,24f6 <DOSBase>
	if (!DOSBase)
  b0:	      ,-------------------------------- beq.w 40a <main+0x37e>
		Exit(0);

	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
  b4:	      |                                 movea.l 24fa <SysBase>,a6
  ba:	      |                                 lea 43c <main+0x3b0>,a1
  c0:	      |                                 moveq #0,d0
  c2:	      |                                 jsr -552(a6)
  c6:	      |                                 move.l d0,24f2 <IntuitionBase>
	if (!IntuitionBase) {
  cc:	,-----|-------------------------------- beq.w 3d0 <main+0x344>
		CloseLibrary((struct Library*)DOSBase);
		Exit(0);
	}

	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
  d0:	|  ,--|-------------------------------> movea.l 24fa <SysBase>,a6
  d6:	|  |  |                                 lea 44e <main+0x3c2>,a1
  dc:	|  |  |                                 moveq #0,d0
  de:	|  |  |                                 jsr -552(a6)
  e2:	|  |  |                                 move.l d0,24ee <GfxBase>
	if (!GfxBase) {
  e8:	|  |  |  ,----------------------------- beq.w 3a0 <main+0x314>
	nw.LeftEdge = 50;
  ec:	|  |  |  |  ,-------------------------> move.w #50,44(sp)
	nw.TopEdge = 50;
  f2:	|  |  |  |  |                           move.w #50,46(sp)
	nw.Width = 400;
  f8:	|  |  |  |  |                           move.w #400,48(sp)
	nw.Height = 150;
  fe:	|  |  |  |  |                           move.w #150,50(sp)
	nw.DetailPen = 0;
 104:	|  |  |  |  |                           move.w #1,52(sp)
	nw.IDCMPFlags = CLOSEWINDOW | MOUSEBUTTONS | VANILLAKEY | REFRESHWINDOW | GADGETUP;
 10a:	|  |  |  |  |                           move.l #2097740,54(sp)
	nw.Flags = WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH | ACTIVATE | SMART_REFRESH;
 112:	|  |  |  |  |                           move.l #4110,58(sp)
	nw.FirstGadget = &colorButton;
 11a:	|  |  |  |  |                           move.l #9410,62(sp)
	nw.CheckMark = NULL;
 122:	|  |  |  |  |                           clr.l 66(sp)
	nw.Title = (UBYTE *)"AMIGA SANDBOX";
 126:	|  |  |  |  |                           move.l #1119,70(sp)
	nw.Screen = NULL;  // Use default Workbench screen
 12e:	|  |  |  |  |                           clr.l 74(sp)
	nw.BitMap = NULL;
 132:	|  |  |  |  |                           clr.l 78(sp)
	nw.MinWidth = 200;
 136:	|  |  |  |  |                           move.w #200,82(sp)
	nw.MinHeight = 100;
 13c:	|  |  |  |  |                           move.w #100,84(sp)
	nw.MaxWidth = 640;
 142:	|  |  |  |  |                           move.w #640,86(sp)
	nw.MaxHeight = 400;
 148:	|  |  |  |  |                           move.w #400,88(sp)
	nw.Type = WBENCHSCREEN;
 14e:	|  |  |  |  |                           move.w #1,90(sp)
	window = OpenWindow(&nw);
 154:	|  |  |  |  |                           movea.l 24f2 <IntuitionBase>,a6
 15a:	|  |  |  |  |                           lea 44(sp),a0
 15e:	|  |  |  |  |                           jsr -204(a6)
 162:	|  |  |  |  |                           movea.l d0,a4
	if (!window) {
 164:	|  |  |  |  |                           tst.l d0
 166:	|  |  |  |  |        ,----------------- beq.w 278 <main+0x1ec>
	struct RastPort *rp = window->RPort;
 16a:	|  |  |  |  |        |                  move.l 50(a4),d4
	SetAPen(rp, 3);
 16e:	|  |  |  |  |        |                  movea.l 24ee <GfxBase>,a6
 174:	|  |  |  |  |        |                  movea.l d4,a1
 176:	|  |  |  |  |        |                  moveq #3,d0
 178:	|  |  |  |  |        |                  jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 17c:	|  |  |  |  |        |                  movea.l 24ee <GfxBase>,a6
 182:	|  |  |  |  |        |                  movea.l d4,a1
 184:	|  |  |  |  |        |                  moveq #101,d0
 186:	|  |  |  |  |        |                  moveq #61,d1
 188:	|  |  |  |  |        |                  move.l #298,d2
 18e:	|  |  |  |  |        |                  moveq #89,d3
 190:	|  |  |  |  |        |                  jsr -306(a6)
	SetAPen(rp, 1);
 194:	|  |  |  |  |        |                  movea.l 24ee <GfxBase>,a6
 19a:	|  |  |  |  |        |                  movea.l d4,a1
 19c:	|  |  |  |  |        |                  moveq #1,d0
 19e:	|  |  |  |  |        |                  jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 1a2:	|  |  |  |  |        |                  movea.l 24f2 <IntuitionBase>,a6
 1a8:	|  |  |  |  |        |                  lea 24c2 <colorButton>,a0
 1ae:	|  |  |  |  |        |                  movea.l a4,a1
 1b0:	|  |  |  |  |        |                  suba.l a2,a2
 1b2:	|  |  |  |  |        |                  jsr -222(a6)
		Wait(1L << window->UserPort->mp_SigBit);
 1b6:	|  |  |  |  |        |                  moveq #1,d5
	RefreshGadgets(&colorButton, window, NULL);
 1b8:	|  |  |  |  |        |                  lea 24c2 <colorButton>,a5
					SetWindowTitles(window, (UBYTE *)"Button Clicked!", (UBYTE *)-1);
 1be:	|  |  |  |  |        |                  move.l #1133,d7
					SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX", (UBYTE *)-1);
 1c4:	|  |  |  |  |        |                  move.l #1119,d6
		Wait(1L << window->UserPort->mp_SigBit);
 1ca:	|  |  |  |  |        |              ,-> movea.l 86(a4),a0
 1ce:	|  |  |  |  |        |              |   moveq #0,d0
 1d0:	|  |  |  |  |        |              |   move.b 15(a0),d0
 1d4:	|  |  |  |  |        |              |   movea.l 24fa <SysBase>,a6
 1da:	|  |  |  |  |        |              |   move.l d5,d1
 1dc:	|  |  |  |  |        |              |   lsl.l d0,d1
 1de:	|  |  |  |  |        |              |   move.l d1,d0
 1e0:	|  |  |  |  |        |              |   jsr -318(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 1e4:	|  |  |  |  |        |              |   movea.l 24fa <SysBase>,a6
 1ea:	|  |  |  |  |        |              |   movea.l 86(a4),a0
 1ee:	|  |  |  |  |        |              |   jsr -372(a6)
 1f2:	|  |  |  |  |        |              |   movea.l d0,a3
 1f4:	|  |  |  |  |        |              |   tst.l d0
 1f6:	|  |  |  |  |        |              +-- beq.s 1ca <main+0x13e>
 1f8:	|  |  |  |  |        |              |   clr.w d4
			switch (message->Class) {
 1fa:	|  |  |  |  |  ,-----|--------------|-> move.l 20(a3),d0
 1fe:	|  |  |  |  |  |     |              |   cmpi.l #512,d0
 204:	|  |  |  |  |  |     |     ,--------|-- beq.w 2f0 <main+0x264>
 208:	|  |  |  |  |  |     |     |  ,-----|-- bhi.w 2b4 <main+0x228>
 20c:	|  |  |  |  |  |     |     |  |     |   moveq #4,d1
 20e:	|  |  |  |  |  |     |     |  |     |   cmp.l d0,d1
 210:	|  |  |  |  |  |     |  ,--|--|-----|-- beq.w 318 <main+0x28c>
 214:	|  |  |  |  |  |     |  |  |  |     |   moveq #64,d1
 216:	|  |  |  |  |  |     |  |  |  |     |   cmp.l d0,d1
 218:	|  |  |  |  |  |     |  |  |  |  ,--|-- bne.s 246 <main+0x1ba>
					SetWindowTitles(window, (UBYTE *)"Button Clicked!", (UBYTE *)-1);
 21a:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l 24f2 <IntuitionBase>,a6
 220:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l a4,a0
 222:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l d7,a1
 224:	|  |  |  |  |  |     |  |  |  |  |  |   movea.w #-1,a2
 228:	|  |  |  |  |  |     |  |  |  |  |  |   jsr -276(a6)
					Delay(30); // Brief delay
 22c:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l 24f6 <DOSBase>,a6
 232:	|  |  |  |  |  |     |  |  |  |  |  |   moveq #30,d1
 234:	|  |  |  |  |  |     |  |  |  |  |  |   jsr -198(a6)
					SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX", (UBYTE *)-1);
 238:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l 24f2 <IntuitionBase>,a6
 23e:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l a4,a0
 240:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l d6,a1
 242:	|  |  |  |  |  |     |  |  |  |  |  |   jsr -276(a6)
			ReplyMsg((struct Message *)message);
 246:	|  |  |  |  |  |     |  |  |  |  >--|-> movea.l 24fa <SysBase>,a6
 24c:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l a3,a1
 24e:	|  |  |  |  |  |     |  |  |  |  |  |   jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 252:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l 24fa <SysBase>,a6
 258:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l 86(a4),a0
 25c:	|  |  |  |  |  |     |  |  |  |  |  |   jsr -372(a6)
 260:	|  |  |  |  |  |     |  |  |  |  |  |   movea.l d0,a3
 262:	|  |  |  |  |  |     |  |  |  |  |  |   tst.l d0
 264:	|  |  |  |  |  +-----|--|--|--|--|--|-- bne.s 1fa <main+0x16e>
	while (!done) {
 266:	|  |  |  |  |  |  ,--|--|--|--|--|--|-> tst.w d4
 268:	|  |  |  |  |  |  |  |  |  |  |  |  '-- beq.w 1ca <main+0x13e>
	CloseWindow(window);
 26c:	|  |  |  |  |  |  |  |  |  |  |  |      movea.l 24f2 <IntuitionBase>,a6
 272:	|  |  |  |  |  |  |  |  |  |  |  |      movea.l a4,a0
 274:	|  |  |  |  |  |  |  |  |  |  |  |      jsr -72(a6)
	// 	Write(Output(), (APTR)"This program was started from CLI/Shell.\n", 41);
	// 	Write(Output(), (APTR)"Try running it from Workbench for GUI mode.\n", 45);
	// }

	// Clean up libraries
	CloseLibrary((struct Library*)GfxBase);
 278:	|  |  |  |  |  |  |  '--|--|--|--|----> movea.l 24fa <SysBase>,a6
 27e:	|  |  |  |  |  |  |     |  |  |  |      movea.l 24ee <GfxBase>,a1
 284:	|  |  |  |  |  |  |     |  |  |  |      jsr -414(a6)
	CloseLibrary((struct Library*)IntuitionBase);
 288:	|  |  |  |  |  |  |     |  |  |  |      movea.l 24fa <SysBase>,a6
 28e:	|  |  |  |  |  |  |     |  |  |  |      movea.l 24f2 <IntuitionBase>,a1
 294:	|  |  |  |  |  |  |     |  |  |  |      jsr -414(a6)
	CloseLibrary((struct Library*)DOSBase);
 298:	|  |  |  |  |  |  |     |  |  |  |      movea.l 24fa <SysBase>,a6
 29e:	|  |  |  |  |  |  |     |  |  |  |      movea.l 24f6 <DOSBase>,a1
 2a4:	|  |  |  |  |  |  |     |  |  |  |      jsr -414(a6)
	
	return 0;
}
 2a8:	|  |  |  |  |  |  |     |  |  |  |      moveq #0,d0
 2aa:	|  |  |  |  |  |  |     |  |  |  |      movem.l (sp)+,d2-d7/a2-a6
 2ae:	|  |  |  |  |  |  |     |  |  |  |      lea 48(sp),sp
 2b2:	|  |  |  |  |  |  |     |  |  |  |      rts
			switch (message->Class) {
 2b4:	|  |  |  |  |  |  |     |  |  '--|----> cmpi.l #2097152,d0
 2ba:	|  |  |  |  |  |  |     |  |     '----- bne.s 246 <main+0x1ba>
					if (message->Code == 27) {  // ESC key
 2bc:	|  |  |  |  |  |  |     |  |            cmpi.w #27,24(a3)
 2c2:	|  |  |  |  |  |  |     |  |            seq d0
 2c4:	|  |  |  |  |  |  |     |  |            ext.w d0
 2c6:	|  |  |  |  |  |  |     |  |            neg.w d0
 2c8:	|  |  |  |  |  |  |     |  |            or.w d0,d4
			ReplyMsg((struct Message *)message);
 2ca:	|  |  |  |  |  |  |     |  |            movea.l 24fa <SysBase>,a6
 2d0:	|  |  |  |  |  |  |     |  |            movea.l a3,a1
 2d2:	|  |  |  |  |  |  |     |  |            jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 2d6:	|  |  |  |  |  |  |     |  |            movea.l 24fa <SysBase>,a6
 2dc:	|  |  |  |  |  |  |     |  |            movea.l 86(a4),a0
 2e0:	|  |  |  |  |  |  |     |  |            jsr -372(a6)
 2e4:	|  |  |  |  |  |  |     |  |            movea.l d0,a3
 2e6:	|  |  |  |  |  |  |     |  |            tst.l d0
 2e8:	|  |  |  |  |  +--|-----|--|----------- bne.w 1fa <main+0x16e>
 2ec:	|  |  |  |  |  |  +-----|--|----------- bra.w 266 <main+0x1da>
			switch (message->Class) {
 2f0:	|  |  |  |  |  |  |     |  '----------> moveq #1,d4
			ReplyMsg((struct Message *)message);
 2f2:	|  |  |  |  |  |  |     |               movea.l 24fa <SysBase>,a6
 2f8:	|  |  |  |  |  |  |     |               movea.l a3,a1
 2fa:	|  |  |  |  |  |  |     |               jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 2fe:	|  |  |  |  |  |  |     |               movea.l 24fa <SysBase>,a6
 304:	|  |  |  |  |  |  |     |               movea.l 86(a4),a0
 308:	|  |  |  |  |  |  |     |               jsr -372(a6)
 30c:	|  |  |  |  |  |  |     |               movea.l d0,a3
 30e:	|  |  |  |  |  |  |     |               tst.l d0
 310:	|  |  |  |  |  +--|-----|-------------- bne.w 1fa <main+0x16e>
 314:	|  |  |  |  |  |  +-----|-------------- bra.w 266 <main+0x1da>
					BeginRefresh(window);
 318:	|  |  |  |  |  |  |     '-------------> movea.l 24f2 <IntuitionBase>,a6
 31e:	|  |  |  |  |  |  |                     movea.l a4,a0
 320:	|  |  |  |  |  |  |                     jsr -354(a6)
	struct RastPort *rp = window->RPort;
 324:	|  |  |  |  |  |  |                     movea.l 50(a4),a2
	SetAPen(rp, 3);
 328:	|  |  |  |  |  |  |                     movea.l 24ee <GfxBase>,a6
 32e:	|  |  |  |  |  |  |                     movea.l a2,a1
 330:	|  |  |  |  |  |  |                     moveq #3,d0
 332:	|  |  |  |  |  |  |                     jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 336:	|  |  |  |  |  |  |                     movea.l 24ee <GfxBase>,a6
 33c:	|  |  |  |  |  |  |                     movea.l a2,a1
 33e:	|  |  |  |  |  |  |                     moveq #101,d0
 340:	|  |  |  |  |  |  |                     moveq #61,d1
 342:	|  |  |  |  |  |  |                     move.l #298,d2
 348:	|  |  |  |  |  |  |                     moveq #89,d3
 34a:	|  |  |  |  |  |  |                     jsr -306(a6)
	SetAPen(rp, 1);
 34e:	|  |  |  |  |  |  |                     movea.l 24ee <GfxBase>,a6
 354:	|  |  |  |  |  |  |                     movea.l a2,a1
 356:	|  |  |  |  |  |  |                     moveq #1,d0
 358:	|  |  |  |  |  |  |                     jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 35c:	|  |  |  |  |  |  |                     movea.l 24f2 <IntuitionBase>,a6
 362:	|  |  |  |  |  |  |                     movea.l a5,a0
 364:	|  |  |  |  |  |  |                     movea.l a4,a1
 366:	|  |  |  |  |  |  |                     suba.l a2,a2
 368:	|  |  |  |  |  |  |                     jsr -222(a6)
					EndRefresh(window, TRUE);
 36c:	|  |  |  |  |  |  |                     movea.l 24f2 <IntuitionBase>,a6
 372:	|  |  |  |  |  |  |                     movea.l a4,a0
 374:	|  |  |  |  |  |  |                     moveq #1,d0
 376:	|  |  |  |  |  |  |                     jsr -366(a6)
			ReplyMsg((struct Message *)message);
 37a:	|  |  |  |  |  |  |                     movea.l 24fa <SysBase>,a6
 380:	|  |  |  |  |  |  |                     movea.l a3,a1
 382:	|  |  |  |  |  |  |                     jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 386:	|  |  |  |  |  |  |                     movea.l 24fa <SysBase>,a6
 38c:	|  |  |  |  |  |  |                     movea.l 86(a4),a0
 390:	|  |  |  |  |  |  |                     jsr -372(a6)
 394:	|  |  |  |  |  |  |                     movea.l d0,a3
 396:	|  |  |  |  |  |  |                     tst.l d0
 398:	|  |  |  |  |  '--|-------------------- bne.w 1fa <main+0x16e>
 39c:	|  |  |  |  |     '-------------------- bra.w 266 <main+0x1da>
		CloseLibrary((struct Library*)IntuitionBase);
 3a0:	|  |  |  >--|-------------------------> movea.l 24fa <SysBase>,a6
 3a6:	|  |  |  |  |                           movea.l 24f2 <IntuitionBase>,a1
 3ac:	|  |  |  |  |                           jsr -414(a6)
		CloseLibrary((struct Library*)DOSBase);
 3b0:	|  |  |  |  |                           movea.l 24fa <SysBase>,a6
 3b6:	|  |  |  |  |                           movea.l 24f6 <DOSBase>,a1
 3bc:	|  |  |  |  |                           jsr -414(a6)
		Exit(0);
 3c0:	|  |  |  |  |                           movea.l 24f6 <DOSBase>,a6
 3c6:	|  |  |  |  |                           moveq #0,d1
 3c8:	|  |  |  |  |                           jsr -144(a6)
 3cc:	|  |  |  |  +-------------------------- bra.w ec <main+0x60>
		CloseLibrary((struct Library*)DOSBase);
 3d0:	>--|--|--|--|-------------------------> movea.l 24fa <SysBase>,a6
 3d6:	|  |  |  |  |                           movea.l 24f6 <DOSBase>,a1
 3dc:	|  |  |  |  |                           jsr -414(a6)
		Exit(0);
 3e0:	|  |  |  |  |                           movea.l 24f6 <DOSBase>,a6
 3e6:	|  |  |  |  |                           moveq #0,d1
 3e8:	|  |  |  |  |                           jsr -144(a6)
	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
 3ec:	|  |  |  |  |                           movea.l 24fa <SysBase>,a6
 3f2:	|  |  |  |  |                           lea 44e <main+0x3c2>,a1
 3f8:	|  |  |  |  |                           moveq #0,d0
 3fa:	|  |  |  |  |                           jsr -552(a6)
 3fe:	|  |  |  |  |                           move.l d0,24ee <GfxBase>
	if (!GfxBase) {
 404:	|  |  |  |  '-------------------------- bne.w ec <main+0x60>
 408:	|  |  |  '----------------------------- bra.s 3a0 <main+0x314>
		Exit(0);
 40a:	|  |  '-------------------------------> suba.l a6,a6
 40c:	|  |                                    moveq #0,d1
 40e:	|  |                                    jsr -144(a6)
	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
 412:	|  |                                    movea.l 24fa <SysBase>,a6
 418:	|  |                                    lea 43c <main+0x3b0>,a1
 41e:	|  |                                    moveq #0,d0
 420:	|  |                                    jsr -552(a6)
 424:	|  |                                    move.l d0,24f2 <IntuitionBase>
	if (!IntuitionBase) {
 42a:	|  '----------------------------------- bne.w d0 <main+0x44>
 42e:	'-------------------------------------- bra.s 3d0 <main+0x344>
