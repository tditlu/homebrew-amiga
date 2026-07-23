class Shrinkler < Formula
  desc "Shrinkler executable file compressor for Amiga by Blueberry"
  homepage "https://github.com/askeksa/Shrinkler"
  url "https://todi.se/brew/shrinkler/4.7/shrinkler.zip"
  mirror "https://crinkler.net/shrinkler47.zip"
  version "4.7"
  sha256 "4a56ce76271065101bdb73d6f87c13f75b39eb3e4cffab600a37e809829de834"

  def install
    executable =
      if OS.mac?
        buildpath/"MacOSX/Shrinkler"
      else
        buildpath/"Linux64/Shrinkler"
      end

    odie "Shrinkler executable not found: #{executable}" unless executable.file?

    executable.chmod 0755
    bin.install executable => "shrinkler"
  end
end