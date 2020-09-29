class Vlink < Formula
    homepage 'http://sun.hasenbraten.de/vlink/'
    url 'http://sun.hasenbraten.de/vlink/release/vlink.tar.gz'
    mirror 'https://todi.se/brew/vlink/0.16f/vlink.tar.gz'
    version '0.16f'
    sha256 '915bd7c569f41c153b1a3208f556c743dba4319c39c8b858554cb6bc24306626'

    def install
        mkdir 'objects'

        inreplace 'Makefile' do |s|
            s.change_make_var! 'CC', "#{ENV.cc}"
            s.change_make_var! 'COPTS', "-fomit-frame-pointer -c #{ENV.cflags}"
            s.change_make_var! 'LD', "#{ENV.cc}"
            s.change_make_var! 'LDOPTS', "#{ENV.ldflags}"
        end

        system 'make'
        bin.install 'vlink'
    end
end
