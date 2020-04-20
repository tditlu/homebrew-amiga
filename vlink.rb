class Vlink < Formula
    homepage 'http://sun.hasenbraten.de/vlink/'
    url 'http://sun.hasenbraten.de/vlink/release/vlink.tar.gz'
    mirror 'https://todi.se/brew/vlink/0.16d/vlink.tar.gz'
    version '0.16d'
    sha256 '40ac51ab5fe27934800cb60687932d9f29a54e9f317399c643b3538ae8ff005f'

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
