class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.2/amigeconv.zip"
  version "1.0.2"
  sha256 "4a625b0701c10487e645d353315ea0199660901fbeecc321a52827a4d58c49f8"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
