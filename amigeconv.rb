class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.6/amigeconv.zip"
  version "1.0.6"
  sha256 "7b039baf9551fecf52b75721b203533862bc45fe4a6d099e73a38e175be73615"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
