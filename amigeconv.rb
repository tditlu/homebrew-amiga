class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.8/amigeconv.zip"
  version "1.0.8"
  sha256 "a418e9cc5d345042c862479dacf8fbfdca5f91b4f7bf7aaaab9748d8c52871f8"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
