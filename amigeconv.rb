class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.0/amigeconv.zip"
  version "1.0.0"
  sha256 "0ad40a4dfcce85cd359c438b6469be30474e8b7f21f75fc76e9d66fa01f1ab17"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
