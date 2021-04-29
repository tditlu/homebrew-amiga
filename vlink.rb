class Vlink < Formula
    homepage 'http://sun.hasenbraten.de/vlink/'
    url 'https://todi.se/brew/vlink/0.16h/vlink.tar.gz'
    version '0.16h'
    sha256 '8e6113bdf3394343cbcb9280bff52aabb047ae751d1aed87860aecff6c10cd59'

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
