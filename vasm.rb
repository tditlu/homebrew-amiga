class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'https://todi.se/brew/vasm/1.8g/vasm.tar.gz'
  version '1.8g'
  sha256 'c5189133ad1ef93feaea3c610d454b114bb1b8775c6c5e3cf1d3b32194d09743'

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
