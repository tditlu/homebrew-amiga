class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.4/amigeconv.zip"
  version "1.0.4"
  sha256 "dd6d9a56569ca3aef6e2ba93a7e31103ac2b6c44edffee9d51fdedfb8723d97d"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
