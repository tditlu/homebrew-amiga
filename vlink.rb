class Vlink < Formula
    homepage 'http://sun.hasenbraten.de/vlink/'
    url 'https://todi.se/brew/vlink/0.18/vlink.tar.gz'
    mirror 'http://phoenix.owl.de/tags/vlink0_18.tar.gz'
    version '0.18'
    sha256 'a40c3313ef5b0956cad8f140557b70ee88a9e96cf14bbc3276cca565fa0fdf01'

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