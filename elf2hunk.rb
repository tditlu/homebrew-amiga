class Elf2hunk < Formula
  homepage "https://github.com/BartmanAbyss/vscode-amiga-debug/blob/master/bin/elf2hunk.c"
  url "https://todi.se/brew/elf2hunk/0.7.0/elf2hunk-0.7.0.zip"
  sha256 "68c70000b03fc83ee3f16f63b2dab1f0aa6ca831408864a2467cb7f35bcfbdca"

  def install
    system 'make'
    bin.install 'elf2hunk'
  end
end
