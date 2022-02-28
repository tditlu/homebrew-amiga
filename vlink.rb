class Vlink < Formula
  homepage 'http://sun.hasenbraten.de/vlink/'
  url 'https://todi.se/brew/vlink/0.17/vlink.tar.gz'
  mirror 'http://phoenix.owl.de/tags/vlink0_17.tar.gz'
  version '0.17'
  sha256 'e9596a0160149a423ca1c31fcb830f446b8deaa33d72c379555fa7097012a851'

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
