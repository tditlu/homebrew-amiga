class BartmanAmigaGcc < Formula
  desc "Amiga m68k GCC toolchain from Bartman's vscode-amiga-debug extension"
  homepage "https://github.com/BartmanAbyss/vscode-amiga-debug"
  url "https://github.com/BartmanAbyss/vscode-amiga-debug/releases/download/1.8.2/amiga-debug-1.8.2.vsix"
  version "1.8.2"
  sha256 "c1e2b11175a5c5036d47eef095a21a616fbeb9f1a681364519c7910583d7ee3e"

  GCC_VERSION = "15.1.0".freeze

  def install
    vsix = Dir[buildpath/"*.vsix"].first
    odie "Visual Studio extension archive not found" unless vsix

    source_root = buildpath/"source"
    source_root.mkpath

    system "unzip", "-q", vsix, "-d", source_root

    platform = OS.mac? ? "darwin" : "linux"

    extension_root = source_root/"extension"
    platform_root = extension_root/"bin"/platform
    toolchain_root = platform_root/"opt"

    odie "Unsupported platform directory: #{platform_root}" unless platform_root.directory?
    odie "Toolchain directory not found: #{toolchain_root}" unless toolchain_root.directory?

    prefix.install toolchain_root.children

    # Install elf2hunk alongside the other public executables
    bin.install platform_root/"elf2hunk"

    # GCC runtime support files
    (prefix/"support").install \
      extension_root/"template/support/gcc8_a_support.s",
      extension_root/"template/support/gcc8_c_support.c",
      extension_root/"template/support/gcc8_c_support.h"

    # Debugger symbol definitions distributed with the extension
    (prefix/"support").install extension_root/"bin/symbols"

    executable_paths = [
      "bin/elf2hunk",

      "bin/m68k-amiga-elf-addr2line",
      "bin/m68k-amiga-elf-as",
      "bin/m68k-amiga-elf-gcc",
      "bin/m68k-amiga-elf-gdb",
      "bin/m68k-amiga-elf-ld",
      "bin/m68k-amiga-elf-objdump",

      "libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/cc1",
      "libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/cc1plus",
      "libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/collect2",
      "libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/lto-wrapper",
      "libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/lto1",

      "m68k-amiga-elf/bin/ar",
      "m68k-amiga-elf/bin/as",
      "m68k-amiga-elf/bin/ld",
      "m68k-amiga-elf/bin/ld.bfd",
      "m68k-amiga-elf/bin/nm",
      "m68k-amiga-elf/bin/objcopy",
      "m68k-amiga-elf/bin/objdump",
      "m68k-amiga-elf/bin/ranlib",
      "m68k-amiga-elf/bin/readelf",
      "m68k-amiga-elf/bin/strip",
    ]

    executable_paths.each do |relative_path|
      executable = prefix/relative_path
      odie "Expected executable not found: #{executable}" unless executable.file?

      executable.chmod 0755
    end
  end
end