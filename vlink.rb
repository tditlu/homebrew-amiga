class Vlink < Formula
    homepage 'http://sun.hasenbraten.de/vlink/'
    url 'https://todi.se/brew/vlink/0.16g/vlink.tar.gz'
    mirror 'https://server.owl.de/~frank/tags/vlink0_16g.tar.gz'
    version '0.16g'
    sha256 '4792740bda3850e82d22bd87d54a918c81571eff0fc447c52b94b2af38e90ba4'

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