class Rnc < Formula
  homepage 'https://github.com/lab313ru/rnc_propack_source/'
  url 'http://todi.se/brew/rnc_propack_source/1.4/rnc_propack_source.tar.gz'
  version '1.4'
  sha256 '5524faa9ec4c228b7600a42473a647414997da026a9cdb512f621081da8f2497'

  def install
    system 'make'
    File.rename 'rnc64', 'rnc'
    bin.install 'rnc'
  end
end
