class Vlink < Formula
    homepage 'http://sun.hasenbraten.de/vlink/'
    url 'https://todi.se/brew/vlink/0.17a/vlink.tar.gz'
    mirror 'http://phoenix.owl.de/tags/vlink0_17a.tar.gz'
    version '0.17a'
    sha256 'f6754913d47bc97cf4771cc0aa7c51de368a04894be35b8dc5e4beac527f5b82'

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