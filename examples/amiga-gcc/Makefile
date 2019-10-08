# Part of this example is borrowed from Bartman / Abyss (https://github.com/BartmanAbyss/vscode-amiga-debug)

AMIGA_GCC = $(shell brew --prefix tditlu/amiga/amiga-gcc)
CC        = $(AMIGA_GCC)/bin/m68k-amiga-elf-gcc
OBJDUMP   = $(AMIGA_GCC)/bin/m68k-amiga-elf-objdump
ELF2HUNK  = $(AMIGA_GCC)/bin/elf2hunk
RIMRAF    = /bin/rm -rf

# To generate assembler sources: -Wa,-ahl=$@.s
CCFLAGS = -g -MP -MMD -m68000 -Ofast -nostdlib -Wall -Wno-pointer-sign -Wno-unused-function -Wno-volatile-register-var -Wno-discarded-qualifiers -fomit-frame-pointer -fno-tree-loop-distribution -flto -fwhole-program
ASFLAGS = -Wa,-g,--verbose
LDFLAGS = -Wl,--emit-relocs,-Ttext=0,-Map=helloworld.map

.PHONY: all

all: helloworld.exe

helloworld.exe: helloworld.elf
	$(ELF2HUNK) helloworld.elf helloworld.exe

helloworld.elf: helloworld.o
	$(CC) $(CCFLAGS) $(LDFLAGS) -o $@ $<
	$(OBJDUMP) --disassemble -S $@ > helloworld.s

helloworld.o: helloworld.c
	$(CC) $(CCFLAGS) -c -o $@ $<

-include helloworld.d

.PHONY: clean

clean:
	@$(RIMRAF) helloworld.o helloworld.d helloworld.s helloworld.elf helloworld.map helloworld.exe
