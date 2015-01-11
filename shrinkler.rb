require 'formula'

class Shrinkler < Formula
  homepage 'https://bitbucket.org/askeksa/shrinkler/'
  url 'https://bitbucket.org/askeksa/shrinkler/downloads/shrinkler43.zip'
  version '4.3'
  sha1 'd1324eb5786200ebb8378a26cbc6c3bd61b5765d'

  def install
    File.rename 'MacOSX/Shrinkler', 'MacOSX/shrinkler'
    bin.install 'MacOSX/shrinkler'
  end
end
