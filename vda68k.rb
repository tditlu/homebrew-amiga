class Vda68k < Formula
    homepage 'http://sun.hasenbraten.de/~frank/projects/'
    url 'https://todi.se/brew/vda68k/1.5/vdam68k.tar.gz'
    mirror 'http://sun.hasenbraten.de/~frank/projects/download/vdam68k.tar.gz'
    version '1.5'
    sha256 '0d17cc250f6ad199460c91f9ed4751123d75b935fc9a9aa7972c80fb47a565e9'
  
    def install
      Dir.chdir 'M68k' do
        inreplace 'Makefile' do |s|
          s.change_make_var! 'CC', "#{ENV.cc} -std=c9x"
        end
  
        system 'make'
        bin.install 'vda68k'
      end
    end
  end
  
  