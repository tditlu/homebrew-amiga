class Vlink < Formula
  homepage 'http://sun.hasenbraten.de/vlink/'
  url 'http://server.owl.de/~frank/tags/vlink0_16c.tar.gz'
  mirror 'http://todi.se/brew/vlink/0.16c/vlink.tar.gz'
  version '0.16c'
  sha256 '35ef34fee6b838b449a65f1447224c4e1dd96a310377ccc346a9ffa7464d167a'

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
