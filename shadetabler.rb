class Shadetabler < Formula
  desc ""
  homepage "https://github.com/tditlu/shadetabler"
  url "http://todi.se/brew/shadetabler/1.0.1/shadetabler.zip"
  version "1.0.1"
  sha256 "ccb521ba60b41af6784000462900e5b026762c2f38edb5ea4b6ac1f5666e061b"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end

