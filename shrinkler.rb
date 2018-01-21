class Shrinkler < Formula
  desc "Shrinkler executable file compressor for Amiga by Blueberry"
  homepage "https://github.com/askeksa/Shrinkler"
  url "http://todi.se/brew/shrinkler/4.5/shrinkler.zip"
  version "4.5"
  sha256 "15a4219ad5279d2ebdd6917b99a80c721acaa5d6c8d045adffcaf2761fa6e71d"

  def install
    File.rename 'MacOSX/Shrinkler', 'MacOSX/shrinkler'
    bin.install 'MacOSX/shrinkler'
  end
end
