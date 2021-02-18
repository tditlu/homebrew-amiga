class Amigeconv < Formula
  desc ""
  homepage "https://github.com/tditlu/amigeconv"
  url "http://todi.se/brew/amigeconv/1.0.3/amigeconv.zip"
  version "1.0.3"
  sha256 "12004398bb80f1f4350c150198b93fbb982d9b53892c9290c7ce5332c8e23745"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end
