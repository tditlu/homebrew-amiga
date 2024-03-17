class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.7/amigeconv.zip"
  version "1.0.7"
  sha256 "b9d463a3745f9f67d3131e89cdc6c977e90108ac963f761a3526f86ca34c738d"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
