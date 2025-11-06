
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
   4:	       move.l #9846,d3
   a:	       subi.l #9846,d3
  10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	       move.l #9846,d0
  18:	       cmpi.l #9846,d0
  1e:	,----- beq.s 32 <_start+0x32>
  20:	|      lea 2676 <buttonBorderData>,a2
  26:	|      moveq #0,d2
		__preinit_array_start[i]();
  28:	|  ,-> movea.l (a2)+,a0
  2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  2c:	|  |   addq.l #1,d2
  2e:	|  |   cmp.l d3,d2
  30:	|  '-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
  32:	'----> move.l #9846,d3
  38:	       subi.l #9846,d3
  3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  40:	       move.l #9846,d0
  46:	       cmpi.l #9846,d0
  4c:	,----- beq.s 60 <_start+0x60>
  4e:	|      lea 2676 <buttonBorderData>,a2
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
  66:	       move.l #9846,d2
  6c:	       subi.l #9846,d2
  72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  74:	,----- beq.s 86 <_start+0x86>
  76:	|      lea 2676 <buttonBorderData>,a2
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
  8c:	                                                 lea -48(sp),sp
  90:	                                                 movem.l d2-d7/a2-a6,-(sp)
	SysBase = *(struct ExecBase**)4;
  94:	                                                 movea.l 4 <_start+0x4>,a6
  98:	                                                 move.l a6,26e8 <SysBase>

	// Open required libraries
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  9e:	                                                 lea 5ea <main+0x55e>,a1
  a4:	                                                 moveq #0,d0
  a6:	                                                 jsr -552(a6)
  aa:	                                                 move.l d0,26e4 <DOSBase>
	if (!DOSBase)
  b0:	      ,----------------------------------------- beq.w 5c4 <main+0x538>
		Exit(0);

	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
  b4:	      |                                          movea.l 26e8 <SysBase>,a6
  ba:	      |                                          lea 5f6 <main+0x56a>,a1
  c0:	      |                                          moveq #0,d0
  c2:	      |                                          jsr -552(a6)
  c6:	      |                                          move.l d0,26e0 <IntuitionBase>
	if (!IntuitionBase) {
  cc:	,-----|----------------------------------------- beq.w 58a <main+0x4fe>
		CloseLibrary((struct Library*)DOSBase);
		Exit(0);
	}

	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
  d0:	|  ,--|----------------------------------------> movea.l 26e8 <SysBase>,a6
  d6:	|  |  |                                          lea 608 <main+0x57c>,a1
  dc:	|  |  |                                          moveq #0,d0
  de:	|  |  |                                          jsr -552(a6)
  e2:	|  |  |                                          move.l d0,26dc <GfxBase>
	if (!GfxBase) {
  e8:	|  |  |  ,-------------------------------------- beq.w 55a <main+0x4ce>
	nw.LeftEdge = 50;
  ec:	|  |  |  |  ,----------------------------------> move.w #50,44(sp)
	nw.TopEdge = 50;
  f2:	|  |  |  |  |                                    move.w #50,46(sp)
	nw.Width = 400;
  f8:	|  |  |  |  |                                    move.w #400,48(sp)
	nw.Height = 150;
  fe:	|  |  |  |  |                                    move.w #150,50(sp)
	nw.DetailPen = 0;
 104:	|  |  |  |  |                                    move.w #1,52(sp)
	nw.IDCMPFlags = CLOSEWINDOW | MOUSEBUTTONS | VANILLAKEY | REFRESHWINDOW | GADGETUP;
 10a:	|  |  |  |  |                                    move.l #2097740,54(sp)
	nw.Flags = WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH | ACTIVATE | SMART_REFRESH;
 112:	|  |  |  |  |                                    move.l #4110,58(sp)
	nw.FirstGadget = &colorButton;
 11a:	|  |  |  |  |                                    move.l #9902,62(sp)
	nw.CheckMark = NULL;
 122:	|  |  |  |  |                                    clr.l 66(sp)
	nw.Title = (UBYTE *)"AMIGA SANDBOX";
 126:	|  |  |  |  |                                    move.l #1561,70(sp)
	nw.Screen = NULL;  // Use default Workbench screen
 12e:	|  |  |  |  |                                    clr.l 74(sp)
	nw.BitMap = NULL;
 132:	|  |  |  |  |                                    clr.l 78(sp)
	nw.MinWidth = 200;
 136:	|  |  |  |  |                                    move.w #200,82(sp)
	nw.MinHeight = 100;
 13c:	|  |  |  |  |                                    move.w #100,84(sp)
	nw.MaxWidth = 640;
 142:	|  |  |  |  |                                    move.w #640,86(sp)
	nw.MaxHeight = 400;
 148:	|  |  |  |  |                                    move.w #400,88(sp)
	nw.Type = WBENCHSCREEN;
 14e:	|  |  |  |  |                                    move.w #1,90(sp)
	window = OpenWindow(&nw);
 154:	|  |  |  |  |                                    movea.l 26e0 <IntuitionBase>,a6
 15a:	|  |  |  |  |                                    lea 44(sp),a0
 15e:	|  |  |  |  |                                    jsr -204(a6)
 162:	|  |  |  |  |                                    movea.l d0,a4
	if (!window) {
 164:	|  |  |  |  |                                    tst.l d0
 166:	|  |  |  |  |                 ,----------------- beq.w 310 <main+0x284>
	struct RastPort *rp = window->RPort;
 16a:	|  |  |  |  |                 |                  move.l 50(a4),d4
	SetAPen(rp, 3);
 16e:	|  |  |  |  |                 |                  movea.l 26dc <GfxBase>,a6
 174:	|  |  |  |  |                 |                  movea.l d4,a1
 176:	|  |  |  |  |                 |                  moveq #3,d0
 178:	|  |  |  |  |                 |                  jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 17c:	|  |  |  |  |                 |                  movea.l 26dc <GfxBase>,a6
 182:	|  |  |  |  |                 |                  movea.l d4,a1
 184:	|  |  |  |  |                 |                  moveq #101,d0
 186:	|  |  |  |  |                 |                  moveq #61,d1
 188:	|  |  |  |  |                 |                  move.l #298,d2
 18e:	|  |  |  |  |                 |                  moveq #89,d3
 190:	|  |  |  |  |                 |                  jsr -306(a6)
	SetAPen(rp, 1);
 194:	|  |  |  |  |                 |                  movea.l 26dc <GfxBase>,a6
 19a:	|  |  |  |  |                 |                  movea.l d4,a1
 19c:	|  |  |  |  |                 |                  moveq #1,d0
 19e:	|  |  |  |  |                 |                  jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 1a2:	|  |  |  |  |                 |                  movea.l 26e0 <IntuitionBase>,a6
 1a8:	|  |  |  |  |                 |                  lea 26ae <colorButton>,a0
 1ae:	|  |  |  |  |                 |                  movea.l a4,a1
 1b0:	|  |  |  |  |                 |                  suba.l a2,a2
 1b2:	|  |  |  |  |                 |                  jsr -222(a6)
		Wait(1L << window->UserPort->mp_SigBit);
 1b6:	|  |  |  |  |                 |                  moveq #1,d7
	RectFill(rp, 101, 61, 298, 89);
 1b8:	|  |  |  |  |                 |                  move.l d2,d5
	RefreshGadgets(&colorButton, window, NULL);
 1ba:	|  |  |  |  |                 |                  move.l #9902,d6
						SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX - White Background", (UBYTE *)-1);
 1c0:	|  |  |  |  |                 |                  lea 648 <main+0x5bc>,a5
		Wait(1L << window->UserPort->mp_SigBit);
 1c6:	|  |  |  |  |                 |              ,-> movea.l 86(a4),a0
 1ca:	|  |  |  |  |                 |              |   moveq #0,d0
 1cc:	|  |  |  |  |                 |              |   move.b 15(a0),d0
 1d0:	|  |  |  |  |                 |              |   movea.l 26e8 <SysBase>,a6
 1d6:	|  |  |  |  |                 |              |   move.l d7,d1
 1d8:	|  |  |  |  |                 |              |   lsl.l d0,d1
 1da:	|  |  |  |  |                 |              |   move.l d1,d0
 1dc:	|  |  |  |  |                 |              |   jsr -318(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 1e0:	|  |  |  |  |                 |              |   movea.l 26e8 <SysBase>,a6
 1e6:	|  |  |  |  |                 |              |   movea.l 86(a4),a0
 1ea:	|  |  |  |  |                 |              |   jsr -372(a6)
 1ee:	|  |  |  |  |                 |              |   movea.l d0,a3
 1f0:	|  |  |  |  |                 |              |   tst.l d0
 1f2:	|  |  |  |  |                 |              +-- beq.s 1c6 <main+0x13a>
 1f4:	|  |  |  |  |                 |              |   clr.w d4
			switch (message->Class) {
 1f6:	|  |  |  |  |  ,--------------|--------------|-> move.l 20(a3),d0
 1fa:	|  |  |  |  |  |              |              |   cmpi.l #512,d0
 200:	|  |  |  |  |  |              |     ,--------|-- beq.w 388 <main+0x2fc>
 204:	|  |  |  |  |  |              |     |  ,-----|-- bhi.w 34c <main+0x2c0>
 208:	|  |  |  |  |  |              |     |  |     |   moveq #4,d3
 20a:	|  |  |  |  |  |              |     |  |     |   cmp.l d0,d3
 20c:	|  |  |  |  |  |              |  ,--|--|-----|-- beq.w 3b0 <main+0x324>
 210:	|  |  |  |  |  |              |  |  |  |     |   moveq #64,d1
 212:	|  |  |  |  |  |              |  |  |  |     |   cmp.l d0,d1
 214:	|  |  |  |  |  |              |  |  |  |  ,--|-- bne.w 2dc <main+0x250>
	struct RastPort *rp = window->RPort;
 218:	|  |  |  |  |  |              |  |  |  |  |  |   movea.l 50(a4),a2
		SetAPen(rp, 0);  // White pen (background color)
 21c:	|  |  |  |  |  |              |  |  |  |  |  |   movea.l 26dc <GfxBase>,a6
 222:	|  |  |  |  |  |              |  |  |  |  |  |   movea.l a2,a1
	if (isGreenBackground) {
 224:	|  |  |  |  |  |              |  |  |  |  |  |   tst.w 26da <isGreenBackground>
 22a:	|  |  |  |  |  |     ,--------|--|--|--|--|--|-- beq.w 48a <main+0x3fe>
		SetAPen(rp, 0);  // White pen (background color)
 22e:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #0,d0
 230:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -342(a6)
		isGreenBackground = FALSE;
 234:	|  |  |  |  |  |     |        |  |  |  |  |  |   clr.w d0
 236:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.w d0,26da <isGreenBackground>
	RectFill(rp, window->BorderLeft, window->BorderTop, 
 23c:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.b 54(a4),d0
 240:	|  |  |  |  |  |     |        |  |  |  |  |  |   ext.w d0
 242:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.b 55(a4),d1
 246:	|  |  |  |  |  |     |        |  |  |  |  |  |   ext.w d1
 248:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.w 8(a4),a0
 24c:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.b 56(a4),d3
 250:	|  |  |  |  |  |     |        |  |  |  |  |  |   ext.w d3
 252:	|  |  |  |  |  |     |        |  |  |  |  |  |   suba.w d3,a0
 254:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.l a0,d2
 256:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.w 10(a4),a1
 25a:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.b 57(a4),d3
 25e:	|  |  |  |  |  |     |        |  |  |  |  |  |   ext.w d3
 260:	|  |  |  |  |  |     |        |  |  |  |  |  |   suba.w d3,a1
 262:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.l a1,d3
 264:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 26dc <GfxBase>,a6
 26a:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a2,a1
 26c:	|  |  |  |  |  |     |        |  |  |  |  |  |   ext.l d0
 26e:	|  |  |  |  |  |     |        |  |  |  |  |  |   ext.l d1
 270:	|  |  |  |  |  |     |        |  |  |  |  |  |   subq.l #1,d2
 272:	|  |  |  |  |  |     |        |  |  |  |  |  |   subq.l #1,d3
 274:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -306(a6)
	struct RastPort *rp = window->RPort;
 278:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 50(a4),a2
	SetAPen(rp, 3);
 27c:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 26dc <GfxBase>,a6
 282:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a2,a1
 284:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #3,d0
 286:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 28a:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 26dc <GfxBase>,a6
 290:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a2,a1
 292:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #101,d0
 294:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #61,d1
 296:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.l d5,d2
 298:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #89,d3
 29a:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -306(a6)
	SetAPen(rp, 1);
 29e:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 26dc <GfxBase>,a6
 2a4:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a2,a1
 2a6:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #1,d0
 2a8:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 2ac:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 26e0 <IntuitionBase>,a6
 2b2:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l d6,a0
 2b4:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a4,a1
 2b6:	|  |  |  |  |  |     |        |  |  |  |  |  |   suba.l a2,a2
 2b8:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -222(a6)
						SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX - Green Background", (UBYTE *)-1);
 2bc:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 26e0 <IntuitionBase>,a6
 2c2:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a4,a0
					if (isGreenBackground) {
 2c4:	|  |  |  |  |  |     |        |  |  |  |  |  |   tst.w 26da <isGreenBackground>
 2ca:	|  |  |  |  |  |  ,--|--------|--|--|--|--|--|-- beq.w 52a <main+0x49e>
						SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX - Green Background", (UBYTE *)-1);
 2ce:	|  |  |  |  |  |  |  |     ,--|--|--|--|--|--|-> lea 627 <main+0x59b>,a1
 2d4:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.w #-1,a2
 2d8:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   jsr -276(a6)
			ReplyMsg((struct Message *)message);
 2dc:	|  |  |  |  |  |  |  |     |  |  |  |  |  >--|-> movea.l 26e8 <SysBase>,a6
 2e2:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.l a3,a1
 2e4:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 2e8:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.l 26e8 <SysBase>,a6
 2ee:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.l 86(a4),a0
 2f2:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   jsr -372(a6)
 2f6:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.l d0,a3
 2f8:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   tst.l d0
 2fa:	|  |  |  |  |  +--|--|-----|--|--|--|--|--|--|-- bne.w 1f6 <main+0x16a>
	while (!done) {
 2fe:	|  |  |  |  |  |  |  |  ,--|--|--|--|--|--|--|-> tst.w d4
 300:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  '-- beq.w 1c6 <main+0x13a>
	CloseWindow(window);
 304:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |      movea.l 26e0 <IntuitionBase>,a6
 30a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |      movea.l a4,a0
 30c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |      jsr -72(a6)
	// 	Write(Output(), (APTR)"This program was started from CLI/Shell.\n", 41);
	// 	Write(Output(), (APTR)"Try running it from Workbench for GUI mode.\n", 45);
	// }

	// Clean up libraries
	CloseLibrary((struct Library*)GfxBase);
 310:	|  |  |  |  |  |  |  |  |  |  '--|--|--|--|----> movea.l 26e8 <SysBase>,a6
 316:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 26dc <GfxBase>,a1
 31c:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      jsr -414(a6)
	CloseLibrary((struct Library*)IntuitionBase);
 320:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 26e8 <SysBase>,a6
 326:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 26e0 <IntuitionBase>,a1
 32c:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      jsr -414(a6)
	CloseLibrary((struct Library*)DOSBase);
 330:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 26e8 <SysBase>,a6
 336:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 26e4 <DOSBase>,a1
 33c:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      jsr -414(a6)
	
	return 0;
}
 340:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      moveq #0,d0
 342:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movem.l (sp)+,d2-d7/a2-a6
 346:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      lea 48(sp),sp
 34a:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      rts
			switch (message->Class) {
 34c:	|  |  |  |  |  |  |  |  |  |     |  |  '--|----> cmpi.l #2097152,d0
 352:	|  |  |  |  |  |  |  |  |  |     |  |     '----- bne.s 2dc <main+0x250>
					if (message->Code == 27) {  // ESC key
 354:	|  |  |  |  |  |  |  |  |  |     |  |            cmpi.w #27,24(a3)
 35a:	|  |  |  |  |  |  |  |  |  |     |  |            seq d0
 35c:	|  |  |  |  |  |  |  |  |  |     |  |            ext.w d0
 35e:	|  |  |  |  |  |  |  |  |  |     |  |            neg.w d0
 360:	|  |  |  |  |  |  |  |  |  |     |  |            or.w d0,d4
			ReplyMsg((struct Message *)message);
 362:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l 26e8 <SysBase>,a6
 368:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l a3,a1
 36a:	|  |  |  |  |  |  |  |  |  |     |  |            jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 36e:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l 26e8 <SysBase>,a6
 374:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l 86(a4),a0
 378:	|  |  |  |  |  |  |  |  |  |     |  |            jsr -372(a6)
 37c:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l d0,a3
 37e:	|  |  |  |  |  |  |  |  |  |     |  |            tst.l d0
 380:	|  |  |  |  |  +--|--|--|--|-----|--|----------- bne.w 1f6 <main+0x16a>
 384:	|  |  |  |  |  |  |  |  +--|-----|--|----------- bra.w 2fe <main+0x272>
			switch (message->Class) {
 388:	|  |  |  |  |  |  |  |  |  |     |  '----------> moveq #1,d4
			ReplyMsg((struct Message *)message);
 38a:	|  |  |  |  |  |  |  |  |  |     |               movea.l 26e8 <SysBase>,a6
 390:	|  |  |  |  |  |  |  |  |  |     |               movea.l a3,a1
 392:	|  |  |  |  |  |  |  |  |  |     |               jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 396:	|  |  |  |  |  |  |  |  |  |     |               movea.l 26e8 <SysBase>,a6
 39c:	|  |  |  |  |  |  |  |  |  |     |               movea.l 86(a4),a0
 3a0:	|  |  |  |  |  |  |  |  |  |     |               jsr -372(a6)
 3a4:	|  |  |  |  |  |  |  |  |  |     |               movea.l d0,a3
 3a6:	|  |  |  |  |  |  |  |  |  |     |               tst.l d0
 3a8:	|  |  |  |  |  +--|--|--|--|-----|-------------- bne.w 1f6 <main+0x16a>
 3ac:	|  |  |  |  |  |  |  |  +--|-----|-------------- bra.w 2fe <main+0x272>
					BeginRefresh(window);
 3b0:	|  |  |  |  |  |  |  |  |  |     '-------------> movea.l 26e0 <IntuitionBase>,a6
 3b6:	|  |  |  |  |  |  |  |  |  |                     movea.l a4,a0
 3b8:	|  |  |  |  |  |  |  |  |  |                     jsr -354(a6)
					if (isGreenBackground) {
 3bc:	|  |  |  |  |  |  |  |  |  |                     tst.w 26da <isGreenBackground>
 3c2:	|  |  |  |  |  |  |  |  |  |                 ,-- beq.s 412 <main+0x386>
						struct RastPort *rp = window->RPort;
 3c4:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 50(a4),a2
						SetAPen(rp, 2);  // Green pen
 3c8:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 26dc <GfxBase>,a6
 3ce:	|  |  |  |  |  |  |  |  |  |                 |   movea.l a2,a1
 3d0:	|  |  |  |  |  |  |  |  |  |                 |   moveq #2,d0
 3d2:	|  |  |  |  |  |  |  |  |  |                 |   jsr -342(a6)
						RectFill(rp, window->BorderLeft, window->BorderTop, 
 3d6:	|  |  |  |  |  |  |  |  |  |                 |   move.b 54(a4),d0
 3da:	|  |  |  |  |  |  |  |  |  |                 |   ext.w d0
 3dc:	|  |  |  |  |  |  |  |  |  |                 |   move.b 55(a4),d1
 3e0:	|  |  |  |  |  |  |  |  |  |                 |   ext.w d1
 3e2:	|  |  |  |  |  |  |  |  |  |                 |   movea.w 8(a4),a0
 3e6:	|  |  |  |  |  |  |  |  |  |                 |   move.b 56(a4),d3
 3ea:	|  |  |  |  |  |  |  |  |  |                 |   ext.w d3
 3ec:	|  |  |  |  |  |  |  |  |  |                 |   suba.w d3,a0
 3ee:	|  |  |  |  |  |  |  |  |  |                 |   move.l a0,d2
 3f0:	|  |  |  |  |  |  |  |  |  |                 |   movea.w 10(a4),a1
 3f4:	|  |  |  |  |  |  |  |  |  |                 |   move.b 57(a4),d3
 3f8:	|  |  |  |  |  |  |  |  |  |                 |   ext.w d3
 3fa:	|  |  |  |  |  |  |  |  |  |                 |   suba.w d3,a1
 3fc:	|  |  |  |  |  |  |  |  |  |                 |   move.l a1,d3
 3fe:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 26dc <GfxBase>,a6
 404:	|  |  |  |  |  |  |  |  |  |                 |   movea.l a2,a1
 406:	|  |  |  |  |  |  |  |  |  |                 |   ext.l d0
 408:	|  |  |  |  |  |  |  |  |  |                 |   ext.l d1
 40a:	|  |  |  |  |  |  |  |  |  |                 |   subq.l #1,d2
 40c:	|  |  |  |  |  |  |  |  |  |                 |   subq.l #1,d3
 40e:	|  |  |  |  |  |  |  |  |  |                 |   jsr -306(a6)
	struct RastPort *rp = window->RPort;
 412:	|  |  |  |  |  |  |  |  |  |                 '-> movea.l 50(a4),a2
	SetAPen(rp, 3);
 416:	|  |  |  |  |  |  |  |  |  |                     movea.l 26dc <GfxBase>,a6
 41c:	|  |  |  |  |  |  |  |  |  |                     movea.l a2,a1
 41e:	|  |  |  |  |  |  |  |  |  |                     moveq #3,d0
 420:	|  |  |  |  |  |  |  |  |  |                     jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 424:	|  |  |  |  |  |  |  |  |  |                     movea.l 26dc <GfxBase>,a6
 42a:	|  |  |  |  |  |  |  |  |  |                     movea.l a2,a1
 42c:	|  |  |  |  |  |  |  |  |  |                     moveq #101,d0
 42e:	|  |  |  |  |  |  |  |  |  |                     moveq #61,d1
 430:	|  |  |  |  |  |  |  |  |  |                     move.l d5,d2
 432:	|  |  |  |  |  |  |  |  |  |                     moveq #89,d3
 434:	|  |  |  |  |  |  |  |  |  |                     jsr -306(a6)
	SetAPen(rp, 1);
 438:	|  |  |  |  |  |  |  |  |  |                     movea.l 26dc <GfxBase>,a6
 43e:	|  |  |  |  |  |  |  |  |  |                     movea.l a2,a1
 440:	|  |  |  |  |  |  |  |  |  |                     moveq #1,d0
 442:	|  |  |  |  |  |  |  |  |  |                     jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 446:	|  |  |  |  |  |  |  |  |  |                     movea.l 26e0 <IntuitionBase>,a6
 44c:	|  |  |  |  |  |  |  |  |  |                     movea.l d6,a0
 44e:	|  |  |  |  |  |  |  |  |  |                     movea.l a4,a1
 450:	|  |  |  |  |  |  |  |  |  |                     suba.l a2,a2
 452:	|  |  |  |  |  |  |  |  |  |                     jsr -222(a6)
					EndRefresh(window, TRUE);
 456:	|  |  |  |  |  |  |  |  |  |                     movea.l 26e0 <IntuitionBase>,a6
 45c:	|  |  |  |  |  |  |  |  |  |                     movea.l a4,a0
 45e:	|  |  |  |  |  |  |  |  |  |                     moveq #1,d0
 460:	|  |  |  |  |  |  |  |  |  |                     jsr -366(a6)
			ReplyMsg((struct Message *)message);
 464:	|  |  |  |  |  |  |  |  |  |                     movea.l 26e8 <SysBase>,a6
 46a:	|  |  |  |  |  |  |  |  |  |                     movea.l a3,a1
 46c:	|  |  |  |  |  |  |  |  |  |                     jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 470:	|  |  |  |  |  |  |  |  |  |                     movea.l 26e8 <SysBase>,a6
 476:	|  |  |  |  |  |  |  |  |  |                     movea.l 86(a4),a0
 47a:	|  |  |  |  |  |  |  |  |  |                     jsr -372(a6)
 47e:	|  |  |  |  |  |  |  |  |  |                     movea.l d0,a3
 480:	|  |  |  |  |  |  |  |  |  |                     tst.l d0
 482:	|  |  |  |  |  +--|--|--|--|-------------------- bne.w 1f6 <main+0x16a>
 486:	|  |  |  |  |  |  |  |  +--|-------------------- bra.w 2fe <main+0x272>
		SetAPen(rp, 2);  // Green pen in default Workbench palette
 48a:	|  |  |  |  |  |  |  '--|--|-------------------> moveq #2,d0
 48c:	|  |  |  |  |  |  |     |  |                     jsr -342(a6)
 490:	|  |  |  |  |  |  |     |  |                     moveq #1,d0
		isGreenBackground = FALSE;
 492:	|  |  |  |  |  |  |     |  |                     move.w d0,26da <isGreenBackground>
	RectFill(rp, window->BorderLeft, window->BorderTop, 
 498:	|  |  |  |  |  |  |     |  |                     move.b 54(a4),d0
 49c:	|  |  |  |  |  |  |     |  |                     ext.w d0
 49e:	|  |  |  |  |  |  |     |  |                     move.b 55(a4),d1
 4a2:	|  |  |  |  |  |  |     |  |                     ext.w d1
 4a4:	|  |  |  |  |  |  |     |  |                     movea.w 8(a4),a0
 4a8:	|  |  |  |  |  |  |     |  |                     move.b 56(a4),d3
 4ac:	|  |  |  |  |  |  |     |  |                     ext.w d3
 4ae:	|  |  |  |  |  |  |     |  |                     suba.w d3,a0
 4b0:	|  |  |  |  |  |  |     |  |                     move.l a0,d2
 4b2:	|  |  |  |  |  |  |     |  |                     movea.w 10(a4),a1
 4b6:	|  |  |  |  |  |  |     |  |                     move.b 57(a4),d3
 4ba:	|  |  |  |  |  |  |     |  |                     ext.w d3
 4bc:	|  |  |  |  |  |  |     |  |                     suba.w d3,a1
 4be:	|  |  |  |  |  |  |     |  |                     move.l a1,d3
 4c0:	|  |  |  |  |  |  |     |  |                     movea.l 26dc <GfxBase>,a6
 4c6:	|  |  |  |  |  |  |     |  |                     movea.l a2,a1
 4c8:	|  |  |  |  |  |  |     |  |                     ext.l d0
 4ca:	|  |  |  |  |  |  |     |  |                     ext.l d1
 4cc:	|  |  |  |  |  |  |     |  |                     subq.l #1,d2
 4ce:	|  |  |  |  |  |  |     |  |                     subq.l #1,d3
 4d0:	|  |  |  |  |  |  |     |  |                     jsr -306(a6)
	struct RastPort *rp = window->RPort;
 4d4:	|  |  |  |  |  |  |     |  |                     movea.l 50(a4),a2
	SetAPen(rp, 3);
 4d8:	|  |  |  |  |  |  |     |  |                     movea.l 26dc <GfxBase>,a6
 4de:	|  |  |  |  |  |  |     |  |                     movea.l a2,a1
 4e0:	|  |  |  |  |  |  |     |  |                     moveq #3,d0
 4e2:	|  |  |  |  |  |  |     |  |                     jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 4e6:	|  |  |  |  |  |  |     |  |                     movea.l 26dc <GfxBase>,a6
 4ec:	|  |  |  |  |  |  |     |  |                     movea.l a2,a1
 4ee:	|  |  |  |  |  |  |     |  |                     moveq #101,d0
 4f0:	|  |  |  |  |  |  |     |  |                     moveq #61,d1
 4f2:	|  |  |  |  |  |  |     |  |                     move.l d5,d2
 4f4:	|  |  |  |  |  |  |     |  |                     moveq #89,d3
 4f6:	|  |  |  |  |  |  |     |  |                     jsr -306(a6)
	SetAPen(rp, 1);
 4fa:	|  |  |  |  |  |  |     |  |                     movea.l 26dc <GfxBase>,a6
 500:	|  |  |  |  |  |  |     |  |                     movea.l a2,a1
 502:	|  |  |  |  |  |  |     |  |                     moveq #1,d0
 504:	|  |  |  |  |  |  |     |  |                     jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 508:	|  |  |  |  |  |  |     |  |                     movea.l 26e0 <IntuitionBase>,a6
 50e:	|  |  |  |  |  |  |     |  |                     movea.l d6,a0
 510:	|  |  |  |  |  |  |     |  |                     movea.l a4,a1
 512:	|  |  |  |  |  |  |     |  |                     suba.l a2,a2
 514:	|  |  |  |  |  |  |     |  |                     jsr -222(a6)
						SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX - Green Background", (UBYTE *)-1);
 518:	|  |  |  |  |  |  |     |  |                     movea.l 26e0 <IntuitionBase>,a6
 51e:	|  |  |  |  |  |  |     |  |                     movea.l a4,a0
					if (isGreenBackground) {
 520:	|  |  |  |  |  |  |     |  |                     tst.w 26da <isGreenBackground>
 526:	|  |  |  |  |  |  |     |  '-------------------- bne.w 2ce <main+0x242>
						SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX - White Background", (UBYTE *)-1);
 52a:	|  |  |  |  |  |  '-----|----------------------> movea.l a5,a1
 52c:	|  |  |  |  |  |        |                        movea.w #-1,a2
 530:	|  |  |  |  |  |        |                        jsr -276(a6)
			ReplyMsg((struct Message *)message);
 534:	|  |  |  |  |  |        |                        movea.l 26e8 <SysBase>,a6
 53a:	|  |  |  |  |  |        |                        movea.l a3,a1
 53c:	|  |  |  |  |  |        |                        jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 540:	|  |  |  |  |  |        |                        movea.l 26e8 <SysBase>,a6
 546:	|  |  |  |  |  |        |                        movea.l 86(a4),a0
 54a:	|  |  |  |  |  |        |                        jsr -372(a6)
 54e:	|  |  |  |  |  |        |                        movea.l d0,a3
 550:	|  |  |  |  |  |        |                        tst.l d0
 552:	|  |  |  |  |  '--------|----------------------- bne.w 1f6 <main+0x16a>
 556:	|  |  |  |  |           '----------------------- bra.w 2fe <main+0x272>
		CloseLibrary((struct Library*)IntuitionBase);
 55a:	|  |  |  >--|----------------------------------> movea.l 26e8 <SysBase>,a6
 560:	|  |  |  |  |                                    movea.l 26e0 <IntuitionBase>,a1
 566:	|  |  |  |  |                                    jsr -414(a6)
		CloseLibrary((struct Library*)DOSBase);
 56a:	|  |  |  |  |                                    movea.l 26e8 <SysBase>,a6
 570:	|  |  |  |  |                                    movea.l 26e4 <DOSBase>,a1
 576:	|  |  |  |  |                                    jsr -414(a6)
		Exit(0);
 57a:	|  |  |  |  |                                    movea.l 26e4 <DOSBase>,a6
 580:	|  |  |  |  |                                    moveq #0,d1
 582:	|  |  |  |  |                                    jsr -144(a6)
 586:	|  |  |  |  +----------------------------------- bra.w ec <main+0x60>
		CloseLibrary((struct Library*)DOSBase);
 58a:	>--|--|--|--|----------------------------------> movea.l 26e8 <SysBase>,a6
 590:	|  |  |  |  |                                    movea.l 26e4 <DOSBase>,a1
 596:	|  |  |  |  |                                    jsr -414(a6)
		Exit(0);
 59a:	|  |  |  |  |                                    movea.l 26e4 <DOSBase>,a6
 5a0:	|  |  |  |  |                                    moveq #0,d1
 5a2:	|  |  |  |  |                                    jsr -144(a6)
	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
 5a6:	|  |  |  |  |                                    movea.l 26e8 <SysBase>,a6
 5ac:	|  |  |  |  |                                    lea 608 <main+0x57c>,a1
 5b2:	|  |  |  |  |                                    moveq #0,d0
 5b4:	|  |  |  |  |                                    jsr -552(a6)
 5b8:	|  |  |  |  |                                    move.l d0,26dc <GfxBase>
	if (!GfxBase) {
 5be:	|  |  |  |  '----------------------------------- bne.w ec <main+0x60>
 5c2:	|  |  |  '-------------------------------------- bra.s 55a <main+0x4ce>
		Exit(0);
 5c4:	|  |  '----------------------------------------> suba.l a6,a6
 5c6:	|  |                                             moveq #0,d1
 5c8:	|  |                                             jsr -144(a6)
	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
 5cc:	|  |                                             movea.l 26e8 <SysBase>,a6
 5d2:	|  |                                             lea 5f6 <main+0x56a>,a1
 5d8:	|  |                                             moveq #0,d0
 5da:	|  |                                             jsr -552(a6)
 5de:	|  |                                             move.l d0,26e0 <IntuitionBase>
	if (!IntuitionBase) {
 5e4:	|  '-------------------------------------------- bne.w d0 <main+0x44>
 5e8:	'----------------------------------------------- bra.s 58a <main+0x4fe>
