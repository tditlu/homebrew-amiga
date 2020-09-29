class Vasm < Formula
    homepage 'http://sun.hasenbraten.de/vasm/'
    url 'https://todi.se/brew/vasm/1.8i/vasm.tar.gz'

    version '1.8i'
    sha256 '9ae0b37bca11cae5cf00e4d47e7225737bdaec4028e4db2a501b4eca7df8639d'

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