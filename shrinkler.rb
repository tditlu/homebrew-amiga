require 'formula'

class Shrinkler < Formula
  homepage 'https://bitbucket.org/askeksa/shrinkler'
  url 'https://bitbucket.org/askeksa/shrinkler/get/819d8d8102ca.zip'
  version '4.1.819d8d8102ca'
  sha1 '6596824b23c8f7191aa35121ab58060ba1c7bc7a'

  def install
    system 'make PLATFORM=native'
    File.rename 'build/native/Shrinkler', 'build/native/shrinkler'
    bin.install 'build/native/shrinkler'
  end

end
