class M68kAmigaElfGcc < Formula
  desc "GNU compiler collection for Amiga by Bartman"
  homepage "https://github.com/BartmanAbyss/vscode-amiga-debug"
  url "https://github.com/BartmanAbyss/vscode-amiga-debug/archive/refs/tags/1.7.2.zip"
  version "13.1.0"
  sha256 "f0301c0509ded7c2df130195f07cd37c4dcd5939ccdee78b32bf6103ffdb05b8"

  keg_only "because `gcc` provides similar software and installing this software in parallel can cause all kinds of trouble."

  def install
    bin.install Dir['bin/darwin/opt/bin/*']

    (prefix/'lib').mkpath
    (prefix/'lib').install Dir['bin/darwin/opt/lib/*']

    (prefix/'libexec').mkpath
    (prefix/'libexec').install Dir['bin/darwin/opt/libexec/*']

    (prefix/'m68k-amiga-elf').mkpath
    (prefix/'m68k-amiga-elf').install Dir['bin/darwin/opt/m68k-amiga-elf/*']
  end
end
