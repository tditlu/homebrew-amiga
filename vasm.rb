class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'http://todi.se/brew/vasm/1.8d/vasm.tar.gz'
  version '1.8d'
  sha256 'ad68732600665e822dca60ea1f6b26854beda76e8f9c604358cf93b5cbb265be'

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
