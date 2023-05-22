class Salvador < Formula
  homepage 'https://github.com/emmanuel-marty/salvador'
  url 'https://github.com/emmanuel-marty/salvador/archive/refs/tags/1.4.2.tar.gz'
  mirror 'https://todi.se/brew/salvador/1.4.2/salvador.tar.gz'
  version '1.4.2'
  sha256 'af163cfaa748c845ba0b5936668f9f8755d8fa6f7d38b5f0f2bdce1b6ae5f0b5'

  def install
    mkdir 'obj'

    inreplace 'Makefile' do |s|
      s.change_make_var! 'CC', "#{ENV.cc}"
    end

    system 'make'
    bin.install 'salvador'

  end
end
