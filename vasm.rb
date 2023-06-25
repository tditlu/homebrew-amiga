class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'https://todi.se/brew/vasm/1.9d/vasm.tar.gz'
  mirror 'http://phoenix.owl.de/tags/vasm1_9d.tar.gz'
  version '1.9d'
  sha256 '0e5d4285bdca8d1db9eae4ea8061788bce603bf5c1f369f070c2218b4915c985'

  def install
    system "mkdir -p obj"

    inreplace 'Makefile' do |s|
      s.change_make_var! 'COPTS', "-c -O2 -DOUTAOUT -DOUTBIN -DOUTELF -DOUTHUNK -DOUTSREC -DOUTTOS -DOUTVOBJ #{ENV.cflags}"
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
