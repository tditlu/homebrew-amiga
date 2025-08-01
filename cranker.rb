class Cranker < Formula
  desc "Cranker - Amiga executable cruncher by Bifat/TEK"
  homepage "http://neoscientists.org/~bifat/binarydistillery/cranker/"
  url "http://todi.se/brew/cranker/0.66/cranker-0.66_macosx_intel_64bit"
  mirror 'http://neoscientists.org/~bifat/binarydistillery/cranker/cranker-0.66_macosx_intel_64bit'
  version "0.66"
  sha256 "b79ff465a76092f8c1226a05bc0ea018b321d368c76cee80f81bb1d302a38c4b"

  def install
    File.rename 'cranker-0.66_macosx_intel_64bit', 'cranker'
    bin.install 'cranker'
  end
end
