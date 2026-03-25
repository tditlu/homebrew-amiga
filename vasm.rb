class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'https://todi.se/brew/vasm/2.0e/vasm.tar.gz'
  mirror 'http://phoenix.owl.de/tags/vasm2_0e.tar.gz'
  version '2.0e'
  sha256 'c73702574e8d6a154a7d64f22d7b618d0b85ace98ec9eb63d5e7c5ec696e3a6b'

  def install
    system "mkdir -p obj"

    inreplace 'Makefile' do |s|
      s.change_make_var! 'CFLAGS', "-c -O2 -DOUTAOUT -DOUTBIN -DOUTELF -DOUTHUNK -DOUTSREC -DOUTTOS -DOUTVOBJ #{ENV.cflags}"
      s.change_make_var! 'LDFLAGS', "-lm #{ENV.ldflags}"
    end

    system "make CPU=m68k SYNTAX=mot vasmm68k_mot"
    bin.install "vasmm68k_mot"

    system "make CPU=m68k SYNTAX=std vasmm68k_std"
    bin.install "vasmm68k_std"

    system 'make vobjdump'
    bin.install 'vobjdump'

  end
end
