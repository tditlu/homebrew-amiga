class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.1/amigeconv.zip"
  version "1.0.1"
  sha256 "a6acf5fa0515a40454e69976df5db968c9575fce4f94509a64e21fd88f1396cc"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
