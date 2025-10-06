#include "support/gcc8_c_support.h"
#include <proto/exec.h>
#include <proto/dos.h>

struct ExecBase *SysBase;
struct DosLibrary *DOSBase;



int main() {
	SysBase = *((struct ExecBase**)4UL);

	// used for printing
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
	if (!DOSBase)
		Exit(0);

	Write(Output(), (APTR)"Hello console!\n", 15);

	CloseLibrary((struct Library*)DOSBase);
}
