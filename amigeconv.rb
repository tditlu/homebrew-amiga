class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.5/amigeconv.zip"
  version "1.0.5"
  sha256 "9fb6b134a78a86171bdc48e11685d26dca0ef6ab9f440f31934012b8a7b1eb7d"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
