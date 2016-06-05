require 'formula'

class Shrinkler < Formula
  homepage 'https://bitbucket.org/askeksa/shrinkler/'
  url 'https://bitbucket.org/askeksa/shrinkler/downloads/shrinkler44.zip'
  version '4.4'
  sha256 'bc303c117332493f365a801d8f2088d4e823d0726c8efc769b619ceccde77a3d'

  def install
    File.rename 'MacOSX/Shrinkler', 'MacOSX/shrinkler'
    bin.install 'MacOSX/shrinkler'
  end
end
