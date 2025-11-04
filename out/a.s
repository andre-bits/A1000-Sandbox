
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
   4:	       move.l #9941,d3
   a:	       subi.l #9941,d3
  10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	       move.l #9941,d0
  18:	       cmpi.l #9941,d0
  1e:	,----- beq.s 32 <_start+0x32>
  20:	|      lea 26d5 <_edata>,a2
  26:	|      moveq #0,d2
		__preinit_array_start[i]();
  28:	|  ,-> movea.l (a2)+,a0
  2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  2c:	|  |   addq.l #1,d2
  2e:	|  |   cmp.l d3,d2
  30:	|  '-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
  32:	'----> move.l #9941,d3
  38:	       subi.l #9941,d3
  3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  40:	       move.l #9941,d0
  46:	       cmpi.l #9941,d0
  4c:	,----- beq.s 60 <_start+0x60>
  4e:	|      lea 26d5 <_edata>,a2
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
  66:	       move.l #9941,d2
  6c:	       subi.l #9941,d2
  72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  74:	,----- beq.s 86 <_start+0x86>
  76:	|      lea 26d5 <_edata>,a2
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
  8c:	                               lea -48(sp),sp
  90:	                               movem.l d2-d3/a2-a4/a6,-(sp)
	SysBase = *((struct ExecBase**)4UL);
  94:	                               movea.l 4 <_start+0x4>,a6
  98:	                               move.l a6,26de <SysBase>

	// Open required libraries
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  9e:	                               lea 622 <DrawWindowText+0x228>,a1
  a4:	                               moveq #0,d0
  a6:	                               jsr -552(a6)
  aa:	                               move.l d0,26da <DOSBase>
	if (!DOSBase)
  b0:	      ,----------------------- beq.w 378 <main+0x2ec>
		Exit(0);

	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
  b4:	      |                        movea.l 26de <SysBase>,a6
  ba:	      |                        lea 62e <DrawWindowText+0x234>,a1
  c0:	      |                        moveq #0,d0
  c2:	      |                        jsr -552(a6)
  c6:	      |                        move.l d0,26d6 <IntuitionBase>
	if (!IntuitionBase) {
  cc:	,-----|----------------------- beq.w 33c <main+0x2b0>
		CloseLibrary((struct Library*)DOSBase);
		Exit(0);
	}

	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
  d0:	|  ,--|----------------------> movea.l 26de <SysBase>,a6
  d6:	|  |  |                        lea 640 <DrawWindowText+0x246>,a1
  dc:	|  |  |                        moveq #0,d0
  de:	|  |  |                        jsr -552(a6)
  e2:	|  |  |                        move.l d0,26e2 <GfxBase>
	if (!GfxBase) {
  e8:	|  |  |  ,-------------------- beq.w 198 <main+0x10c>
	struct Process *proc = (struct Process *)FindTask(NULL);
  ec:	|  |  |  |  ,----------------> movea.l 26de <SysBase>,a6
  f2:	|  |  |  |  |                  suba.l a1,a1
  f4:	|  |  |  |  |                  jsr -294(a6)
		CloseLibrary((struct Library*)DOSBase);
		Exit(0);
	}

	// Check if started from Workbench
	if (IsWorkbenchStartup()) {
  f8:	|  |  |  |  |                  movea.l d0,a0
  fa:	|  |  |  |  |                  tst.l 172(a0)
  fe:	|  |  |  |  |           ,----- beq.w 1da <main+0x14e>
		// Started from Workbench - create window
		WorkbenchMode();
	} else {
		// Started from CLI/Shell - console output
		Write(Output(), (APTR)"Hello console!\n", 15);
 102:	|  |  |  |  |           |  ,-> movea.l 26da <DOSBase>,a6
 108:	|  |  |  |  |           |  |   jsr -60(a6)
 10c:	|  |  |  |  |           |  |   movea.l 26da <DOSBase>,a6
 112:	|  |  |  |  |           |  |   move.l d0,d1
 114:	|  |  |  |  |           |  |   move.l #1646,d2
 11a:	|  |  |  |  |           |  |   moveq #15,d3
 11c:	|  |  |  |  |           |  |   jsr -48(a6)
		Write(Output(), (APTR)"This program was started from CLI/Shell.\n", 41);
 120:	|  |  |  |  |           |  |   movea.l 26da <DOSBase>,a6
 126:	|  |  |  |  |           |  |   jsr -60(a6)
 12a:	|  |  |  |  |           |  |   movea.l 26da <DOSBase>,a6
 130:	|  |  |  |  |           |  |   move.l d0,d1
 132:	|  |  |  |  |           |  |   move.l #1662,d2
 138:	|  |  |  |  |           |  |   moveq #41,d3
 13a:	|  |  |  |  |           |  |   jsr -48(a6)
		Write(Output(), (APTR)"Try running it from Workbench for GUI mode.\n", 45);
 13e:	|  |  |  |  |           |  |   movea.l 26da <DOSBase>,a6
 144:	|  |  |  |  |           |  |   jsr -60(a6)
 148:	|  |  |  |  |           |  |   movea.l 26da <DOSBase>,a6
 14e:	|  |  |  |  |           |  |   move.l d0,d1
 150:	|  |  |  |  |           |  |   move.l #1704,d2
 156:	|  |  |  |  |           |  |   moveq #45,d3
 158:	|  |  |  |  |           |  |   jsr -48(a6)
	}

	// Clean up libraries
	CloseLibrary((struct Library*)GfxBase);
 15c:	|  |  |  |  |        ,--|--|-> movea.l 26de <SysBase>,a6
 162:	|  |  |  |  |        |  |  |   movea.l 26e2 <GfxBase>,a1
 168:	|  |  |  |  |        |  |  |   jsr -414(a6)
	CloseLibrary((struct Library*)IntuitionBase);
 16c:	|  |  |  |  |        |  |  |   movea.l 26de <SysBase>,a6
 172:	|  |  |  |  |        |  |  |   movea.l 26d6 <IntuitionBase>,a1
 178:	|  |  |  |  |        |  |  |   jsr -414(a6)
	CloseLibrary((struct Library*)DOSBase);
 17c:	|  |  |  |  |        |  |  |   movea.l 26de <SysBase>,a6
 182:	|  |  |  |  |        |  |  |   movea.l 26da <DOSBase>,a1
 188:	|  |  |  |  |        |  |  |   jsr -414(a6)
	
	return 0;
}
 18c:	|  |  |  |  |        |  |  |   moveq #0,d0
 18e:	|  |  |  |  |        |  |  |   movem.l (sp)+,d2-d3/a2-a4/a6
 192:	|  |  |  |  |        |  |  |   lea 48(sp),sp
 196:	|  |  |  |  |        |  |  |   rts
		CloseLibrary((struct Library*)IntuitionBase);
 198:	|  |  |  >--|--------|--|--|-> movea.l 26de <SysBase>,a6
 19e:	|  |  |  |  |        |  |  |   movea.l 26d6 <IntuitionBase>,a1
 1a4:	|  |  |  |  |        |  |  |   jsr -414(a6)
		CloseLibrary((struct Library*)DOSBase);
 1a8:	|  |  |  |  |        |  |  |   movea.l 26de <SysBase>,a6
 1ae:	|  |  |  |  |        |  |  |   movea.l 26da <DOSBase>,a1
 1b4:	|  |  |  |  |        |  |  |   jsr -414(a6)
		Exit(0);
 1b8:	|  |  |  |  |        |  |  |   movea.l 26da <DOSBase>,a6
 1be:	|  |  |  |  |        |  |  |   moveq #0,d1
 1c0:	|  |  |  |  |        |  |  |   jsr -144(a6)
	struct Process *proc = (struct Process *)FindTask(NULL);
 1c4:	|  |  |  |  |        |  |  |   movea.l 26de <SysBase>,a6
 1ca:	|  |  |  |  |        |  |  |   suba.l a1,a1
 1cc:	|  |  |  |  |        |  |  |   jsr -294(a6)
	if (IsWorkbenchStartup()) {
 1d0:	|  |  |  |  |        |  |  |   movea.l d0,a0
 1d2:	|  |  |  |  |        |  |  |   tst.l 172(a0)
 1d6:	|  |  |  |  |        |  |  '-- bne.w 102 <main+0x76>
	nw.LeftEdge = 50;
 1da:	|  |  |  |  |        |  '----> move.w #50,24(sp)
	nw.TopEdge = 50;
 1e0:	|  |  |  |  |        |         move.w #50,26(sp)
	nw.Width = 400;
 1e6:	|  |  |  |  |        |         move.w #400,28(sp)
	nw.Height = 200;
 1ec:	|  |  |  |  |        |         move.w #200,30(sp)
	nw.DetailPen = 0;
 1f2:	|  |  |  |  |        |         move.w #1,32(sp)
	nw.IDCMPFlags = CLOSEWINDOW | MOUSEBUTTONS | VANILLAKEY | REFRESHWINDOW;
 1f8:	|  |  |  |  |        |         move.l #2097676,34(sp)
	nw.Flags = WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH | ACTIVATE | SMART_REFRESH;
 200:	|  |  |  |  |        |         move.l #4110,38(sp)
	nw.FirstGadget = NULL;
 208:	|  |  |  |  |        |         clr.l 42(sp)
	nw.CheckMark = NULL;
 20c:	|  |  |  |  |        |         clr.l 46(sp)
	nw.Title = (UBYTE *)"*** AMIGA WORKBENCH TEST ***";
 210:	|  |  |  |  |        |         move.l #1617,50(sp)
	nw.Screen = NULL;  // Use default Workbench screen
 218:	|  |  |  |  |        |         clr.l 54(sp)
	nw.BitMap = NULL;
 21c:	|  |  |  |  |        |         clr.l 58(sp)
	nw.MinWidth = 200;
 220:	|  |  |  |  |        |         move.w #200,62(sp)
	nw.MinHeight = 100;
 226:	|  |  |  |  |        |         move.w #100,64(sp)
	nw.MaxWidth = 640;
 22c:	|  |  |  |  |        |         move.w #640,66(sp)
	nw.MaxHeight = 400;
 232:	|  |  |  |  |        |         move.w #400,68(sp)
	nw.Type = WBENCHSCREEN;
 238:	|  |  |  |  |        |         move.w #1,70(sp)
	window = OpenWindow(&nw);
 23e:	|  |  |  |  |        |         movea.l 26d6 <IntuitionBase>,a6
 244:	|  |  |  |  |        |         lea 24(sp),a0
 248:	|  |  |  |  |        |         jsr -204(a6)
 24c:	|  |  |  |  |        |         movea.l d0,a3
	if (!window) {
 24e:	|  |  |  |  |        |         tst.l d0
 250:	|  |  |  |  |        '-------- beq.w 15c <main+0xd0>
	DrawWindowText(window);
 254:	|  |  |  |  |                  move.l d0,-(sp)
 256:	|  |  |  |  |                  lea 3fa <DrawWindowText>,a4
 25c:	|  |  |  |  |                  jsr (a4)
 25e:	|  |  |  |  |                  addq.l #4,sp
		Wait(1L << window->UserPort->mp_SigBit);
 260:	|  |  |  |  |                  moveq #1,d2
 262:	|  |  |  |  |           ,----> movea.l 86(a3),a0
 266:	|  |  |  |  |           |      moveq #0,d0
 268:	|  |  |  |  |           |      move.b 15(a0),d0
 26c:	|  |  |  |  |           |      movea.l 26de <SysBase>,a6
 272:	|  |  |  |  |           |      move.l d2,d1
 274:	|  |  |  |  |           |      lsl.l d0,d1
 276:	|  |  |  |  |           |      move.l d1,d0
 278:	|  |  |  |  |           |      jsr -318(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 27c:	|  |  |  |  |           |      movea.l 26de <SysBase>,a6
 282:	|  |  |  |  |           |      movea.l 86(a3),a0
 286:	|  |  |  |  |           |      jsr -372(a6)
 28a:	|  |  |  |  |           |      movea.l d0,a2
 28c:	|  |  |  |  |           |      tst.l d0
 28e:	|  |  |  |  |           +----- beq.s 262 <main+0x1d6>
 290:	|  |  |  |  |           |      clr.w d3
			switch (message->Class) {
 292:	|  |  |  |  |  ,--------|----> move.l 20(a2),d1
 296:	|  |  |  |  |  |        |      cmpi.l #512,d1
 29c:	|  |  |  |  |  |  ,-----|----- beq.w 3d2 <main+0x346>
 2a0:	|  |  |  |  |  |  |     |      cmpi.l #2097152,d1
 2a6:	|  |  |  |  |  |  |  ,--|----- beq.w 39e <main+0x312>
 2aa:	|  |  |  |  |  |  |  |  |      subq.l #4,d1
 2ac:	|  |  |  |  |  |  |  |  |  ,-- bne.s 2ce <main+0x242>
					BeginRefresh(window);
 2ae:	|  |  |  |  |  |  |  |  |  |   movea.l 26d6 <IntuitionBase>,a6
 2b4:	|  |  |  |  |  |  |  |  |  |   movea.l a3,a0
 2b6:	|  |  |  |  |  |  |  |  |  |   jsr -354(a6)
					DrawWindowText(window);
 2ba:	|  |  |  |  |  |  |  |  |  |   move.l a3,-(sp)
 2bc:	|  |  |  |  |  |  |  |  |  |   jsr (a4)
					EndRefresh(window, TRUE);
 2be:	|  |  |  |  |  |  |  |  |  |   movea.l 26d6 <IntuitionBase>,a6
 2c4:	|  |  |  |  |  |  |  |  |  |   movea.l a3,a0
 2c6:	|  |  |  |  |  |  |  |  |  |   moveq #1,d0
 2c8:	|  |  |  |  |  |  |  |  |  |   jsr -366(a6)
					break;
 2cc:	|  |  |  |  |  |  |  |  |  |   addq.l #4,sp
			ReplyMsg((struct Message *)message);
 2ce:	|  |  |  |  |  |  |  |  |  '-> movea.l 26de <SysBase>,a6
 2d4:	|  |  |  |  |  |  |  |  |      movea.l a2,a1
 2d6:	|  |  |  |  |  |  |  |  |      jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 2da:	|  |  |  |  |  |  |  |  |      movea.l 26de <SysBase>,a6
 2e0:	|  |  |  |  |  |  |  |  |      movea.l 86(a3),a0
 2e4:	|  |  |  |  |  |  |  |  |      jsr -372(a6)
 2e8:	|  |  |  |  |  |  |  |  |      movea.l d0,a2
 2ea:	|  |  |  |  |  |  |  |  |      tst.l d0
 2ec:	|  |  |  |  |  +--|--|--|----- bne.s 292 <main+0x206>
	while (!done) {
 2ee:	|  |  |  |  |  |  |  |  |  ,-> tst.w d3
 2f0:	|  |  |  |  |  |  |  |  '--|-- beq.w 262 <main+0x1d6>
	CloseWindow(window);
 2f4:	|  |  |  |  |  |  |  |     |   movea.l 26d6 <IntuitionBase>,a6
 2fa:	|  |  |  |  |  |  |  |     |   movea.l a3,a0
 2fc:	|  |  |  |  |  |  |  |     |   jsr -72(a6)
	CloseLibrary((struct Library*)GfxBase);
 300:	|  |  |  |  |  |  |  |     |   movea.l 26de <SysBase>,a6
 306:	|  |  |  |  |  |  |  |     |   movea.l 26e2 <GfxBase>,a1
 30c:	|  |  |  |  |  |  |  |     |   jsr -414(a6)
	CloseLibrary((struct Library*)IntuitionBase);
 310:	|  |  |  |  |  |  |  |     |   movea.l 26de <SysBase>,a6
 316:	|  |  |  |  |  |  |  |     |   movea.l 26d6 <IntuitionBase>,a1
 31c:	|  |  |  |  |  |  |  |     |   jsr -414(a6)
	CloseLibrary((struct Library*)DOSBase);
 320:	|  |  |  |  |  |  |  |     |   movea.l 26de <SysBase>,a6
 326:	|  |  |  |  |  |  |  |     |   movea.l 26da <DOSBase>,a1
 32c:	|  |  |  |  |  |  |  |     |   jsr -414(a6)
}
 330:	|  |  |  |  |  |  |  |     |   moveq #0,d0
 332:	|  |  |  |  |  |  |  |     |   movem.l (sp)+,d2-d3/a2-a4/a6
 336:	|  |  |  |  |  |  |  |     |   lea 48(sp),sp
 33a:	|  |  |  |  |  |  |  |     |   rts
		CloseLibrary((struct Library*)DOSBase);
 33c:	>--|--|--|--|--|--|--|-----|-> movea.l 26de <SysBase>,a6
 342:	|  |  |  |  |  |  |  |     |   movea.l 26da <DOSBase>,a1
 348:	|  |  |  |  |  |  |  |     |   jsr -414(a6)
		Exit(0);
 34c:	|  |  |  |  |  |  |  |     |   movea.l 26da <DOSBase>,a6
 352:	|  |  |  |  |  |  |  |     |   moveq #0,d1
 354:	|  |  |  |  |  |  |  |     |   jsr -144(a6)
	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
 358:	|  |  |  |  |  |  |  |     |   movea.l 26de <SysBase>,a6
 35e:	|  |  |  |  |  |  |  |     |   lea 640 <DrawWindowText+0x246>,a1
 364:	|  |  |  |  |  |  |  |     |   moveq #0,d0
 366:	|  |  |  |  |  |  |  |     |   jsr -552(a6)
 36a:	|  |  |  |  |  |  |  |     |   move.l d0,26e2 <GfxBase>
	if (!GfxBase) {
 370:	|  |  |  |  '--|--|--|-----|-- bne.w ec <main+0x60>
 374:	|  |  |  '-----|--|--|-----|-- bra.w 198 <main+0x10c>
		Exit(0);
 378:	|  |  '--------|--|--|-----|-> suba.l a6,a6
 37a:	|  |           |  |  |     |   moveq #0,d1
 37c:	|  |           |  |  |     |   jsr -144(a6)
	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
 380:	|  |           |  |  |     |   movea.l 26de <SysBase>,a6
 386:	|  |           |  |  |     |   lea 62e <DrawWindowText+0x234>,a1
 38c:	|  |           |  |  |     |   moveq #0,d0
 38e:	|  |           |  |  |     |   jsr -552(a6)
 392:	|  |           |  |  |     |   move.l d0,26d6 <IntuitionBase>
	if (!IntuitionBase) {
 398:	|  '-----------|--|--|-----|-- bne.w d0 <main+0x44>
 39c:	'--------------|--|--|-----|-- bra.s 33c <main+0x2b0>
					if (message->Code == 27) {  // ESC key
 39e:	               |  |  '-----|-> cmpi.w #27,24(a2)
 3a4:	               |  |        |   seq d0
 3a6:	               |  |        |   ext.w d0
 3a8:	               |  |        |   neg.w d0
 3aa:	               |  |        |   or.w d0,d3
			ReplyMsg((struct Message *)message);
 3ac:	               |  |        |   movea.l 26de <SysBase>,a6
 3b2:	               |  |        |   movea.l a2,a1
 3b4:	               |  |        |   jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 3b8:	               |  |        |   movea.l 26de <SysBase>,a6
 3be:	               |  |        |   movea.l 86(a3),a0
 3c2:	               |  |        |   jsr -372(a6)
 3c6:	               |  |        |   movea.l d0,a2
 3c8:	               |  |        |   tst.l d0
 3ca:	               +--|--------|-- bne.w 292 <main+0x206>
 3ce:	               |  |        +-- bra.w 2ee <main+0x262>
			switch (message->Class) {
 3d2:	               |  '--------|-> moveq #1,d3
			ReplyMsg((struct Message *)message);
 3d4:	               |           |   movea.l 26de <SysBase>,a6
 3da:	               |           |   movea.l a2,a1
 3dc:	               |           |   jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 3e0:	               |           |   movea.l 26de <SysBase>,a6
 3e6:	               |           |   movea.l 86(a3),a0
 3ea:	               |           |   jsr -372(a6)
 3ee:	               |           |   movea.l d0,a2
 3f0:	               |           |   tst.l d0
 3f2:	               '-----------|-- bne.w 292 <main+0x206>
 3f6:	                           '-- bra.w 2ee <main+0x262>

000003fa <DrawWindowText>:
void DrawWindowText(struct Window *window) {
 3fa:	movem.l d2-d4/a2-a3/a6,-(sp)
 3fe:	movea.l 28(sp),a2
	SetAPen(window->RPort, 0);  // White background
 402:	movea.l 26e2 <GfxBase>,a6
 408:	movea.l 50(a2),a1
 40c:	moveq #0,d0
 40e:	jsr -342(a6)
	RectFill(window->RPort, window->BorderLeft, window->BorderTop, 
 412:	move.b 54(a2),d0
 416:	ext.w d0
 418:	move.b 55(a2),d1
 41c:	ext.w d1
 41e:	movea.w 8(a2),a0
 422:	move.b 56(a2),d3
 426:	ext.w d3
 428:	suba.w d3,a0
 42a:	move.l a0,d2
 42c:	movea.w 10(a2),a0
 430:	move.b 57(a2),d4
 434:	ext.w d4
 436:	suba.w d4,a0
 438:	movea.l 26e2 <GfxBase>,a6
 43e:	movea.l 50(a2),a1
 442:	ext.l d0
 444:	ext.l d1
 446:	subq.l #1,d2
 448:	move.l a0,d3
 44a:	subq.l #1,d3
 44c:	jsr -306(a6)
	SetAPen(window->RPort, 2);  // Color 2 (usually dark)
 450:	movea.l 26e2 <GfxBase>,a6
 456:	movea.l 50(a2),a1
 45a:	moveq #2,d0
 45c:	jsr -342(a6)
	RectFill(window->RPort, window->BorderLeft + 5, window->BorderTop + 5, 
 460:	move.b 54(a2),d0
 464:	ext.w d0
 466:	ext.l d0
 468:	move.b 55(a2),d3
 46c:	ext.w d3
 46e:	ext.l d3
 470:	movea.w 8(a2),a0
 474:	move.b 56(a2),d1
 478:	ext.w d1
 47a:	suba.w d1,a0
 47c:	movea.l 26e2 <GfxBase>,a6
 482:	movea.l 50(a2),a1
 486:	addq.l #5,d0
 488:	move.l d3,d1
 48a:	addq.l #5,d1
 48c:	move.l a0,d2
 48e:	subq.l #6,d2
 490:	moveq #85,d4
 492:	add.l d4,d3
 494:	jsr -306(a6)
	SetAPen(window->RPort, 3);  // Color 3 for text (usually orange/light)
 498:	movea.l 26e2 <GfxBase>,a6
 49e:	movea.l 50(a2),a1
 4a2:	moveq #3,d0
 4a4:	jsr -342(a6)
	SetBPen(window->RPort, 2);  // Background color 2
 4a8:	movea.l 26e2 <GfxBase>,a6
 4ae:	movea.l 50(a2),a1
 4b2:	moveq #2,d0
 4b4:	jsr -348(a6)
	Move(window->RPort, window->BorderLeft + 15, window->BorderTop + 25);
 4b8:	move.b 54(a2),d0
 4bc:	ext.w d0
 4be:	movea.w d0,a3
 4c0:	move.b 55(a2),d1
 4c4:	ext.w d1
 4c6:	movea.w d1,a0
 4c8:	movea.l 26e2 <GfxBase>,a6
 4ce:	movea.l 50(a2),a1
 4d2:	moveq #15,d0
 4d4:	add.l a3,d0
 4d6:	moveq #25,d1
 4d8:	add.l a0,d1
 4da:	jsr -240(a6)
	Text(window->RPort, (STRPTR)"*** HELLO WORKBENCH! ***", 25);
 4de:	movea.l 26e2 <GfxBase>,a6
 4e4:	movea.l 50(a2),a1
 4e8:	lea 5d0 <DrawWindowText+0x1d6>,a0
 4ee:	moveq #25,d0
 4f0:	jsr -60(a6)
	Move(window->RPort, window->BorderLeft + 15, window->BorderTop + 45);
 4f4:	move.b 54(a2),d0
 4f8:	ext.w d0
 4fa:	movea.w d0,a3
 4fc:	move.b 55(a2),d1
 500:	ext.w d1
 502:	movea.w d1,a0
 504:	movea.l 26e2 <GfxBase>,a6
 50a:	movea.l 50(a2),a1
 50e:	moveq #15,d0
 510:	add.l a3,d0
 512:	moveq #45,d1
 514:	add.l a0,d1
 516:	jsr -240(a6)
	Text(window->RPort, (STRPTR)"Program started from Workbench", 30);
 51a:	movea.l 26e2 <GfxBase>,a6
 520:	movea.l 50(a2),a1
 524:	lea 5e9 <DrawWindowText+0x1ef>,a0
 52a:	moveq #30,d0
 52c:	jsr -60(a6)
	Move(window->RPort, window->BorderLeft + 15, window->BorderTop + 65);
 530:	move.b 54(a2),d0
 534:	ext.w d0
 536:	movea.w d0,a3
 538:	move.b 55(a2),d1
 53c:	ext.w d1
 53e:	movea.w d1,a0
 540:	movea.l 26e2 <GfxBase>,a6
 546:	movea.l 50(a2),a1
 54a:	moveq #15,d0
 54c:	add.l a3,d0
 54e:	moveq #65,d1
 550:	add.l a0,d1
 552:	jsr -240(a6)
	Text(window->RPort, (STRPTR)"Close window or press ESC", 25);
 556:	movea.l 26e2 <GfxBase>,a6
 55c:	movea.l 50(a2),a1
 560:	lea 608 <DrawWindowText+0x20e>,a0
 566:	moveq #25,d0
 568:	jsr -60(a6)
	SetAPen(window->RPort, 1);  // Black
 56c:	movea.l 26e2 <GfxBase>,a6
 572:	movea.l 50(a2),a1
 576:	moveq #1,d0
 578:	jsr -342(a6)
	Move(window->RPort, window->BorderLeft + 5, window->BorderTop + 90);
 57c:	move.b 54(a2),d0
 580:	ext.w d0
 582:	ext.l d0
 584:	move.b 55(a2),d1
 588:	ext.w d1
 58a:	movea.w d1,a0
 58c:	movea.l 26e2 <GfxBase>,a6
 592:	movea.l 50(a2),a1
 596:	addq.l #5,d0
 598:	moveq #90,d1
 59a:	add.l a0,d1
 59c:	jsr -240(a6)
	Draw(window->RPort, window->Width - window->BorderRight - 6, window->BorderTop + 90);
 5a0:	movea.w 8(a2),a0
 5a4:	move.b 56(a2),d1
 5a8:	ext.w d1
 5aa:	suba.w d1,a0
 5ac:	move.l a0,d0
 5ae:	move.b 55(a2),d1
 5b2:	ext.w d1
 5b4:	movea.w d1,a0
 5b6:	movea.l 26e2 <GfxBase>,a6
 5bc:	movea.l 50(a2),a1
 5c0:	subq.l #6,d0
 5c2:	moveq #90,d1
 5c4:	add.l a0,d1
 5c6:	jsr -246(a6)
}
 5ca:	movem.l (sp)+,d2-d4/a2-a3/a6
 5ce:	rts
