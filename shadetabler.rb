class Shadetabler < Formula
  desc ""
  homepage "https://github.com/tditlu/shadetabler"
  url "http://todi.se/brew/shadetabler/1.0.2/shadetabler.zip"
  version "1.0.2"
  sha256 "871a5799b014c07afbaac057fb07702e1aa9c44ea0656fe0c4383d4ab2091af2"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end

