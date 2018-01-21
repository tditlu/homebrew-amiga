class Vbcc < Formula
  homepage 'http://www.compilers.de/vbcc.html'
  url 'http://todi.se/brew/vbcc/0.9f/vbcc.tar.gz'
  version '0.9f'
  sha256 '094a5cb6a0cf8fe5ef0fe5eced668e60dd708841049ce1b9fb33917b3e927325'

  resource "vbcc_target_m68k_amigaos" do
    url "http://todi.se/brew/vbcc/2017-05-18/vbcc_target_m68k-amigaos.lha", :using => :nounzip
    version '2017-05-18'
    sha256 'bce0a83f8de93d04141d1615634e930b6c7c67999952fb3504f5a2cb5f06b4d9'
  end

  depends_on 'lha' => :build

  def install

    mkdir 'bin'

    inreplace 'Makefile' do |s|
      s.change_make_var! 'CC', "#{ENV.cc} -std=c9x -O2 -fomit-frame-pointer -DHAVE_AOS4 #{ENV.cflags}"
      s.change_make_var! 'LDFLAGS', "-lm #{ENV.ldflags}"
      s.gsub! /bin\/dtgen \$\(TRGDIR\)\/machine\.dt \$\(TRGDIR\)\/dt\.h \$\(TRGDIR\)\/dt\.c/, 'printf \'y\ny\nsigned char\ny\nunsigned char\nn\ny\nsigned short\nn\ny\nunsigned short\nn\ny\nsigned int\nn\ny\nunsigned int\nn\ny\nsigned long long\nn\ny\nunsigned long long\nn\ny\nfloat\nn\ny\ndouble\n\' | bin/dtgen $(TRGDIR)/machine.dt $(TRGDIR)/dt.h $(TRGDIR)/dt.c'
    end

    targets = ['m68k', 'm68ks']

    targets.each do |target|
      system "make TARGET=#{target}"
    end

    rm_f Dir['bin/dtgen']
    bin.install Dir['bin/*']

    (prefix/'targets').mkpath

    resource("vbcc_target_m68k_amigaos").stage do
      system 'lha x vbcc_target_m68k-amigaos.lha'
      (prefix/'targets/m68k-amigaos').install Dir['vbcc_target_m68k-amigaos/targets/m68k-amigaos/*']
    end

  end

  def caveats; <<-EOS.undent
    You may need to add the following to your .bashrc:
      export VBCC=$(brew --prefix vbcc)
    EOS
  end

end
