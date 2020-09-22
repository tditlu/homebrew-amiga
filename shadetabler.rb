class Shadetabler < Formula
  desc ""
  homepage "https://github.com/tditlu/shadetabler"
  url "http://todi.se/brew/shadetabler/1.0.4/shadetabler.zip"
  version "1.0.4"
  sha256 "0ff4381726016f3f3f9998e33893d414b75b11d1155496bc7cd8b2e67ae1cb56"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end

