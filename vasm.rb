class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'https://todi.se/brew/vasm/1.8k/vasm.tar.gz'

  version '1.8k'
  sha256 '16d82a104c4122a2eb259fb5ee7326e909f544c1bbd5a1749584677fcba47967'

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
