require 'formula'

class Shrinkler < Formula
  homepage 'https://bitbucket.org/askeksa/shrinkler'
  url 'https://bitbucket.org/askeksa/shrinkler/get/569e994736e2.zip'
  version '4.0.569e994736e2'
  sha1 'f8ee9d2bacce206d8c57c19957f554630aa9922e'

  def install
    inreplace 'MatchFinder.h' do |s|
      s.gsub! /static const int END_OF_CHAIN = -2;/, ''
      s.gsub! /END_OF_CHAIN/, '-2'
    end

    system 'make PLATFORM=native'
    File.rename 'build/native/Shrinkler', 'build/native/shrinkler'
    bin.install 'build/native/shrinkler'
  end

end
