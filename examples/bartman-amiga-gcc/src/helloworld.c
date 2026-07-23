/* Part of this example is borrowed from Bartman / Abyss (https://github.com/BartmanAbyss/vscode-amiga-debug) */

#include <proto/exec.h>
#include <proto/dos.h>

#include "helloworld.h"

static const BYTE message[] = "Hello world from C!\n";

struct ExecBase *SysBase;
struct DosLibrary *DOSBase;

int main() {
	SysBase = *(struct ExecBase * volatile *)4UL;

	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
	if (!DOSBase) { return RETURN_ERROR; }

	Write(Output(), (APTR)message, sizeof(message) - 1);

	CloseLibrary((struct Library*)DOSBase);
	// return RETURN_OK;

	LONG result = hello_world();
	return (int)result;
}

/*
// Required only when SUPPORT = no in the Makefile
__attribute__((used)) __attribute__((section(".text.unlikely"))) int _start() {
	return main();
}
*/
