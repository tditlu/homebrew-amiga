class Ira < Formula
  homepage 'http://sun.hasenbraten.de/~frank/projects/'
  url 'http://todi.se/brew/ira/2.10/ira.lha'
  version '2.10'
  sha256 'e9219446ce1b9a6a94fa67addbb7eb0e7babc590b62315d8f417072ad05aa435'

  depends_on 'lha' => :build

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
