class Elf2hunk < Formula
  homepage "https://github.com/BartmanAbyss/vscode-amiga-debug/blob/master/bin/elf2hunk.c"
  url "https://todi.se/brew/elf2hunk/0.7.0/elf2hunk-0.7.0.zip"
  sha256 "d4975ab699d85041440a906c4dc17f9c505c7bbbd67b7fcefb3d98089e7375c3"

  def install
    system 'make'
    bin.install 'elf2hunk'
  end
end
