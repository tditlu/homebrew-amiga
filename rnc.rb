class Rnc < Formula
  homepage 'https://github.com/lab313ru/rnc_propack_source/'
  url 'http://todi.se/brew/rnc_propack_source/1.2/rnc_propack_source.tar.gz'
  version '1.2'
  sha256 '85a3df783009aecd4579354c2b2d0a3bf528135ea11e7186a186c1d4e95b46f5'

  def install
    system 'make'
    File.rename 'rnc64', 'rnc'
    bin.install 'rnc'
  end
end
