class Vlink < Formula
    homepage 'http://sun.hasenbraten.de/vlink/'
    url 'https://todi.se/brew/vlink/0.18a/vlink.tar.gz'
    mirror 'http://phoenix.owl.de/tags/vlink0_18a.tar.gz'
    version '0.18a'
    sha256 '8d151cdd30a4feb575a364e68810c2bc300fe1a7c074dbbee6fd1175a6c5bfae'

  def install
    mkdir 'objects'

    inreplace 'Makefile' do |s|
      s.change_make_var! 'CC', "#{ENV.cc}"
      s.change_make_var! 'CFLAGS', "-fomit-frame-pointer -c #{ENV.cflags}"
      s.change_make_var! 'LD', "#{ENV.cc}"
      s.change_make_var! 'LDOPTS', "#{ENV.ldflags}"
    end

    system 'make'
    bin.install 'vlink'

  end
end