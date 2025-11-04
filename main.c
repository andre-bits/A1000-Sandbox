#include "support/gcc8_c_support.h"
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <workbench/startup.h>
#include <intuition/intuition.h>
#include <graphics/text.h>

struct ExecBase *SysBase;
struct DosLibrary *DOSBase;
struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;



// Function to detect if started from Workbench
BOOL IsWorkbenchStartup() {
	struct Process *proc = (struct Process *)FindTask(NULL);
	return (proc->pr_CLI == 0);
}

// Function to draw text in the window
void DrawWindowText(struct Window *window) {
	// Clear the window first
	SetAPen(window->RPort, 0);  // White background
	RectFill(window->RPort, window->BorderLeft, window->BorderTop, 
	         window->Width - window->BorderRight - 1, 
	         window->Height - window->BorderBottom - 1);
	
	// Draw a colored rectangle as background
	SetAPen(window->RPort, 2);  // Color 2 (usually dark)
	RectFill(window->RPort, window->BorderLeft + 5, window->BorderTop + 5, 
	         window->Width - window->BorderRight - 6, 
	         window->BorderTop + 85);
	
	// Set text colors
	SetAPen(window->RPort, 3);  // Color 3 for text (usually orange/light)
	SetBPen(window->RPort, 2);  // Background color 2
	
	// Draw text with proper positioning (account for window borders)
	Move(window->RPort, window->BorderLeft + 15, window->BorderTop + 25);
	Text(window->RPort, (STRPTR)"*** HELLO WORKBENCH! ***", 25);
	
	Move(window->RPort, window->BorderLeft + 15, window->BorderTop + 45);
	Text(window->RPort, (STRPTR)"Program started from Workbench", 30);
	
	Move(window->RPort, window->BorderLeft + 15, window->BorderTop + 65);
	Text(window->RPort, (STRPTR)"Close window or press ESC", 25);
	
	// Draw a simple border line
	SetAPen(window->RPort, 1);  // Black
	Move(window->RPort, window->BorderLeft + 5, window->BorderTop + 90);
	Draw(window->RPort, window->Width - window->BorderRight - 6, window->BorderTop + 90);
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
	nw.Height = 200;
	nw.DetailPen = 0;
	nw.BlockPen = 1;
	nw.IDCMPFlags = CLOSEWINDOW | MOUSEBUTTONS | VANILLAKEY | REFRESHWINDOW;
	nw.Flags = WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH | ACTIVATE | SMART_REFRESH;
	nw.FirstGadget = NULL;
	nw.CheckMark = NULL;
	nw.Title = (UBYTE *)"*** AMIGA WORKBENCH TEST ***";
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
	
	// Draw initial text
	DrawWindowText(window);
	
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
				case REFRESHWINDOW:
					// Redraw the window contents
					BeginRefresh(window);
					DrawWindowText(window);
					EndRefresh(window, TRUE);
					break;
			}
			ReplyMsg((struct Message *)message);
		}
	}
	
	CloseWindow(window);
}

int main() {
	SysBase = *((struct ExecBase**)4UL);

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

	// Check if started from Workbench
	if (IsWorkbenchStartup()) {
		// Started from Workbench - create window
		WorkbenchMode();
	} else {
		// Started from CLI/Shell - console output
		Write(Output(), (APTR)"Hello console!\n", 15);
		Write(Output(), (APTR)"This program was started from CLI/Shell.\n", 41);
		Write(Output(), (APTR)"Try running it from Workbench for GUI mode.\n", 45);
	}

	// Clean up libraries
	CloseLibrary((struct Library*)GfxBase);
	CloseLibrary((struct Library*)IntuitionBase);
	CloseLibrary((struct Library*)DOSBase);
	
	return 0;
}
