require 'formula'

class Modpack < Formula
  desc ""
  homepage "https://github.com/amigadev/modpack"
  url "http://todi.se/brew/modpack/26ef99b/modpack.zip"
  version "0.0.0.2017.10.17"
  sha256 "24ea7e216e0394c177f7592f35f5e2bff523938f91f18254fbbea19f49674f7d"

  def install
    system 'make'
    bin.install 'modpack'
  end

end
