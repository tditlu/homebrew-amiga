class Ira < Formula
  homepage 'http://sun.hasenbraten.de/~frank/projects/'
  url 'https://todi.se/brew/ira/2.11/ira.tar.gz'
  version '2.11'
  sha256 'e9a42a941ebf1b1fb378bad1fcb882113636b61747ce1280b8c42797'

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
