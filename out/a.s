
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
   4:	       move.l #9644,d3
   a:	       subi.l #9644,d3
  10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	       move.l #9644,d0
  18:	       cmpi.l #9644,d0
  1e:	,----- beq.s 32 <_start+0x32>
  20:	|      lea 25ac <IntuitionBase>,a2
  26:	|      moveq #0,d2
		__preinit_array_start[i]();
  28:	|  ,-> movea.l (a2)+,a0
  2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  2c:	|  |   addq.l #1,d2
  2e:	|  |   cmp.l d3,d2
  30:	|  '-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
  32:	'----> move.l #9644,d3
  38:	       subi.l #9644,d3
  3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  40:	       move.l #9644,d0
  46:	       cmpi.l #9644,d0
  4c:	,----- beq.s 60 <_start+0x60>
  4e:	|      lea 25ac <IntuitionBase>,a2
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
  66:	       move.l #9644,d2
  6c:	       subi.l #9644,d2
  72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  74:	,----- beq.s 86 <_start+0x86>
  76:	|      lea 25ac <IntuitionBase>,a2
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
  8c:	                                  lea -48(sp),sp
  90:	                                  movem.l d2-d3/a2-a4/a6,-(sp)
	SysBase = *((struct ExecBase**)4UL);
  94:	                                  movea.l 4 <_start+0x4>,a6
  98:	                                  move.l a6,25b4 <SysBase>

	// Open required libraries
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  9e:	                                  lea 560 <DrawWindowText+0x228>,a1
  a4:	                                  moveq #0,d0
  a6:	                                  jsr -552(a6)
  aa:	                                  move.l d0,25b0 <DOSBase>
	if (!DOSBase)
  b0:	      ,-------------------------- beq.w 312 <main+0x286>
		Exit(0);

	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
  b4:	      |                           movea.l 25b4 <SysBase>,a6
  ba:	      |                           lea 56c <DrawWindowText+0x234>,a1
  c0:	      |                           moveq #0,d0
  c2:	      |                           jsr -552(a6)
  c6:	      |                           move.l d0,25ac <IntuitionBase>
	if (!IntuitionBase) {
  cc:	,-----|-------------------------- beq.w 2d8 <main+0x24c>
		CloseLibrary((struct Library*)DOSBase);
		Exit(0);
	}

	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
  d0:	|  ,--|-------------------------> movea.l 25b4 <SysBase>,a6
  d6:	|  |  |                           lea 57e <DrawWindowText+0x246>,a1
  dc:	|  |  |                           moveq #0,d0
  de:	|  |  |                           jsr -552(a6)
  e2:	|  |  |                           move.l d0,25b8 <GfxBase>
	if (!GfxBase) {
  e8:	|  |  |  ,----------------------- beq.w 2a8 <main+0x21c>
	nw.LeftEdge = 50;
  ec:	|  |  |  |  ,-------------------> move.w #50,24(sp)
	nw.TopEdge = 50;
  f2:	|  |  |  |  |                     move.w #50,26(sp)
	nw.Width = 400;
  f8:	|  |  |  |  |                     move.w #400,28(sp)
	nw.Height = 200;
  fe:	|  |  |  |  |                     move.w #200,30(sp)
	nw.DetailPen = 0;
 104:	|  |  |  |  |                     move.w #1,32(sp)
	nw.IDCMPFlags = CLOSEWINDOW | MOUSEBUTTONS | VANILLAKEY | REFRESHWINDOW;
 10a:	|  |  |  |  |                     move.l #2097676,34(sp)
	nw.Flags = WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH | ACTIVATE | SMART_REFRESH;
 112:	|  |  |  |  |                     move.l #4110,38(sp)
	nw.FirstGadget = NULL;
 11a:	|  |  |  |  |                     clr.l 42(sp)
	nw.CheckMark = NULL;
 11e:	|  |  |  |  |                     clr.l 46(sp)
	nw.Title = (UBYTE *)"*** AMIGA WORKBENCH TEST ***";
 122:	|  |  |  |  |                     move.l #1423,50(sp)
	nw.Screen = NULL;  // Use default Workbench screen
 12a:	|  |  |  |  |                     clr.l 54(sp)
	nw.BitMap = NULL;
 12e:	|  |  |  |  |                     clr.l 58(sp)
	nw.MinWidth = 200;
 132:	|  |  |  |  |                     move.w #200,62(sp)
	nw.MinHeight = 100;
 138:	|  |  |  |  |                     move.w #100,64(sp)
	nw.MaxWidth = 640;
 13e:	|  |  |  |  |                     move.w #640,66(sp)
	nw.MaxHeight = 400;
 144:	|  |  |  |  |                     move.w #400,68(sp)
	nw.Type = WBENCHSCREEN;
 14a:	|  |  |  |  |                     move.w #1,70(sp)
	window = OpenWindow(&nw);
 150:	|  |  |  |  |                     movea.l 25ac <IntuitionBase>,a6
 156:	|  |  |  |  |                     lea 24(sp),a0
 15a:	|  |  |  |  |                     jsr -204(a6)
 15e:	|  |  |  |  |                     movea.l d0,a3
	if (!window) {
 160:	|  |  |  |  |                     tst.l d0
 162:	|  |  |  |  |        ,----------- beq.w 212 <main+0x186>
	DrawWindowText(window);
 166:	|  |  |  |  |        |            move.l d0,-(sp)
 168:	|  |  |  |  |        |            lea 338 <DrawWindowText>,a4
 16e:	|  |  |  |  |        |            jsr (a4)
 170:	|  |  |  |  |        |            addq.l #4,sp
		Wait(1L << window->UserPort->mp_SigBit);
 172:	|  |  |  |  |        |            moveq #1,d2
 174:	|  |  |  |  |        |     ,----> movea.l 86(a3),a0
 178:	|  |  |  |  |        |     |      moveq #0,d0
 17a:	|  |  |  |  |        |     |      move.b 15(a0),d0
 17e:	|  |  |  |  |        |     |      movea.l 25b4 <SysBase>,a6
 184:	|  |  |  |  |        |     |      move.l d2,d1
 186:	|  |  |  |  |        |     |      lsl.l d0,d1
 188:	|  |  |  |  |        |     |      move.l d1,d0
 18a:	|  |  |  |  |        |     |      jsr -318(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 18e:	|  |  |  |  |        |     |      movea.l 25b4 <SysBase>,a6
 194:	|  |  |  |  |        |     |      movea.l 86(a3),a0
 198:	|  |  |  |  |        |     |      jsr -372(a6)
 19c:	|  |  |  |  |        |     |      movea.l d0,a2
 19e:	|  |  |  |  |        |     |      tst.l d0
 1a0:	|  |  |  |  |        |     +----- beq.s 174 <main+0xe8>
 1a2:	|  |  |  |  |        |     |      clr.w d3
			switch (message->Class) {
 1a4:	|  |  |  |  |  ,-----|-----|----> move.l 20(a2),d1
 1a8:	|  |  |  |  |  |     |     |      cmpi.l #512,d1
 1ae:	|  |  |  |  |  |     |  ,--|----- beq.w 24e <main+0x1c2>
 1b2:	|  |  |  |  |  |     |  |  |      cmpi.l #2097152,d1
 1b8:	|  |  |  |  |  |  ,--|--|--|----- beq.w 274 <main+0x1e8>
 1bc:	|  |  |  |  |  |  |  |  |  |      subq.l #4,d1
 1be:	|  |  |  |  |  |  |  |  |  |  ,-- bne.s 1e0 <main+0x154>
					BeginRefresh(window);
 1c0:	|  |  |  |  |  |  |  |  |  |  |   movea.l 25ac <IntuitionBase>,a6
 1c6:	|  |  |  |  |  |  |  |  |  |  |   movea.l a3,a0
 1c8:	|  |  |  |  |  |  |  |  |  |  |   jsr -354(a6)
					DrawWindowText(window);
 1cc:	|  |  |  |  |  |  |  |  |  |  |   move.l a3,-(sp)
 1ce:	|  |  |  |  |  |  |  |  |  |  |   jsr (a4)
					EndRefresh(window, TRUE);
 1d0:	|  |  |  |  |  |  |  |  |  |  |   movea.l 25ac <IntuitionBase>,a6
 1d6:	|  |  |  |  |  |  |  |  |  |  |   movea.l a3,a0
 1d8:	|  |  |  |  |  |  |  |  |  |  |   moveq #1,d0
 1da:	|  |  |  |  |  |  |  |  |  |  |   jsr -366(a6)
					break;
 1de:	|  |  |  |  |  |  |  |  |  |  |   addq.l #4,sp
			ReplyMsg((struct Message *)message);
 1e0:	|  |  |  |  |  |  |  |  |  |  '-> movea.l 25b4 <SysBase>,a6
 1e6:	|  |  |  |  |  |  |  |  |  |      movea.l a2,a1
 1e8:	|  |  |  |  |  |  |  |  |  |      jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 1ec:	|  |  |  |  |  |  |  |  |  |      movea.l 25b4 <SysBase>,a6
 1f2:	|  |  |  |  |  |  |  |  |  |      movea.l 86(a3),a0
 1f6:	|  |  |  |  |  |  |  |  |  |      jsr -372(a6)
 1fa:	|  |  |  |  |  |  |  |  |  |      movea.l d0,a2
 1fc:	|  |  |  |  |  |  |  |  |  |      tst.l d0
 1fe:	|  |  |  |  |  +--|--|--|--|----- bne.s 1a4 <main+0x118>
	while (!done) {
 200:	|  |  |  |  |  |  |  |  |  |  ,-> tst.w d3
 202:	|  |  |  |  |  |  |  |  |  '--|-- beq.w 174 <main+0xe8>
	CloseWindow(window);
 206:	|  |  |  |  |  |  |  |  |     |   movea.l 25ac <IntuitionBase>,a6
 20c:	|  |  |  |  |  |  |  |  |     |   movea.l a3,a0
 20e:	|  |  |  |  |  |  |  |  |     |   jsr -72(a6)
	// 	Write(Output(), (APTR)"This program was started from CLI/Shell.\n", 41);
	// 	Write(Output(), (APTR)"Try running it from Workbench for GUI mode.\n", 45);
	// }

	// Clean up libraries
	CloseLibrary((struct Library*)GfxBase);
 212:	|  |  |  |  |  |  |  '--|-----|-> movea.l 25b4 <SysBase>,a6
 218:	|  |  |  |  |  |  |     |     |   movea.l 25b8 <GfxBase>,a1
 21e:	|  |  |  |  |  |  |     |     |   jsr -414(a6)
	CloseLibrary((struct Library*)IntuitionBase);
 222:	|  |  |  |  |  |  |     |     |   movea.l 25b4 <SysBase>,a6
 228:	|  |  |  |  |  |  |     |     |   movea.l 25ac <IntuitionBase>,a1
 22e:	|  |  |  |  |  |  |     |     |   jsr -414(a6)
	CloseLibrary((struct Library*)DOSBase);
 232:	|  |  |  |  |  |  |     |     |   movea.l 25b4 <SysBase>,a6
 238:	|  |  |  |  |  |  |     |     |   movea.l 25b0 <DOSBase>,a1
 23e:	|  |  |  |  |  |  |     |     |   jsr -414(a6)
	
	return 0;
}
 242:	|  |  |  |  |  |  |     |     |   moveq #0,d0
 244:	|  |  |  |  |  |  |     |     |   movem.l (sp)+,d2-d3/a2-a4/a6
 248:	|  |  |  |  |  |  |     |     |   lea 48(sp),sp
 24c:	|  |  |  |  |  |  |     |     |   rts
			switch (message->Class) {
 24e:	|  |  |  |  |  |  |     '-----|-> moveq #1,d3
			ReplyMsg((struct Message *)message);
 250:	|  |  |  |  |  |  |           |   movea.l 25b4 <SysBase>,a6
 256:	|  |  |  |  |  |  |           |   movea.l a2,a1
 258:	|  |  |  |  |  |  |           |   jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 25c:	|  |  |  |  |  |  |           |   movea.l 25b4 <SysBase>,a6
 262:	|  |  |  |  |  |  |           |   movea.l 86(a3),a0
 266:	|  |  |  |  |  |  |           |   jsr -372(a6)
 26a:	|  |  |  |  |  |  |           |   movea.l d0,a2
 26c:	|  |  |  |  |  |  |           |   tst.l d0
 26e:	|  |  |  |  |  +--|-----------|-- bne.w 1a4 <main+0x118>
 272:	|  |  |  |  |  |  |           +-- bra.s 200 <main+0x174>
					if (message->Code == 27) {  // ESC key
 274:	|  |  |  |  |  |  '-----------|-> cmpi.w #27,24(a2)
 27a:	|  |  |  |  |  |              |   seq d0
 27c:	|  |  |  |  |  |              |   ext.w d0
 27e:	|  |  |  |  |  |              |   neg.w d0
 280:	|  |  |  |  |  |              |   or.w d0,d3
			ReplyMsg((struct Message *)message);
 282:	|  |  |  |  |  |              |   movea.l 25b4 <SysBase>,a6
 288:	|  |  |  |  |  |              |   movea.l a2,a1
 28a:	|  |  |  |  |  |              |   jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 28e:	|  |  |  |  |  |              |   movea.l 25b4 <SysBase>,a6
 294:	|  |  |  |  |  |              |   movea.l 86(a3),a0
 298:	|  |  |  |  |  |              |   jsr -372(a6)
 29c:	|  |  |  |  |  |              |   movea.l d0,a2
 29e:	|  |  |  |  |  |              |   tst.l d0
 2a0:	|  |  |  |  |  '--------------|-- bne.w 1a4 <main+0x118>
 2a4:	|  |  |  |  |                 '-- bra.w 200 <main+0x174>
		CloseLibrary((struct Library*)IntuitionBase);
 2a8:	|  |  |  >--|-------------------> movea.l 25b4 <SysBase>,a6
 2ae:	|  |  |  |  |                     movea.l 25ac <IntuitionBase>,a1
 2b4:	|  |  |  |  |                     jsr -414(a6)
		CloseLibrary((struct Library*)DOSBase);
 2b8:	|  |  |  |  |                     movea.l 25b4 <SysBase>,a6
 2be:	|  |  |  |  |                     movea.l 25b0 <DOSBase>,a1
 2c4:	|  |  |  |  |                     jsr -414(a6)
		Exit(0);
 2c8:	|  |  |  |  |                     movea.l 25b0 <DOSBase>,a6
 2ce:	|  |  |  |  |                     moveq #0,d1
 2d0:	|  |  |  |  |                     jsr -144(a6)
 2d4:	|  |  |  |  +-------------------- bra.w ec <main+0x60>
		CloseLibrary((struct Library*)DOSBase);
 2d8:	>--|--|--|--|-------------------> movea.l 25b4 <SysBase>,a6
 2de:	|  |  |  |  |                     movea.l 25b0 <DOSBase>,a1
 2e4:	|  |  |  |  |                     jsr -414(a6)
		Exit(0);
 2e8:	|  |  |  |  |                     movea.l 25b0 <DOSBase>,a6
 2ee:	|  |  |  |  |                     moveq #0,d1
 2f0:	|  |  |  |  |                     jsr -144(a6)
	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
 2f4:	|  |  |  |  |                     movea.l 25b4 <SysBase>,a6
 2fa:	|  |  |  |  |                     lea 57e <DrawWindowText+0x246>,a1
 300:	|  |  |  |  |                     moveq #0,d0
 302:	|  |  |  |  |                     jsr -552(a6)
 306:	|  |  |  |  |                     move.l d0,25b8 <GfxBase>
	if (!GfxBase) {
 30c:	|  |  |  |  '-------------------- bne.w ec <main+0x60>
 310:	|  |  |  '----------------------- bra.s 2a8 <main+0x21c>
		Exit(0);
 312:	|  |  '-------------------------> suba.l a6,a6
 314:	|  |                              moveq #0,d1
 316:	|  |                              jsr -144(a6)
	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
 31a:	|  |                              movea.l 25b4 <SysBase>,a6
 320:	|  |                              lea 56c <DrawWindowText+0x234>,a1
 326:	|  |                              moveq #0,d0
 328:	|  |                              jsr -552(a6)
 32c:	|  |                              move.l d0,25ac <IntuitionBase>
	if (!IntuitionBase) {
 332:	|  '----------------------------- bne.w d0 <main+0x44>
 336:	'-------------------------------- bra.s 2d8 <main+0x24c>

00000338 <DrawWindowText>:
void DrawWindowText(struct Window *window) {
 338:	movem.l d2-d4/a2-a3/a6,-(sp)
 33c:	movea.l 28(sp),a2
	SetAPen(window->RPort, 0);  // White background
 340:	movea.l 25b8 <GfxBase>,a6
 346:	movea.l 50(a2),a1
 34a:	moveq #0,d0
 34c:	jsr -342(a6)
	RectFill(window->RPort, window->BorderLeft, window->BorderTop, 
 350:	move.b 54(a2),d0
 354:	ext.w d0
 356:	move.b 55(a2),d1
 35a:	ext.w d1
 35c:	movea.w 8(a2),a0
 360:	move.b 56(a2),d3
 364:	ext.w d3
 366:	suba.w d3,a0
 368:	move.l a0,d2
 36a:	movea.w 10(a2),a0
 36e:	move.b 57(a2),d4
 372:	ext.w d4
 374:	suba.w d4,a0
 376:	movea.l 25b8 <GfxBase>,a6
 37c:	movea.l 50(a2),a1
 380:	ext.l d0
 382:	ext.l d1
 384:	subq.l #1,d2
 386:	move.l a0,d3
 388:	subq.l #1,d3
 38a:	jsr -306(a6)
	SetAPen(window->RPort, 2);  // Color 2 (usually dark)
 38e:	movea.l 25b8 <GfxBase>,a6
 394:	movea.l 50(a2),a1
 398:	moveq #2,d0
 39a:	jsr -342(a6)
	RectFill(window->RPort, window->BorderLeft + 5, window->BorderTop + 5, 
 39e:	move.b 54(a2),d0
 3a2:	ext.w d0
 3a4:	ext.l d0
 3a6:	move.b 55(a2),d3
 3aa:	ext.w d3
 3ac:	ext.l d3
 3ae:	movea.w 8(a2),a0
 3b2:	move.b 56(a2),d1
 3b6:	ext.w d1
 3b8:	suba.w d1,a0
 3ba:	movea.l 25b8 <GfxBase>,a6
 3c0:	movea.l 50(a2),a1
 3c4:	addq.l #5,d0
 3c6:	move.l d3,d1
 3c8:	addq.l #5,d1
 3ca:	move.l a0,d2
 3cc:	subq.l #6,d2
 3ce:	moveq #85,d4
 3d0:	add.l d4,d3
 3d2:	jsr -306(a6)
	SetAPen(window->RPort, 3);  // Color 3 for text (usually orange/light)
 3d6:	movea.l 25b8 <GfxBase>,a6
 3dc:	movea.l 50(a2),a1
 3e0:	moveq #3,d0
 3e2:	jsr -342(a6)
	SetBPen(window->RPort, 2);  // Background color 2
 3e6:	movea.l 25b8 <GfxBase>,a6
 3ec:	movea.l 50(a2),a1
 3f0:	moveq #2,d0
 3f2:	jsr -348(a6)
	Move(window->RPort, window->BorderLeft + 15, window->BorderTop + 25);
 3f6:	move.b 54(a2),d0
 3fa:	ext.w d0
 3fc:	movea.w d0,a3
 3fe:	move.b 55(a2),d1
 402:	ext.w d1
 404:	movea.w d1,a0
 406:	movea.l 25b8 <GfxBase>,a6
 40c:	movea.l 50(a2),a1
 410:	moveq #15,d0
 412:	add.l a3,d0
 414:	moveq #25,d1
 416:	add.l a0,d1
 418:	jsr -240(a6)
	Text(window->RPort, (STRPTR)"*** HELLO WORKBENCH! ***", 25);
 41c:	movea.l 25b8 <GfxBase>,a6
 422:	movea.l 50(a2),a1
 426:	lea 50e <DrawWindowText+0x1d6>,a0
 42c:	moveq #25,d0
 42e:	jsr -60(a6)
	Move(window->RPort, window->BorderLeft + 15, window->BorderTop + 45);
 432:	move.b 54(a2),d0
 436:	ext.w d0
 438:	movea.w d0,a3
 43a:	move.b 55(a2),d1
 43e:	ext.w d1
 440:	movea.w d1,a0
 442:	movea.l 25b8 <GfxBase>,a6
 448:	movea.l 50(a2),a1
 44c:	moveq #15,d0
 44e:	add.l a3,d0
 450:	moveq #45,d1
 452:	add.l a0,d1
 454:	jsr -240(a6)
	Text(window->RPort, (STRPTR)"Program started from Workbench", 30);
 458:	movea.l 25b8 <GfxBase>,a6
 45e:	movea.l 50(a2),a1
 462:	lea 527 <DrawWindowText+0x1ef>,a0
 468:	moveq #30,d0
 46a:	jsr -60(a6)
	Move(window->RPort, window->BorderLeft + 15, window->BorderTop + 65);
 46e:	move.b 54(a2),d0
 472:	ext.w d0
 474:	movea.w d0,a3
 476:	move.b 55(a2),d1
 47a:	ext.w d1
 47c:	movea.w d1,a0
 47e:	movea.l 25b8 <GfxBase>,a6
 484:	movea.l 50(a2),a1
 488:	moveq #15,d0
 48a:	add.l a3,d0
 48c:	moveq #65,d1
 48e:	add.l a0,d1
 490:	jsr -240(a6)
	Text(window->RPort, (STRPTR)"Close window or press ESC", 25);
 494:	movea.l 25b8 <GfxBase>,a6
 49a:	movea.l 50(a2),a1
 49e:	lea 546 <DrawWindowText+0x20e>,a0
 4a4:	moveq #25,d0
 4a6:	jsr -60(a6)
	SetAPen(window->RPort, 1);  // Black
 4aa:	movea.l 25b8 <GfxBase>,a6
 4b0:	movea.l 50(a2),a1
 4b4:	moveq #1,d0
 4b6:	jsr -342(a6)
	Move(window->RPort, window->BorderLeft + 5, window->BorderTop + 90);
 4ba:	move.b 54(a2),d0
 4be:	ext.w d0
 4c0:	ext.l d0
 4c2:	move.b 55(a2),d1
 4c6:	ext.w d1
 4c8:	movea.w d1,a0
 4ca:	movea.l 25b8 <GfxBase>,a6
 4d0:	movea.l 50(a2),a1
 4d4:	addq.l #5,d0
 4d6:	moveq #90,d1
 4d8:	add.l a0,d1
 4da:	jsr -240(a6)
	Draw(window->RPort, window->Width - window->BorderRight - 6, window->BorderTop + 90);
 4de:	movea.w 8(a2),a0
 4e2:	move.b 56(a2),d1
 4e6:	ext.w d1
 4e8:	suba.w d1,a0
 4ea:	move.l a0,d0
 4ec:	move.b 55(a2),d1
 4f0:	ext.w d1
 4f2:	movea.w d1,a0
 4f4:	movea.l 25b8 <GfxBase>,a6
 4fa:	movea.l 50(a2),a1
 4fe:	subq.l #6,d0
 500:	moveq #90,d1
 502:	add.l a0,d1
 504:	jsr -246(a6)
}
 508:	movem.l (sp)+,d2-d4/a2-a3/a6
 50c:	rts
