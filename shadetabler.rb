class Shadetabler < Formula
  desc ""
  homepage "https://github.com/tditlu/shadetabler"
  url "http://todi.se/brew/shadetabler/1.0.0/shadetabler.zip"
  version "1.0.0"
  sha256 "687784ff236d912cc1465ee17cf9160095c39351f02c7d7e62970d7cfd3787fc"

  def install
    system 'make'
    bin.install Dir['bin/*']
  end
end

