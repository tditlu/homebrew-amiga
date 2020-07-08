class Vlink < Formula
    homepage 'http://sun.hasenbraten.de/vlink/'
    url 'http://sun.hasenbraten.de/vlink/release/vlink.tar.gz'
    mirror 'https://todi.se/brew/vlink/0.16e/vlink.tar.gz'
    version '0.16e'
    sha256 '2c5d0ac0aa4bcd6ce1821e3a71cf7cc7499b9e99fa068fd90a5892ccd25bb877'

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
