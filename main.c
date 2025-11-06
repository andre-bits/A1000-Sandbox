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

// Global variable to track current background color
BOOL isGreenBackground = FALSE;

// Border data for button outline (bigger button: 140x25)
SHORT buttonBorderData[] = {
	0, 0,           // Start point
	199, 0,         // Top line
	199, 29,        // Right line  
	0, 29,          // Bottom line
	0, 0            // Back to start
};

struct Border buttonBorder = {
	0, 0,           // LeftEdge, TopEdge
	1, 0, JAM1,     // FrontPen, BackPen, DrawMode
	5,              // Count (number of coordinate pairs)
	buttonBorderData, // XY coordinate data
	NULL            // NextBorder
};

// Simple gadget structures for our button
struct IntuiText buttonText = {
	1, 3,           // FrontPen (black=1), BackPen (orange=3)
	JAM2,           // DrawMode
	42, 12,          // LeftEdge, TopEdge (perfectly centered in 200px wide button)
	NULL,           // ITextFont (use default)
	(UBYTE *)"Change Color", // IText
	NULL            // NextText
};

struct Gadget colorButton = {
	NULL,               // NextGadget
	100, 60,            // LeftEdge, TopEdge (centered horizontally and moved up)
	200, 30,            // Width, Height (bigger button)
	GADGHCOMP,          // Flags (highlight when selected)
	RELVERIFY,          // Activation (release to verify)
	BOOLGADGET,         // GadgetType
	(APTR)&buttonBorder, // GadgetRender (our border)
	NULL,               // SelectRender
	&buttonText,        // GadgetText
	0,                  // MutualExclude
	NULL,               // SpecialInfo
	1,                  // GadgetID
	NULL                // UserData
};

// Function to detect if started from Workbench
BOOL IsWorkbenchStartup() {
	struct Process *proc = (struct Process *)FindTask(NULL);
	return (proc->pr_CLI == 0);
}

// Function to draw orange button background
void DrawButtonBackground(struct Window *window) {
	struct RastPort *rp = window->RPort;
	
	// Set orange pen (color 3 in default Workbench palette)
	SetAPen(rp, 3);
	
	// Draw filled rectangle for button background
	// Button is at position (100, 60) with size 200x30
	RectFill(rp, 101, 61, 298, 89);
	
	// Reset pen to black for other drawing
	SetAPen(rp, 1);
	
	// Now refresh the gadget to draw on top of the background
	RefreshGadgets(&colorButton, window, NULL);
}

// Function to change the window background color
void ChangeWindowBackground(struct Window *window) {
	struct RastPort *rp = window->RPort;
	
	// Toggle background color between white and green
	if (isGreenBackground) {
		// Change back to white (default window background)
		SetAPen(rp, 0);  // White pen (background color)
		isGreenBackground = FALSE;
	} else {
		// Change to green - now using pen 2 (button text uses pen 1 so no conflict)
		SetRGB4(&(window->WScreen->ViewPort), 2, 0, 15, 0);  // Set pen 2 to bright green
		SetAPen(rp, 2);  // Use pen 2 for green background
		isGreenBackground = TRUE;
	}
	
	// Fill only the inner client area of the window (not borders/title bar)
	// Start from the window's inner area and avoid the gadget area
	RectFill(rp, window->BorderLeft, window->BorderTop, 
	         window->Width - window->BorderRight - 1, 
	         window->Height - window->BorderBottom - 1);
	
	// Redraw the button background to maintain its orange color
	DrawButtonBackground(window);
}



// Function to create and manage Workbench window
void WorkbenchMode() {
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
	nw.Title = (UBYTE *)"AMIGA SANDBOX";
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
					// Button was clicked! Change the window background color
					ChangeWindowBackground(window);
					
					// Update window title to reflect current state
					if (isGreenBackground) {
						SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX - Green Background", (UBYTE *)-1);
					} else {
						SetWindowTitles(window, (UBYTE *)"AMIGA SANDBOX - Blue Background", (UBYTE *)-1);
					}
					break;
				case REFRESHWINDOW:
					// Redraw the window contents
					BeginRefresh(window);
					
					// Restore the current background color in the client area only
					if (isGreenBackground) {
						struct RastPort *rp = window->RPort;
						// Restore pen 2 to green for background
						SetRGB4(&(window->WScreen->ViewPort), 2, 0, 15, 0);  // Bright green
						SetAPen(rp, 2);  // Green pen (pen 2)
						RectFill(rp, window->BorderLeft, window->BorderTop, 
						         window->Width - window->BorderRight - 1, 
						         window->Height - window->BorderBottom - 1);
					}
					
					DrawButtonBackground(window);  // Draw orange button background
					EndRefresh(window, TRUE);
					break;
			}
			ReplyMsg((struct Message *)message);
		}
	}
	
	CloseWindow(window);
}

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

	WorkbenchMode();

	// Check if started from Workbench
	// if (IsWorkbenchStartup()) {
	// 	// Started from Workbench - create window
	// 	WorkbenchMode();
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
