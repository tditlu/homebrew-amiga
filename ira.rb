class Ira < Formula
  homepage 'http://sun.hasenbraten.de/~frank/projects/'
  url 'https://todi.se/brew/ira/2.11/ira.lha'
  version '2.11'
  sha256 'ee288906c5b5dc55a2b2dc677b4fed1530c95786073fdeb5423a9014406c5223'

  depends_on "lhasa" => :build

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
