require 'formula'

class Hunkmerge < Formula
  homepage 'https://bitbucket.org/askeksa/shrinkler/'
  url 'https://todi.se/brew/hunkmerge/4.4/hunkmerge.zip'
  version '4.4'
  sha256 'fa8c9cc9ad8973613d9e6f1b495adae9167075600e1367c262d97261ecc16d6d'

  def install
    File.rename 'HunkMerge', 'hunkmerge'
    bin.install 'hunkmerge'
  end
end
