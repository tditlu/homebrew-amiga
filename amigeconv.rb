class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.1.1/amigeconv.zip"
  version "1.1.1"
  sha256 "9dfa64b17696786616b5961a6ab627e02800498f8423c33475979b0514c601b3"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
