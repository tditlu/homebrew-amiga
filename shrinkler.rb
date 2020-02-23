class Shrinkler < Formula
  desc "Shrinkler executable file compressor for Amiga by Blueberry"
  homepage "https://github.com/askeksa/Shrinkler"
  url "http://todi.se/brew/shrinkler/4.6/shrinkler.zip"
  mirror 'http://crinkler.net/shrinkler46.zip'
  version "4.6"
  sha256 "2046ac4a5336135741b8e03f0dab3c4070a13eeef52343bcb5573de071956355"

  def install
    File.rename 'MacOSX/Shrinkler', 'MacOSX/shrinkler'
    bin.install 'MacOSX/shrinkler'
  end
end
