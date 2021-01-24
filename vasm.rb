class Vasm < Formula
    homepage 'http://sun.hasenbraten.de/vasm/'
    url 'https://todi.se/brew/vasm/1.8j/vasm.tar.gz'
    mirror 'https://server.owl.de/~frank/tags/vasm1_8j.tar.gz'
    version '1.8j'
    sha256 '8b8b78091d82a92769778b2964e64c4fb98e969b46d65708dcf88f6957072676'
  
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