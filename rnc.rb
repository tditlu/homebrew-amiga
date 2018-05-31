class Rnc < Formula
  homepage 'https://github.com/lab313ru/rnc_propack_source/'
  url 'http://todi.se/brew/rnc_propack_source/1.3/rnc_propack_source.tar.gz'
  version '1.3'
  sha256 '3c46b6f9a47824cfea7963e631d0c774e6430a8cb08f586789f8926c34a6089d'

  def install
    system 'make'
    File.rename 'rnc64', 'rnc'
    bin.install 'rnc'
  end
end
