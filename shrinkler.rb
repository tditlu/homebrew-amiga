class Shrinkler < Formula
  desc "Shrinkler executable file compressor for Amiga by Blueberry"
  homepage "https://github.com/askeksa/Shrinkler"
  url "http://todi.se/brew/shrinkler/4.7/shrinkler.zip"
  mirror 'http://crinkler.net/shrinkler47.zip'
  version "4.7"
  sha256 "4a56ce76271065101bdb73d6f87c13f75b39eb3e4cffab600a37e809829de834"

  def install
    File.rename 'MacOSX/Shrinkler', 'MacOSX/shrinkler'
    bin.install 'MacOSX/shrinkler'
  end
end
