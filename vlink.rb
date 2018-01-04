require 'formula'

class Vlink < Formula
  homepage 'http://sun.hasenbraten.de/vlink/'
  url 'http://todi.se/brew/vlink/0.16b/vlink.tar.gz'
  version '0.16b'
  sha256 '760d355864ce6f42581530cef39f9cc8375f5a72eb59934e859040523cc87311'

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
