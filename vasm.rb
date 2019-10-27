class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'https://server.owl.de/~frank/tags/vasm1_8f.tar.gz'
  mirror 'https://todi.se/brew/vasm/1.8f/vasm.tar.gz'
  version '1.8f'
  sha256 '9a97952951912b070a1b9118a466a3cd8024775be45266ede3f78b2f99ecc1f2'

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
