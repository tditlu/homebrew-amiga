require 'formula'

class Shrinkler < Formula
  homepage 'https://bitbucket.org/askeksa/shrinkler/'
  url 'https://bitbucket.org/askeksa/shrinkler/downloads/shrinkler44.zip'
  version '4.4'
  sha1 'ca3ac5e59e2feb5f18cea04f59b56225dd6b5389'

  def install
    File.rename 'MacOSX/Shrinkler', 'MacOSX/shrinkler'
    bin.install 'MacOSX/shrinkler'
  end
end
