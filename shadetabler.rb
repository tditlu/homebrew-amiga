class Shadetabler < Formula
  desc ""
  homepage "https://github.com/tditlu/shadetabler"
  url "http://todi.se/brew/shadetabler/1.0.3/shadetabler.zip"
  version "1.0.3"
  sha256 "bbc61a8b24ff9a587b4226a46984676bbcb41839ed9685199b477858bbe93ce6"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end

