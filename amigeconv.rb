class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.1.0/amigeconv.zip"
  version "1.1.0"
  sha256 "fea5449407407f72aa3f46d0fd5cc27490c78057cf5771243f8f8e63842c3f26"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
