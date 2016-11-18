require 'formula'

class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'http://todi.se/brew/vasm/1.7g/vasm.tar.gz'
  version '1.7g'
  sha256 '9cfca33c348fe10419cb2ef59a7ff25c262cd6cf1d353bb51d4468f1f1535c55'

  def install
    system "mkdir -p obj"

    inreplace 'Makefile' do |s|
      s.change_make_var! 'COPTS', "-c -O2 -DOUTAOUT -DOUTBIN -DOUTELF -DOUTHUNK -DOUTSREC -DOUTTOS -DOUTVOBJ #{ENV.cflags}"
      s.change_make_var! 'LDFLAGS', "-lm #{ENV.ldflags}"
    end


    syntaxes = ['mot', 'oldstyle', 'std']
    cpus = ['6502', 'arm', 'c16x', 'm68k', 'ppc', 'x86', 'z80']

    syntaxes.each do |syntax|
      cpus.each do |cpu|

       if (!(cpu == 'c16x' && syntax == 'oldstyle') && !(cpu == 'm68k' && syntax == 'oldstyle'))
          system "make CPU=#{cpu} SYNTAX=#{syntax} vasm#{cpu}_#{syntax}"
          bin.install "vasm#{cpu}_#{syntax}"
        end
      end
    end


    system 'make vobjdump'
    bin.install 'vobjdump'

  end

end
