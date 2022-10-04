class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'https://todi.se/brew/vasm/1.9a/vasm.tar.gz'
  mirror 'http://phoenix.owl.de/tags/vasm1_9a.tar.gz'
  version '1.9a'
  sha256 '6b6d19197d0b420ebedfae60b1256c630431e18f47350269582aa994e06298fa'

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
