
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
   4:	       move.l #9968,d3
   a:	       subi.l #9968,d3
  10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	       move.l #9968,d0
  18:	       cmpi.l #9968,d0
  1e:	,----- beq.s 32 <_start+0x32>
  20:	|      lea 26f0 <buttonBorderData>,a2
  26:	|      moveq #0,d2
		__preinit_array_start[i]();
  28:	|  ,-> movea.l (a2)+,a0
  2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  2c:	|  |   addq.l #1,d2
  2e:	|  |   cmp.l d3,d2
  30:	|  '-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
  32:	'----> move.l #9968,d3
  38:	       subi.l #9968,d3
  3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  40:	       move.l #9968,d0
  46:	       cmpi.l #9968,d0
  4c:	,----- beq.s 60 <_start+0x60>
  4e:	|      lea 26f0 <buttonBorderData>,a2
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
  66:	       move.l #9968,d2
  6c:	       subi.l #9968,d2
  72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  74:	,----- beq.s 86 <_start+0x86>
  76:	|      lea 26f0 <buttonBorderData>,a2
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
  98:	                                                 move.l a6,2762 <SysBase>

	// Open required libraries
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  9e:	                                                 lea 684 <main+0x5f8>,a1
  a4:	                                                 moveq #0,d0
  a6:	                                                 jsr -552(a6)
  aa:	                                                 move.l d0,275e <DOSBase>
	if (!DOSBase)
  b0:	      ,----------------------------------------- beq.w 65e <main+0x5d2>
		Exit(0);

	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
  b4:	      |                                          movea.l 2762 <SysBase>,a6
  ba:	      |                                          lea 690 <main+0x604>,a1
  c0:	      |                                          moveq #0,d0
  c2:	      |                                          jsr -552(a6)
  c6:	      |                                          move.l d0,275a <IntuitionBase>
	if (!IntuitionBase) {
  cc:	,-----|----------------------------------------- beq.w 624 <main+0x598>
		CloseLibrary((struct Library*)DOSBase);
		Exit(0);
	}

	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
  d0:	|  ,--|----------------------------------------> movea.l 2762 <SysBase>,a6
  d6:	|  |  |                                          lea 6a2 <main+0x616>,a1
  dc:	|  |  |                                          moveq #0,d0
  de:	|  |  |                                          jsr -552(a6)
  e2:	|  |  |                                          move.l d0,2756 <GfxBase>
	if (!GfxBase) {
  e8:	|  |  |  ,-------------------------------------- beq.w 5f4 <main+0x568>
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
 11a:	|  |  |  |  |                                    move.l #10024,62(sp)
	nw.CheckMark = NULL;
 122:	|  |  |  |  |                                    clr.l 66(sp)
	nw.Title = (UBYTE *)"BG Program";
 126:	|  |  |  |  |                                    move.l #1715,70(sp)
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
 154:	|  |  |  |  |                                    movea.l 275a <IntuitionBase>,a6
 15a:	|  |  |  |  |                                    lea 44(sp),a0
 15e:	|  |  |  |  |                                    jsr -204(a6)
 162:	|  |  |  |  |                                    movea.l d0,a4
	if (!window) {
 164:	|  |  |  |  |                                    tst.l d0
 166:	|  |  |  |  |                 ,----------------- beq.w 310 <main+0x284>
	struct RastPort *rp = window->RPort;
 16a:	|  |  |  |  |                 |                  move.l 50(a4),d4
	SetAPen(rp, 3);
 16e:	|  |  |  |  |                 |                  movea.l 2756 <GfxBase>,a6
 174:	|  |  |  |  |                 |                  movea.l d4,a1
 176:	|  |  |  |  |                 |                  moveq #3,d0
 178:	|  |  |  |  |                 |                  jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 17c:	|  |  |  |  |                 |                  movea.l 2756 <GfxBase>,a6
 182:	|  |  |  |  |                 |                  movea.l d4,a1
 184:	|  |  |  |  |                 |                  moveq #101,d0
 186:	|  |  |  |  |                 |                  moveq #61,d1
 188:	|  |  |  |  |                 |                  move.l #298,d2
 18e:	|  |  |  |  |                 |                  moveq #89,d3
 190:	|  |  |  |  |                 |                  jsr -306(a6)
	SetAPen(rp, 1);
 194:	|  |  |  |  |                 |                  movea.l 2756 <GfxBase>,a6
 19a:	|  |  |  |  |                 |                  movea.l d4,a1
 19c:	|  |  |  |  |                 |                  moveq #1,d0
 19e:	|  |  |  |  |                 |                  jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 1a2:	|  |  |  |  |                 |                  movea.l 275a <IntuitionBase>,a6
 1a8:	|  |  |  |  |                 |                  lea 2728 <colorButton>,a0
 1ae:	|  |  |  |  |                 |                  movea.l a4,a1
 1b0:	|  |  |  |  |                 |                  suba.l a2,a2
 1b2:	|  |  |  |  |                 |                  jsr -222(a6)
		Wait(1L << window->UserPort->mp_SigBit);
 1b6:	|  |  |  |  |                 |                  moveq #1,d7
	RectFill(rp, 101, 61, 298, 89);
 1b8:	|  |  |  |  |                 |                  move.l d2,d5
	RefreshGadgets(&colorButton, window, NULL);
 1ba:	|  |  |  |  |                 |                  move.l #10024,d6
						SetWindowTitles(window, (UBYTE *)"BG Program - White", (UBYTE *)-1);
 1c0:	|  |  |  |  |                 |                  lea 6d0 <main+0x644>,a5
		Wait(1L << window->UserPort->mp_SigBit);
 1c6:	|  |  |  |  |                 |              ,-> movea.l 86(a4),a0
 1ca:	|  |  |  |  |                 |              |   moveq #0,d0
 1cc:	|  |  |  |  |                 |              |   move.b 15(a0),d0
 1d0:	|  |  |  |  |                 |              |   movea.l 2762 <SysBase>,a6
 1d6:	|  |  |  |  |                 |              |   move.l d7,d1
 1d8:	|  |  |  |  |                 |              |   lsl.l d0,d1
 1da:	|  |  |  |  |                 |              |   move.l d1,d0
 1dc:	|  |  |  |  |                 |              |   jsr -318(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 1e0:	|  |  |  |  |                 |              |   movea.l 2762 <SysBase>,a6
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
		SetAPen(rp, 1);  // Blue pen (typically dark blue in Workbench)
 21c:	|  |  |  |  |  |              |  |  |  |  |  |   movea.l 2756 <GfxBase>,a6
 222:	|  |  |  |  |  |              |  |  |  |  |  |   movea.l a2,a1
	if (isGreenBackground) {
 224:	|  |  |  |  |  |              |  |  |  |  |  |   tst.w 2754 <isGreenBackground>
 22a:	|  |  |  |  |  |     ,--------|--|--|--|--|--|-- beq.w 524 <main+0x498>
		SetAPen(rp, 1);  // Blue pen (typically dark blue in Workbench)
 22e:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #1,d0
 230:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -342(a6)
		isGreenBackground = FALSE;
 234:	|  |  |  |  |  |     |        |  |  |  |  |  |   clr.w d0
 236:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.w d0,2754 <isGreenBackground>
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
 264:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 2756 <GfxBase>,a6
 26a:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a2,a1
 26c:	|  |  |  |  |  |     |        |  |  |  |  |  |   ext.l d0
 26e:	|  |  |  |  |  |     |        |  |  |  |  |  |   ext.l d1
 270:	|  |  |  |  |  |     |        |  |  |  |  |  |   subq.l #1,d2
 272:	|  |  |  |  |  |     |        |  |  |  |  |  |   subq.l #1,d3
 274:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -306(a6)
	struct RastPort *rp = window->RPort;
 278:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 50(a4),a2
	SetAPen(rp, 3);
 27c:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 2756 <GfxBase>,a6
 282:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a2,a1
 284:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #3,d0
 286:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 28a:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 2756 <GfxBase>,a6
 290:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a2,a1
 292:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #101,d0
 294:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #61,d1
 296:	|  |  |  |  |  |     |        |  |  |  |  |  |   move.l d5,d2
 298:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #89,d3
 29a:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -306(a6)
	SetAPen(rp, 1);
 29e:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 2756 <GfxBase>,a6
 2a4:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a2,a1
 2a6:	|  |  |  |  |  |     |        |  |  |  |  |  |   moveq #1,d0
 2a8:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 2ac:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 275a <IntuitionBase>,a6
 2b2:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l d6,a0
 2b4:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a4,a1
 2b6:	|  |  |  |  |  |     |        |  |  |  |  |  |   suba.l a2,a2
 2b8:	|  |  |  |  |  |     |        |  |  |  |  |  |   jsr -222(a6)
						SetWindowTitles(window, (UBYTE *)"BG Program - Dark", (UBYTE *)-1);
 2bc:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l 275a <IntuitionBase>,a6
 2c2:	|  |  |  |  |  |     |        |  |  |  |  |  |   movea.l a4,a0
					if (isGreenBackground) {
 2c4:	|  |  |  |  |  |     |        |  |  |  |  |  |   tst.w 2754 <isGreenBackground>
 2ca:	|  |  |  |  |  |  ,--|--------|--|--|--|--|--|-- beq.w 5c4 <main+0x538>
						SetWindowTitles(window, (UBYTE *)"BG Program - Dark", (UBYTE *)-1);
 2ce:	|  |  |  |  |  |  |  |     ,--|--|--|--|--|--|-> lea 6be <main+0x632>,a1
 2d4:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.w #-1,a2
 2d8:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   jsr -276(a6)
			ReplyMsg((struct Message *)message);
 2dc:	|  |  |  |  |  |  |  |     |  |  |  |  |  >--|-> movea.l 2762 <SysBase>,a6
 2e2:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.l a3,a1
 2e4:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 2e8:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.l 2762 <SysBase>,a6
 2ee:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.l 86(a4),a0
 2f2:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   jsr -372(a6)
 2f6:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   movea.l d0,a3
 2f8:	|  |  |  |  |  |  |  |     |  |  |  |  |  |  |   tst.l d0
 2fa:	|  |  |  |  |  +--|--|-----|--|--|--|--|--|--|-- bne.w 1f6 <main+0x16a>
	while (!done) {
 2fe:	|  |  |  |  |  |  |  |  ,--|--|--|--|--|--|--|-> tst.w d4
 300:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  '-- beq.w 1c6 <main+0x13a>
	CloseWindow(window);
 304:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |      movea.l 275a <IntuitionBase>,a6
 30a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |      movea.l a4,a0
 30c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |      jsr -72(a6)
	// 	Write(Output(), (APTR)"This program was started from CLI/Shell.\n", 41);
	// 	Write(Output(), (APTR)"Try running it from Workbench for GUI mode.\n", 45);
	// }

	// Clean up libraries
	CloseLibrary((struct Library*)GfxBase);
 310:	|  |  |  |  |  |  |  |  |  |  '--|--|--|--|----> movea.l 2762 <SysBase>,a6
 316:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 2756 <GfxBase>,a1
 31c:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      jsr -414(a6)
	CloseLibrary((struct Library*)IntuitionBase);
 320:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 2762 <SysBase>,a6
 326:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 275a <IntuitionBase>,a1
 32c:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      jsr -414(a6)
	CloseLibrary((struct Library*)DOSBase);
 330:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 2762 <SysBase>,a6
 336:	|  |  |  |  |  |  |  |  |  |     |  |  |  |      movea.l 275e <DOSBase>,a1
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
 362:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l 2762 <SysBase>,a6
 368:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l a3,a1
 36a:	|  |  |  |  |  |  |  |  |  |     |  |            jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 36e:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l 2762 <SysBase>,a6
 374:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l 86(a4),a0
 378:	|  |  |  |  |  |  |  |  |  |     |  |            jsr -372(a6)
 37c:	|  |  |  |  |  |  |  |  |  |     |  |            movea.l d0,a3
 37e:	|  |  |  |  |  |  |  |  |  |     |  |            tst.l d0
 380:	|  |  |  |  |  +--|--|--|--|-----|--|----------- bne.w 1f6 <main+0x16a>
 384:	|  |  |  |  |  |  |  |  +--|-----|--|----------- bra.w 2fe <main+0x272>
			switch (message->Class) {
 388:	|  |  |  |  |  |  |  |  |  |     |  '----------> moveq #1,d4
			ReplyMsg((struct Message *)message);
 38a:	|  |  |  |  |  |  |  |  |  |     |               movea.l 2762 <SysBase>,a6
 390:	|  |  |  |  |  |  |  |  |  |     |               movea.l a3,a1
 392:	|  |  |  |  |  |  |  |  |  |     |               jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 396:	|  |  |  |  |  |  |  |  |  |     |               movea.l 2762 <SysBase>,a6
 39c:	|  |  |  |  |  |  |  |  |  |     |               movea.l 86(a4),a0
 3a0:	|  |  |  |  |  |  |  |  |  |     |               jsr -372(a6)
 3a4:	|  |  |  |  |  |  |  |  |  |     |               movea.l d0,a3
 3a6:	|  |  |  |  |  |  |  |  |  |     |               tst.l d0
 3a8:	|  |  |  |  |  +--|--|--|--|-----|-------------- bne.w 1f6 <main+0x16a>
 3ac:	|  |  |  |  |  |  |  |  +--|-----|-------------- bra.w 2fe <main+0x272>
					BeginRefresh(window);
 3b0:	|  |  |  |  |  |  |  |  |  |     '-------------> movea.l 275a <IntuitionBase>,a6
 3b6:	|  |  |  |  |  |  |  |  |  |                     movea.l a4,a0
 3b8:	|  |  |  |  |  |  |  |  |  |                     jsr -354(a6)
						struct RastPort *rp = window->RPort;
 3bc:	|  |  |  |  |  |  |  |  |  |                     movea.l 50(a4),a2
						SetAPen(rp, 2);  // Green pen (pen 2 as-is)
 3c0:	|  |  |  |  |  |  |  |  |  |                     movea.l 2756 <GfxBase>,a6
 3c6:	|  |  |  |  |  |  |  |  |  |                     movea.l a2,a1
					if (isGreenBackground) {
 3c8:	|  |  |  |  |  |  |  |  |  |                     tst.w 2754 <isGreenBackground>
 3ce:	|  |  |  |  |  |  |  |  |  |              ,----- beq.w 48c <main+0x400>
						SetAPen(rp, 2);  // Green pen (pen 2 as-is)
 3d2:	|  |  |  |  |  |  |  |  |  |              |      moveq #2,d0
						SetAPen(rp, 1);  // Blue pen
 3d4:	|  |  |  |  |  |  |  |  |  |              |      jsr -342(a6)
						RectFill(rp, window->BorderLeft, window->BorderTop, 
 3d8:	|  |  |  |  |  |  |  |  |  |              |      move.b 54(a4),d0
 3dc:	|  |  |  |  |  |  |  |  |  |              |      ext.w d0
 3de:	|  |  |  |  |  |  |  |  |  |              |      move.b 55(a4),d1
 3e2:	|  |  |  |  |  |  |  |  |  |              |      ext.w d1
 3e4:	|  |  |  |  |  |  |  |  |  |              |      movea.w 8(a4),a0
 3e8:	|  |  |  |  |  |  |  |  |  |              |      move.b 56(a4),d3
 3ec:	|  |  |  |  |  |  |  |  |  |              |      ext.w d3
 3ee:	|  |  |  |  |  |  |  |  |  |              |      suba.w d3,a0
 3f0:	|  |  |  |  |  |  |  |  |  |              |      move.l a0,d2
 3f2:	|  |  |  |  |  |  |  |  |  |              |      movea.w 10(a4),a1
 3f6:	|  |  |  |  |  |  |  |  |  |              |      move.b 57(a4),d3
 3fa:	|  |  |  |  |  |  |  |  |  |              |      ext.w d3
 3fc:	|  |  |  |  |  |  |  |  |  |              |      suba.w d3,a1
 3fe:	|  |  |  |  |  |  |  |  |  |              |      move.l a1,d3
 400:	|  |  |  |  |  |  |  |  |  |              |      movea.l 2756 <GfxBase>,a6
 406:	|  |  |  |  |  |  |  |  |  |              |      movea.l a2,a1
 408:	|  |  |  |  |  |  |  |  |  |              |      ext.l d0
 40a:	|  |  |  |  |  |  |  |  |  |              |      ext.l d1
 40c:	|  |  |  |  |  |  |  |  |  |              |      subq.l #1,d2
 40e:	|  |  |  |  |  |  |  |  |  |              |      subq.l #1,d3
 410:	|  |  |  |  |  |  |  |  |  |              |      jsr -306(a6)
	struct RastPort *rp = window->RPort;
 414:	|  |  |  |  |  |  |  |  |  |              |      movea.l 50(a4),a2
	SetAPen(rp, 3);
 418:	|  |  |  |  |  |  |  |  |  |              |      movea.l 2756 <GfxBase>,a6
 41e:	|  |  |  |  |  |  |  |  |  |              |      movea.l a2,a1
 420:	|  |  |  |  |  |  |  |  |  |              |      moveq #3,d0
 422:	|  |  |  |  |  |  |  |  |  |              |      jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 426:	|  |  |  |  |  |  |  |  |  |              |      movea.l 2756 <GfxBase>,a6
 42c:	|  |  |  |  |  |  |  |  |  |              |      movea.l a2,a1
 42e:	|  |  |  |  |  |  |  |  |  |              |      moveq #101,d0
 430:	|  |  |  |  |  |  |  |  |  |              |      moveq #61,d1
 432:	|  |  |  |  |  |  |  |  |  |              |      move.l d5,d2
 434:	|  |  |  |  |  |  |  |  |  |              |      moveq #89,d3
 436:	|  |  |  |  |  |  |  |  |  |              |      jsr -306(a6)
	SetAPen(rp, 1);
 43a:	|  |  |  |  |  |  |  |  |  |              |      movea.l 2756 <GfxBase>,a6
 440:	|  |  |  |  |  |  |  |  |  |              |      movea.l a2,a1
 442:	|  |  |  |  |  |  |  |  |  |              |      moveq #1,d0
 444:	|  |  |  |  |  |  |  |  |  |              |      jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 448:	|  |  |  |  |  |  |  |  |  |              |      movea.l 275a <IntuitionBase>,a6
 44e:	|  |  |  |  |  |  |  |  |  |              |      movea.l d6,a0
 450:	|  |  |  |  |  |  |  |  |  |              |      movea.l a4,a1
 452:	|  |  |  |  |  |  |  |  |  |              |      suba.l a2,a2
 454:	|  |  |  |  |  |  |  |  |  |              |      jsr -222(a6)
					EndRefresh(window, TRUE);
 458:	|  |  |  |  |  |  |  |  |  |              |      movea.l 275a <IntuitionBase>,a6
 45e:	|  |  |  |  |  |  |  |  |  |              |      movea.l a4,a0
 460:	|  |  |  |  |  |  |  |  |  |              |      moveq #1,d0
 462:	|  |  |  |  |  |  |  |  |  |              |      jsr -366(a6)
			ReplyMsg((struct Message *)message);
 466:	|  |  |  |  |  |  |  |  |  |              |  ,-> movea.l 2762 <SysBase>,a6
 46c:	|  |  |  |  |  |  |  |  |  |              |  |   movea.l a3,a1
 46e:	|  |  |  |  |  |  |  |  |  |              |  |   jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 472:	|  |  |  |  |  |  |  |  |  |              |  |   movea.l 2762 <SysBase>,a6
 478:	|  |  |  |  |  |  |  |  |  |              |  |   movea.l 86(a4),a0
 47c:	|  |  |  |  |  |  |  |  |  |              |  |   jsr -372(a6)
 480:	|  |  |  |  |  |  |  |  |  |              |  |   movea.l d0,a3
 482:	|  |  |  |  |  |  |  |  |  |              |  |   tst.l d0
 484:	|  |  |  |  |  +--|--|--|--|--------------|--|-- bne.w 1f6 <main+0x16a>
 488:	|  |  |  |  |  |  |  |  +--|--------------|--|-- bra.w 2fe <main+0x272>
						SetAPen(rp, 1);  // Blue pen
 48c:	|  |  |  |  |  |  |  |  |  |              '--|-> moveq #1,d0
 48e:	|  |  |  |  |  |  |  |  |  |                 |   jsr -342(a6)
						RectFill(rp, window->BorderLeft, window->BorderTop, 
 492:	|  |  |  |  |  |  |  |  |  |                 |   move.b 54(a4),d0
 496:	|  |  |  |  |  |  |  |  |  |                 |   ext.w d0
 498:	|  |  |  |  |  |  |  |  |  |                 |   move.b 55(a4),d1
 49c:	|  |  |  |  |  |  |  |  |  |                 |   ext.w d1
 49e:	|  |  |  |  |  |  |  |  |  |                 |   movea.w 8(a4),a0
 4a2:	|  |  |  |  |  |  |  |  |  |                 |   move.b 56(a4),d3
 4a6:	|  |  |  |  |  |  |  |  |  |                 |   ext.w d3
 4a8:	|  |  |  |  |  |  |  |  |  |                 |   suba.w d3,a0
 4aa:	|  |  |  |  |  |  |  |  |  |                 |   move.l a0,d2
 4ac:	|  |  |  |  |  |  |  |  |  |                 |   movea.w 10(a4),a1
 4b0:	|  |  |  |  |  |  |  |  |  |                 |   move.b 57(a4),d3
 4b4:	|  |  |  |  |  |  |  |  |  |                 |   ext.w d3
 4b6:	|  |  |  |  |  |  |  |  |  |                 |   suba.w d3,a1
 4b8:	|  |  |  |  |  |  |  |  |  |                 |   move.l a1,d3
 4ba:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 2756 <GfxBase>,a6
 4c0:	|  |  |  |  |  |  |  |  |  |                 |   movea.l a2,a1
 4c2:	|  |  |  |  |  |  |  |  |  |                 |   ext.l d0
 4c4:	|  |  |  |  |  |  |  |  |  |                 |   ext.l d1
 4c6:	|  |  |  |  |  |  |  |  |  |                 |   subq.l #1,d2
 4c8:	|  |  |  |  |  |  |  |  |  |                 |   subq.l #1,d3
 4ca:	|  |  |  |  |  |  |  |  |  |                 |   jsr -306(a6)
	struct RastPort *rp = window->RPort;
 4ce:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 50(a4),a2
	SetAPen(rp, 3);
 4d2:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 2756 <GfxBase>,a6
 4d8:	|  |  |  |  |  |  |  |  |  |                 |   movea.l a2,a1
 4da:	|  |  |  |  |  |  |  |  |  |                 |   moveq #3,d0
 4dc:	|  |  |  |  |  |  |  |  |  |                 |   jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 4e0:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 2756 <GfxBase>,a6
 4e6:	|  |  |  |  |  |  |  |  |  |                 |   movea.l a2,a1
 4e8:	|  |  |  |  |  |  |  |  |  |                 |   moveq #101,d0
 4ea:	|  |  |  |  |  |  |  |  |  |                 |   moveq #61,d1
 4ec:	|  |  |  |  |  |  |  |  |  |                 |   move.l d5,d2
 4ee:	|  |  |  |  |  |  |  |  |  |                 |   moveq #89,d3
 4f0:	|  |  |  |  |  |  |  |  |  |                 |   jsr -306(a6)
	SetAPen(rp, 1);
 4f4:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 2756 <GfxBase>,a6
 4fa:	|  |  |  |  |  |  |  |  |  |                 |   movea.l a2,a1
 4fc:	|  |  |  |  |  |  |  |  |  |                 |   moveq #1,d0
 4fe:	|  |  |  |  |  |  |  |  |  |                 |   jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 502:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 275a <IntuitionBase>,a6
 508:	|  |  |  |  |  |  |  |  |  |                 |   movea.l d6,a0
 50a:	|  |  |  |  |  |  |  |  |  |                 |   movea.l a4,a1
 50c:	|  |  |  |  |  |  |  |  |  |                 |   suba.l a2,a2
 50e:	|  |  |  |  |  |  |  |  |  |                 |   jsr -222(a6)
					EndRefresh(window, TRUE);
 512:	|  |  |  |  |  |  |  |  |  |                 |   movea.l 275a <IntuitionBase>,a6
 518:	|  |  |  |  |  |  |  |  |  |                 |   movea.l a4,a0
 51a:	|  |  |  |  |  |  |  |  |  |                 |   moveq #1,d0
 51c:	|  |  |  |  |  |  |  |  |  |                 |   jsr -366(a6)
					break;
 520:	|  |  |  |  |  |  |  |  |  |                 '-- bra.w 466 <main+0x3da>
		SetAPen(rp, 2);  // Use pen 2 as-is from existing palette
 524:	|  |  |  |  |  |  |  '--|--|-------------------> moveq #2,d0
 526:	|  |  |  |  |  |  |     |  |                     jsr -342(a6)
 52a:	|  |  |  |  |  |  |     |  |                     moveq #1,d0
		isGreenBackground = FALSE;
 52c:	|  |  |  |  |  |  |     |  |                     move.w d0,2754 <isGreenBackground>
	RectFill(rp, window->BorderLeft, window->BorderTop, 
 532:	|  |  |  |  |  |  |     |  |                     move.b 54(a4),d0
 536:	|  |  |  |  |  |  |     |  |                     ext.w d0
 538:	|  |  |  |  |  |  |     |  |                     move.b 55(a4),d1
 53c:	|  |  |  |  |  |  |     |  |                     ext.w d1
 53e:	|  |  |  |  |  |  |     |  |                     movea.w 8(a4),a0
 542:	|  |  |  |  |  |  |     |  |                     move.b 56(a4),d3
 546:	|  |  |  |  |  |  |     |  |                     ext.w d3
 548:	|  |  |  |  |  |  |     |  |                     suba.w d3,a0
 54a:	|  |  |  |  |  |  |     |  |                     move.l a0,d2
 54c:	|  |  |  |  |  |  |     |  |                     movea.w 10(a4),a1
 550:	|  |  |  |  |  |  |     |  |                     move.b 57(a4),d3
 554:	|  |  |  |  |  |  |     |  |                     ext.w d3
 556:	|  |  |  |  |  |  |     |  |                     suba.w d3,a1
 558:	|  |  |  |  |  |  |     |  |                     move.l a1,d3
 55a:	|  |  |  |  |  |  |     |  |                     movea.l 2756 <GfxBase>,a6
 560:	|  |  |  |  |  |  |     |  |                     movea.l a2,a1
 562:	|  |  |  |  |  |  |     |  |                     ext.l d0
 564:	|  |  |  |  |  |  |     |  |                     ext.l d1
 566:	|  |  |  |  |  |  |     |  |                     subq.l #1,d2
 568:	|  |  |  |  |  |  |     |  |                     subq.l #1,d3
 56a:	|  |  |  |  |  |  |     |  |                     jsr -306(a6)
	struct RastPort *rp = window->RPort;
 56e:	|  |  |  |  |  |  |     |  |                     movea.l 50(a4),a2
	SetAPen(rp, 3);
 572:	|  |  |  |  |  |  |     |  |                     movea.l 2756 <GfxBase>,a6
 578:	|  |  |  |  |  |  |     |  |                     movea.l a2,a1
 57a:	|  |  |  |  |  |  |     |  |                     moveq #3,d0
 57c:	|  |  |  |  |  |  |     |  |                     jsr -342(a6)
	RectFill(rp, 101, 61, 298, 89);
 580:	|  |  |  |  |  |  |     |  |                     movea.l 2756 <GfxBase>,a6
 586:	|  |  |  |  |  |  |     |  |                     movea.l a2,a1
 588:	|  |  |  |  |  |  |     |  |                     moveq #101,d0
 58a:	|  |  |  |  |  |  |     |  |                     moveq #61,d1
 58c:	|  |  |  |  |  |  |     |  |                     move.l d5,d2
 58e:	|  |  |  |  |  |  |     |  |                     moveq #89,d3
 590:	|  |  |  |  |  |  |     |  |                     jsr -306(a6)
	SetAPen(rp, 1);
 594:	|  |  |  |  |  |  |     |  |                     movea.l 2756 <GfxBase>,a6
 59a:	|  |  |  |  |  |  |     |  |                     movea.l a2,a1
 59c:	|  |  |  |  |  |  |     |  |                     moveq #1,d0
 59e:	|  |  |  |  |  |  |     |  |                     jsr -342(a6)
	RefreshGadgets(&colorButton, window, NULL);
 5a2:	|  |  |  |  |  |  |     |  |                     movea.l 275a <IntuitionBase>,a6
 5a8:	|  |  |  |  |  |  |     |  |                     movea.l d6,a0
 5aa:	|  |  |  |  |  |  |     |  |                     movea.l a4,a1
 5ac:	|  |  |  |  |  |  |     |  |                     suba.l a2,a2
 5ae:	|  |  |  |  |  |  |     |  |                     jsr -222(a6)
						SetWindowTitles(window, (UBYTE *)"BG Program - Dark", (UBYTE *)-1);
 5b2:	|  |  |  |  |  |  |     |  |                     movea.l 275a <IntuitionBase>,a6
 5b8:	|  |  |  |  |  |  |     |  |                     movea.l a4,a0
					if (isGreenBackground) {
 5ba:	|  |  |  |  |  |  |     |  |                     tst.w 2754 <isGreenBackground>
 5c0:	|  |  |  |  |  |  |     |  '-------------------- bne.w 2ce <main+0x242>
						SetWindowTitles(window, (UBYTE *)"BG Program - White", (UBYTE *)-1);
 5c4:	|  |  |  |  |  |  '-----|----------------------> movea.l a5,a1
 5c6:	|  |  |  |  |  |        |                        movea.w #-1,a2
 5ca:	|  |  |  |  |  |        |                        jsr -276(a6)
			ReplyMsg((struct Message *)message);
 5ce:	|  |  |  |  |  |        |                        movea.l 2762 <SysBase>,a6
 5d4:	|  |  |  |  |  |        |                        movea.l a3,a1
 5d6:	|  |  |  |  |  |        |                        jsr -378(a6)
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
 5da:	|  |  |  |  |  |        |                        movea.l 2762 <SysBase>,a6
 5e0:	|  |  |  |  |  |        |                        movea.l 86(a4),a0
 5e4:	|  |  |  |  |  |        |                        jsr -372(a6)
 5e8:	|  |  |  |  |  |        |                        movea.l d0,a3
 5ea:	|  |  |  |  |  |        |                        tst.l d0
 5ec:	|  |  |  |  |  '--------|----------------------- bne.w 1f6 <main+0x16a>
 5f0:	|  |  |  |  |           '----------------------- bra.w 2fe <main+0x272>
		CloseLibrary((struct Library*)IntuitionBase);
 5f4:	|  |  |  >--|----------------------------------> movea.l 2762 <SysBase>,a6
 5fa:	|  |  |  |  |                                    movea.l 275a <IntuitionBase>,a1
 600:	|  |  |  |  |                                    jsr -414(a6)
		CloseLibrary((struct Library*)DOSBase);
 604:	|  |  |  |  |                                    movea.l 2762 <SysBase>,a6
 60a:	|  |  |  |  |                                    movea.l 275e <DOSBase>,a1
 610:	|  |  |  |  |                                    jsr -414(a6)
		Exit(0);
 614:	|  |  |  |  |                                    movea.l 275e <DOSBase>,a6
 61a:	|  |  |  |  |                                    moveq #0,d1
 61c:	|  |  |  |  |                                    jsr -144(a6)
 620:	|  |  |  |  +----------------------------------- bra.w ec <main+0x60>
		CloseLibrary((struct Library*)DOSBase);
 624:	>--|--|--|--|----------------------------------> movea.l 2762 <SysBase>,a6
 62a:	|  |  |  |  |                                    movea.l 275e <DOSBase>,a1
 630:	|  |  |  |  |                                    jsr -414(a6)
		Exit(0);
 634:	|  |  |  |  |                                    movea.l 275e <DOSBase>,a6
 63a:	|  |  |  |  |                                    moveq #0,d1
 63c:	|  |  |  |  |                                    jsr -144(a6)
	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
 640:	|  |  |  |  |                                    movea.l 2762 <SysBase>,a6
 646:	|  |  |  |  |                                    lea 6a2 <main+0x616>,a1
 64c:	|  |  |  |  |                                    moveq #0,d0
 64e:	|  |  |  |  |                                    jsr -552(a6)
 652:	|  |  |  |  |                                    move.l d0,2756 <GfxBase>
	if (!GfxBase) {
 658:	|  |  |  |  '----------------------------------- bne.w ec <main+0x60>
 65c:	|  |  |  '-------------------------------------- bra.s 5f4 <main+0x568>
		Exit(0);
 65e:	|  |  '----------------------------------------> suba.l a6,a6
 660:	|  |                                             moveq #0,d1
 662:	|  |                                             jsr -144(a6)
	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
 666:	|  |                                             movea.l 2762 <SysBase>,a6
 66c:	|  |                                             lea 690 <main+0x604>,a1
 672:	|  |                                             moveq #0,d0
 674:	|  |                                             jsr -552(a6)
 678:	|  |                                             move.l d0,275a <IntuitionBase>
	if (!IntuitionBase) {
 67e:	|  '-------------------------------------------- bne.w d0 <main+0x44>
 682:	'----------------------------------------------- bra.s 624 <main+0x598>
