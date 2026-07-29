class Ira < Formula
  homepage 'http://sun.hasenbraten.de/~frank/projects/'
  url 'https://todi.se/brew/ira/2.11/ira.tar.gz'
  version '2.11'
  sha256 'd02f519be595eb29c97d853d4b358cbfdacc57e646a8a2524e7a302be994e123'

  def install
#    Dir.chdir 'ira' do
      inreplace 'Makefile' do |s|
        s.change_make_var! 'CC', "#{ENV.cc} -std=c9x"
      end

      system 'make'
      bin.install 'ira'
#    end
  end
end
