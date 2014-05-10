require 'formula'

class Shrinkler < Formula
  homepage 'https://bitbucket.org/askeksa/shrinkler/'
  url 'https://bitbucket.org/askeksa/shrinkler/downloads/shrinkler41.zip'
  version '4.1'
  sha1 '13ec6aeaf77a8d87094503ad7a432325c85bd34c'

  def install
    File.rename 'MacOSX/Shrinkler', 'MacOSX/shrinkler'
    bin.install 'MacOSX/Shrinkler'
  end
end
