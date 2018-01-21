class Ira < Formula
  homepage 'http://sun.hasenbraten.de/~frank/projects/'
  url 'http://todi.se/brew/ira/2.08/ira.lha'
  version '2.08'
  sha256 '87f899a908b954f3c923e5d6552146e8d64ffcea89c89103f4d8c36b0ae6b6a1'

  depends_on 'lha' => :build

  def install
    inreplace 'Makefile' do |s|
      s.change_make_var! 'CC', "#{ENV.cc} -std=c9x"
    end

    system 'make'

    bin.install 'ira'
  end
end
