class BartmanAmigaGcc < Formula
  desc "Amiga m68k GCC toolchain from Bartman's vscode-amiga-debug extension"
  homepage "https://github.com/BartmanAbyss/vscode-amiga-debug"
  url "https://github.com/BartmanAbyss/vscode-amiga-debug/releases/download/1.8.2/amiga-debug-1.8.2.vsix"
  version "1.8.2"
  sha256 "c1e2b11175a5c5036d47eef095a21a616fbeb9f1a681364519c7910583d7ee3e"

  depends_on :macos

  GCC_VERSION = "15.1.0".freeze

  def install
    vsix = Dir[buildpath/"*.vsix"].first
    odie "Visual Studio extension archive not found" unless vsix

    source_root = buildpath/"source"
    source_root.mkpath

    system "/usr/bin/unzip", "-q", vsix, "-d", source_root

    cd source_root do
      (libexec/"bin").install "extension/bin/symbols"

      (libexec/"bin/darwin").install \
        "extension/bin/darwin/opt",
        "extension/bin/darwin/elf2hunk"

      (libexec/"template/support").install \
        "extension/template/support/gcc8_a_support.s",
        "extension/template/support/gcc8_c_support.c",
        "extension/template/support/gcc8_c_support.h"
    end

    executable_paths = [
      "elf2hunk",

      "opt/bin/m68k-amiga-elf-addr2line",
      "opt/bin/m68k-amiga-elf-as",
      "opt/bin/m68k-amiga-elf-gcc",
      "opt/bin/m68k-amiga-elf-gdb",
      "opt/bin/m68k-amiga-elf-ld",
      "opt/bin/m68k-amiga-elf-objdump",

      "opt/libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/cc1",
      "opt/libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/cc1plus",
      "opt/libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/collect2",
      "opt/libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/lto-wrapper",
      "opt/libexec/gcc/m68k-amiga-elf/#{GCC_VERSION}/lto1",

      "opt/m68k-amiga-elf/bin/ar",
      "opt/m68k-amiga-elf/bin/as",
      "opt/m68k-amiga-elf/bin/ld",
      "opt/m68k-amiga-elf/bin/ld.bfd",
      "opt/m68k-amiga-elf/bin/nm",
      "opt/m68k-amiga-elf/bin/objcopy",
      "opt/m68k-amiga-elf/bin/objdump",
      "opt/m68k-amiga-elf/bin/ranlib",
      "opt/m68k-amiga-elf/bin/readelf",
      "opt/m68k-amiga-elf/bin/strip",
    ]

    executable_paths.each do |relative_path|
      chmod 0755, libexec/"bin/darwin"/relative_path
    end

    bin.install_symlink libexec/"bin/darwin/elf2hunk"

    Dir[libexec/"bin/darwin/opt/bin/*"].sort.each do |tool|
      bin.install_symlink tool if File.file?(tool)
    end
  end
end