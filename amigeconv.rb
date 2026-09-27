class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.1.2/amigeconv.zip"
  version "1.1.2"
  sha256 "8a1d89a072151c16b8d9fb444e45493334d6550f674f3b41d059c89c045813a1"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
