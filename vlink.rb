require 'formula'

class Vlink < Formula
  homepage 'http://sun.hasenbraten.de/vlink/'
  url 'http://todi.se/brew/vlink/0.14d/vlink.tar.gz'
  version '0.14d'
  sha1 '1e5065ce14f494772c3090db7eda6c30972bc37d'

  def install
    mkdir 'object'

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

