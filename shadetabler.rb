class Shadetabler < Formula
  desc ""
  homepage "https://github.com/tditlu/shadetabler"
  url "http://todi.se/brew/shadetabler/1.0.5/shadetabler.zip"
  version "1.0.5"
  sha256 "59633c91b4564f289363229437a92a68efb7fd3f702565a1f3166bcb656ee59f"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end

