class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'https://todi.se/brew/vasm/2.0a/vasm.tar.gz'
  mirror 'http://phoenix.owl.de/tags/vasm2_0a.tar.gz'
  version '2.0a'
  sha256 '413181dae18f7d566c4aeee669039ea20083817c412a402eed5ec8490f7b9d76'

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
