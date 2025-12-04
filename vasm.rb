class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'https://todi.se/brew/vasm/2.0d/vasm.tar.gz'
  mirror 'http://phoenix.owl.de/tags/vasm2_0d.tar.gz'
  version '2.0d'
  sha256 'a818b0cef018c3b88be998de2c15ece83303cbe4a15f0b391c0203710b262f2e'

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
