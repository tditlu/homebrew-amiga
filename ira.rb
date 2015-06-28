require 'formula'

class Ira < Formula
  homepage 'http://sun.hasenbraten.de/~frank/projects/'
  url 'http://todi.se/brew/ira/2.08beta/ira.lha'
  version '2.08beta'
  sha1 'd7f7979c04d10082ede8df4dbe43692dfd2d4007'

  depends_on 'lha' => :build

  def install
    inreplace 'Makefile' do |s|
      s.change_make_var! 'CC', "#{ENV.cc} -std=c9x"
    end

    system 'make'

    bin.install 'ira'
  end

end
