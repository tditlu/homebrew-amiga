/* Part of this example is borrowed from Bartman / Abyss (https://github.com/BartmanAbyss/vscode-amiga-debug) */

#include <proto/exec.h>
#include <proto/dos.h>

struct ExecBase *SysBase;
struct DosLibrary *DOSBase;

int main() {
	SysBase = *((struct ExecBase**)4UL);

	DOSBase = (struct DosLibrary*)OpenLibrary("dos.library", 0);
	if (!DOSBase) { return RETURN_ERROR; }

	Write(Output(), "Hello console!\n", sizeof("Hello console!\n"));

	CloseLibrary((struct Library*)DOSBase);
	return RETURN_OK;
}

__attribute__((used)) __attribute__((section(".text.unlikely"))) int _start() {
	return main();
}
