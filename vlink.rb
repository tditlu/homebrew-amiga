class Vlink < Formula
  homepage 'http://sun.hasenbraten.de/vlink/'
  url 'https://server.owl.de/~frank/tags/vlink0_16c.tar.gz'
  mirror 'https://todi.se/brew/vlink/0.16c/vlink.tar.gz'
  version '0.16c'
  sha256 '558267887bce7ac5b49a0dd3d8ac0a5251c0b1ae3ed8c9439ad5b876994c413d'

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
