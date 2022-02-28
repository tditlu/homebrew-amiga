class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'https://todi.se/brew/vasm/1.9/vasm.tar.gz'
  mirror 'http://phoenix.owl.de/tags/vasm1_9.tar.gz'
  version '1.9'
  sha256 '1986e21096a7a08f18699921c719098152f0e981468fa8bf651fe44681526482'

  def install
    system "mkdir -p obj"

    inreplace 'Makefile' do |s|
      s.change_make_var! 'COPTS', "-c -O2 -DOUTAOUT -DOUTBIN -DOUTELF -DOUTHUNK -DOUTSREC -DOUTTOS -DOUTVOBJ #{ENV.cflags}"
      s.change_make_var! 'LDFLAGS', "-lm #{ENV.ldflags}"
    end

    system "make CPU=m68k SYNTAX=mot vasmm68k_mot"
    bin.install "vasmm68k_mot"

    system 'make vobjdump'
    bin.install 'vobjdump'

  end
end