class Cranker < Formula
  desc "Cranker - Amiga executable cruncher by Bifat/TEK"
  homepage "https://neoscientists.org/~bifat/binarydistillery/cranker/"
  version "0.66"

  on_macos do
    url "https://todi.se/brew/cranker/0.66/cranker-0.66_macosx_intel_64bit"
    mirror "https://neoscientists.org/~bifat/binarydistillery/cranker/cranker-0.66_macosx_intel_64bit"
    sha256 "b79ff465a76092f8c1226a05bc0ea018b321d368c76cee80f81bb1d302a38c4b"
  end

  on_linux do
    url "https://todi.se/brew/cranker/0.66/cranker-0.66_linux"
    url "https://neoscientists.org/~bifat/binarydistillery/cranker/cranker-0.66_linux"
    sha256 "05ae8a44a7b4cfe2d41eb34dc374a038aa61b42c"
  end

  def install
    executable =
      if OS.mac?
        buildpath/"cranker-0.66_macosx_intel_64bit"
      else
        buildpath/"cranker-0.66_linux"
      end

    odie "Cranker executable not found: #{executable}" unless executable.file?

    executable.chmod 0755
    bin.install executable => "cranker"
  end
end