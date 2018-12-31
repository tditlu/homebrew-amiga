class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'http://todi.se/brew/vasm/1.8e/vasm.tar.gz'
  version '1.8e'
  sha256 '40066af65885860e5ac28fb096abeb70492a8314d97558af30a5bfa119b3edd0'

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
