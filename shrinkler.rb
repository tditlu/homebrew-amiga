require 'formula'

class Shrinkler < Formula
  desc "Shrinkler executable file compressor for Amiga by Blueberry"
  homepage "https://github.com/askeksa/Shrinkler"
  url "http://todi.se/brew/shrinkler/b20d7d2/shrinkler.zip"
  version "4.4.0.2017.11.05"
  sha256 "c2fb19f94e0eda5ac52b07fa131297a024ff6648fd5bc020d3619c7d4933cc54"

  depends_on 'python' => :build

  def install
    system 'make PLATFORM=native-64'
    File.rename 'build/native-64/Shrinkler', 'build/native-64/shrinkler'
    bin.install 'build/native-64/shrinkler'
  end

end
