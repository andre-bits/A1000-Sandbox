#include "support/gcc8_c_support.h"
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <workbench/startup.h>
#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>
#include <graphics/text.h>

struct ExecBase *SysBase;
struct DosLibrary *DOSBase;
struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

/**
 * Coordinates data for button border.
 */
SHORT buttonBorderData[] = {
	0, 0,
	199, 0,
	199, 29,
	0, 29,
	0, 0
};

/**
 * Declare a button border.
 */
struct Border buttonBorder = {
	0, 0,
	1, 0, JAM1,
	5,
	buttonBorderData,
	NULL
};

/**
 * Declare a button text.
 */
struct IntuiText buttonText = {
	1, 3,
	JAM2,
	42, 12,
	NULL,
	(UBYTE *) "Change Color",
	NULL
};

/**
 * Declare a button gadget.
 */
struct Gadget colorButton = {
	NULL,
	100, 60,
	200, 30,
	GADGHCOMP,
	RELVERIFY,
	BOOLGADGET,
	(APTR)&buttonBorder,
	NULL,
	&buttonText,
	0,
	NULL,
	1,
	NULL
};

BOOL isGreenBackground = FALSE;

BOOL IsWorkbenchStartup() {
	struct Process *proc = (struct Process *)FindTask(NULL);
	return (proc->pr_CLI == 0);
}

/**
 * Function to draw the button background. 
 */
void DrawButtonBackground(struct Window *window) {
	struct RastPort *rp = window->RPort;
	
	// Set orange pen (color 3 in default Workbench palette)
	SetAPen(rp, 3);
	
	// Draw filled rectangle for button background
	RectFill(rp, 101, 61, 298, 89);
	
	// Reset pen to black for other drawing
	SetAPen(rp, 1);
	
	// Refresh the gadget to draw on top of the background
	RefreshGadgets(&colorButton, window, NULL);
}

/**
 * Changes the intuition window background color.
 */
void ChangeWindowBackground(struct Window *window) {
	struct RastPort *rp = window->RPort;
	
	if (isGreenBackground) {
		SetAPen(rp, 1);  // Blue pen
		isGreenBackground = FALSE;
	} else {
		SetAPen(rp, 2);  // Green pen
		isGreenBackground = TRUE;
	}
	
	/**
	 * Redraw the window background color in the client 
	 * area of the window, excluding borders and title bar.
	 */
	RectFill(rp, window->BorderLeft, window->BorderTop, 
	         window->Width - window->BorderRight - 1, 
	         window->Height - window->BorderBottom - 1);
	
	// Re-draw the button background again
	DrawButtonBackground(window);
}

/**
 * Runs the program.
 */
void LaunchProgram() {
	struct Window *window;
	struct IntuiMessage *message;
	struct NewWindow nw;
	BOOL done = FALSE;
	
	// Set up the NewWindow structure
	nw.LeftEdge = 50;
	nw.TopEdge = 50;
	nw.Width = 400;
	nw.Height = 150;
	nw.DetailPen = 0;
	nw.BlockPen = 1;
	nw.IDCMPFlags = CLOSEWINDOW | MOUSEBUTTONS | VANILLAKEY | REFRESHWINDOW | GADGETUP;
	nw.Flags = WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH | ACTIVATE | SMART_REFRESH;
	nw.FirstGadget = &colorButton;
	nw.CheckMark = NULL;
	nw.Title = (UBYTE *)"BG Program";
	nw.Screen = NULL;  // Use default Workbench screen
	nw.BitMap = NULL;
	nw.MinWidth = 200;
	nw.MinHeight = 100;
	nw.MaxWidth = 640;
	nw.MaxHeight = 400;
	nw.Type = WBENCHSCREEN;
	
	// Open the window
	window = OpenWindow(&nw);
	if (!window) {
		return;
	}
	
	// Draw the initial orange button background
	DrawButtonBackground(window);
	
	// Event loop
	while (!done) {
		Wait(1L << window->UserPort->mp_SigBit);
		
		while ((message = (struct IntuiMessage *)GetMsg(window->UserPort))) {
			switch (message->Class) {
				case CLOSEWINDOW:
					done = TRUE;
					break;
				case VANILLAKEY:
					if (message->Code == 27) {  // ESC key
						done = TRUE;
					}
					break;
				case GADGETUP:
					// Button was clicked: Change the window background color
					ChangeWindowBackground(window);
					
					// Update window title to reflect current state
					if (isGreenBackground) {
						SetWindowTitles(window, (UBYTE *)"BG Program - Dark", (UBYTE *)-1);
					} else {
						SetWindowTitles(window, (UBYTE *)"BG Program - White", (UBYTE *)-1);
					}
					break;
				case REFRESHWINDOW:
					// Redraw the window contents
					BeginRefresh(window);
					
					// Restore the current background color
					if (isGreenBackground) {
						struct RastPort *rp = window->RPort;
						SetAPen(rp, 2);
						RectFill(rp, window->BorderLeft, window->BorderTop, 
						         window->Width - window->BorderRight - 1, 
						         window->Height - window->BorderBottom - 1);
					} else {
						struct RastPort *rp = window->RPort;
						SetAPen(rp, 1);
						RectFill(rp, window->BorderLeft, window->BorderTop, 
						         window->Width - window->BorderRight - 1, 
						         window->Height - window->BorderBottom - 1);
					}
					
					DrawButtonBackground(window);
					EndRefresh(window, TRUE);
					break;
			}
			ReplyMsg((struct Message *)message);
		}
	}
	
	CloseWindow(window);
}

// Made it to here

int main() {
	SysBase = *(struct ExecBase**)4;

	// Open required libraries
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
	if (!DOSBase)
		Exit(0);

	IntuitionBase = (struct IntuitionBase*)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
	if (!IntuitionBase) {
		CloseLibrary((struct Library*)DOSBase);
		Exit(0);
	}

	GfxBase = (struct GfxBase*)OpenLibrary((CONST_STRPTR)"graphics.library", 0);
	if (!GfxBase) {
		CloseLibrary((struct Library*)IntuitionBase);
		CloseLibrary((struct Library*)DOSBase);
		Exit(0);
	}

	LaunchProgram();

	// Check if started from Workbench
	// if (IsWorkbenchStartup()) {
	// 	// Started from Workbench - create window
	// 	LaunchProgram();
	// } else {
	// 	// Started from CLI/Shell - console output
	// 	Write(Output(), (APTR)"Hello console!\n", 15);
	// 	Write(Output(), (APTR)"This program was started from CLI/Shell.\n", 41);
	// 	Write(Output(), (APTR)"Try running it from Workbench for GUI mode.\n", 45);
	// }

	// Clean up libraries
	CloseLibrary((struct Library*)GfxBase);
	CloseLibrary((struct Library*)IntuitionBase);
	CloseLibrary((struct Library*)DOSBase);
	
	return 0;
}
