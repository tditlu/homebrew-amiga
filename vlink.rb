require 'formula'

class Vlink < Formula
  homepage 'http://sun.hasenbraten.de/vlink/'
  url 'http://todi.se/brew/vlink/0.15c/vlink.tar.gz'
  version '0.15c'
  sha256 '94ed62777f31fef972fe509e7d9f544b78fcf43b71b2cc9f794ec26d13fd8e77'

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
