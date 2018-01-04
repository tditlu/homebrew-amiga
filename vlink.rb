require 'formula'

class Vlink < Formula
  homepage 'http://sun.hasenbraten.de/vlink/'
  url 'http://todi.se/brew/vlink/0.16b/vlink.tar.gz'
  version '0.16b'
  sha256 '7e55b2c36acee216c81580a4dd4a89f34e900df26e495b94cb568563cebf9741'

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
