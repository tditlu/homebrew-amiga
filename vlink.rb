class Vlink < Formula
  homepage 'http://sun.hasenbraten.de/vlink/'
  url 'http://todi.se/brew/vlink/0.16b/vlink.tar.gz'
  version '0.16b'
  sha256 'a5b604040f4bc13eccf0e92d77b849a37c5dcef920ed03a9f31e7e5fa5b9f34a'

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
