class Ira < Formula
  homepage 'http://sun.hasenbraten.de/~frank/projects/'
  url 'http://todi.se/brew/ira/2.09/ira.lha'
  version '2.09'
  sha256 'afc8d0de89fb6232c5d4855dc6d8885c9133480450993cadf59b1613933224ef'

  depends_on 'lha' => :build

  def install
    Dir.chdir 'ira' do
      inreplace 'Makefile' do |s|
        s.change_make_var! 'CC', "#{ENV.cc} -std=c9x"
      end

      system 'make'
      bin.install 'ira'
    end
  end
end
