class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.9/amigeconv.zip"
  version "1.0.9"
  sha256 "94bc92c04ff181bdc6ebd0692bb671eb81c4cb228da074f1990ce19479f6e0e2"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
