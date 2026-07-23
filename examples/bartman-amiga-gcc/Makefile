################################################################################
# Project configuration
################################################################################

SOURCES := \
	helloworld.c \
	helloworld.s

TARGET := bin/helloworld.exe

CPU     := 68000
SUPPORT ?= yes

################################################################################
# Directories
################################################################################

SRCDIR   := src
BUILDDIR := build
INCDIR   := include

################################################################################
# Toolchain
################################################################################

BARTMANDIR := $(shell brew --prefix tditlu/amiga/bartman-amiga-gcc)
VASMDIR    := $(shell brew --prefix vasm)

CC          := $(BARTMANDIR)/bin/m68k-amiga-elf-gcc
AS          := $(BARTMANDIR)/bin/m68k-amiga-elf-as
OBJDUMP     := $(BARTMANDIR)/bin/m68k-amiga-elf-objdump
ELF2HUNK    := $(BARTMANDIR)/bin/elf2hunk

VASM        := $(VASMDIR)/bin/vasmm68k_mot

SUPPORTDIR := $(BARTMANDIR)/template/support
SDKDIR     := $(BARTMANDIR)/m68k-amiga-elf/sys-include

################################################################################
# Commands
################################################################################

RM    := rm -rf
MKDIR := mkdir -p
ECHO  := @echo
QUIET := $(if $(V),,@)

################################################################################
# Compiler and linker flags
################################################################################

COMMONFLAGS := \
	-m$(CPU) \
	-Wall \
	-Wextra \
	-Wno-unused-parameter \
	-Wno-volatile-register-var \
	-ffreestanding \
	-fno-builtin \
	-fomit-frame-pointer

CFLAGS := \
	$(COMMONFLAGS) \
	-Os \
	-g \
	-flto \
	-I$(INCDIR) \
	-I$(SDKDIR)

ASFLAGS := \
	-mcpu=$(CPU) \
	-g \
	--register-prefix-optional \
	-I$(INCDIR) \
	-I$(SDKDIR)

VASMFLAGS := \
	-m$(CPU) \
	-Felf \
	-opt-fconst \
	-nowarn=62 \
	-dwarf=3 \
	-x \
	-I$(INCDIR) \
	-I$(SDKDIR)

LDFLAGS := \
	-m$(CPU) \
	-nostdlib \
	-flto \
	-Wl,--emit-relocs,--gc-sections,-Ttext=0

################################################################################
# Source files
################################################################################

CSOURCES := $(filter %.c,$(SOURCES))
SSOURCES  := $(filter %.s,$(SOURCES))
ASMSOURCES := $(filter %.asm,$(SOURCES))

COBJECTS := $(addprefix $(BUILDDIR)/,$(CSOURCES:.c=.c.o))
SOBJECTS  := $(addprefix $(BUILDDIR)/,$(SSOURCES:.s=.s.o))
ASMOBJECTS := $(addprefix $(BUILDDIR)/,$(ASMSOURCES:.asm=.asm.o))

OBJECTS := \
	$(COBJECTS) \
	$(SOBJECTS) \
	$(ASMOBJECTS)

################################################################################
# Runtime support
################################################################################

ifeq ($(SUPPORT),yes)

SUPPORTCSOURCE := $(SUPPORTDIR)/gcc8_c_support.c
SUPPORTSSOURCE := $(SUPPORTDIR)/gcc8_a_support.s

SUPPORTCOBJECT := $(BUILDDIR)/support/gcc8_c_support.c.o
SUPPORTSOBJECT := $(BUILDDIR)/support/gcc8_a_support.s.o

OBJECTS += \
	$(SUPPORTCOBJECT) \
	$(SUPPORTSOBJECT)

endif

################################################################################
# Generated files
################################################################################

TARGETNAME := $(notdir $(basename $(TARGET)))

ELFTARGET  := $(BUILDDIR)/$(TARGETNAME).elf
MAPTARGET  := $(BUILDDIR)/$(TARGETNAME).map
DUMPTARGET := $(BUILDDIR)/$(TARGETNAME).txt

VSCODEDIR    := .vscode
VSCODECONFIG := $(VSCODEDIR)/c_cpp_properties.json

DEPENDENCIES := $(OBJECTS:.o=.d)

################################################################################
# Targets
################################################################################

.PHONY: all
all: $(VSCODECONFIG) $(TARGET)

################################################################################
# VS Code configuration
################################################################################

.PHONY: vscodeconfig
vscodeconfig: $(VSCODECONFIG)

$(VSCODECONFIG): Makefile
	$(ECHO) Generating: \"$@\"
	$(QUIET)$(MKDIR) $(dir $@)
	$(QUIET)printf '%s\n' \
		'{' \
		'    "version": 4,' \
		'    "configurations": [' \
		'        {' \
		'            "name": "Amiga",' \
		'            "includePath": [' \
		'                "$${workspaceFolder}/$(INCDIR)",' \
		'                "$(SDKDIR)"' \
		'            ],' \
		'            "compilerPath": "$(CC)",' \
		'            "intelliSenseMode": "gcc-x64",' \
		'            "cStandard": "c17"' \
		'        }' \
		'    ]' \
		'}' > $@

################################################################################
# Link executable
################################################################################

$(ELFTARGET): $(OBJECTS)
	$(ECHO) Linking: \"$@\"
	$(QUIET)$(MKDIR) $(dir $@)
	$(QUIET)$(CC) \
		$(LDFLAGS) \
		-Wl,-Map,$(MAPTARGET) \
		-o $@ \
		$(OBJECTS)

################################################################################
# Create Amiga executable
################################################################################

$(TARGET): $(ELFTARGET)
	$(ECHO) Converting: \"$<\" --\> \"$@\"
	$(QUIET)$(MKDIR) $(dir $@)
	$(QUIET)$(ELF2HUNK) $< $@
	$(QUIET)$(OBJDUMP) -S -d $< > $(DUMPTARGET)

################################################################################
# Compile C source files
################################################################################

$(BUILDDIR)/%.c.o: $(SRCDIR)/%.c Makefile
	$(ECHO) Compiling: \"$<\" --\> \"$@\"
	$(QUIET)$(MKDIR) $(dir $@)
	$(QUIET)$(CC) $(CFLAGS) \
		-MMD \
		-MP \
		-MF $(@:.o=.d) \
		-c $< \
		-o $@

################################################################################
# Assemble source files
################################################################################

define VASMASSEMBLE
	$(ECHO) Assembling: \"$<\" --\> \"$@\"
	$(QUIET)$(MKDIR) $(dir $@)
	$(QUIET)$(VASM) $(VASMFLAGS) \
		-dependall=make \
		-depfile $(@:.o=.d) \
		-o $@ \
		$<
endef

$(BUILDDIR)/%.s.o: $(SRCDIR)/%.s Makefile
	$(VASMASSEMBLE)

$(BUILDDIR)/%.asm.o: $(SRCDIR)/%.asm Makefile
	$(VASMASSEMBLE)

################################################################################
# Compile runtime support
################################################################################

ifeq ($(SUPPORT),yes)

$(SUPPORTCOBJECT): $(SUPPORTCSOURCE) Makefile
	$(ECHO) Compiling support: \"$<\" --\> \"$@\"
	$(QUIET)$(MKDIR) $(dir $@)
	$(QUIET)$(CC) $(CFLAGS) \
		-MMD \
		-MP \
		-MF $(@:.o=.d) \
		-c $< \
		-o $@

$(SUPPORTSOBJECT): $(SUPPORTSSOURCE) Makefile
	$(ECHO) Assembling support: \"$<\" --\> \"$@\"
	$(QUIET)$(MKDIR) $(dir $@)
	$(QUIET)$(AS) $(ASFLAGS) \
		--MD $(@:.o=.d) \
		-o $@ \
		$<

endif

################################################################################
# Clean build files
################################################################################

.PHONY: clean
clean:
	$(ECHO) Cleaning
	$(QUIET)$(RM) $(BUILDDIR)
	$(QUIET)$(RM) $(TARGET)

################################################################################
# Include dependency files
################################################################################

-include $(DEPENDENCIES)
