class Vbcc < Formula
  homepage 'http://www.compilers.de/vbcc.html'
  url 'http://todi.se/brew/vbcc/0.91f/vbcc.tar.gz'
  version '0.91f'
  sha256 '63a652c07b001a138566a84dd6059403cac325c597b646acb41f70a9d0ea4097'

  resource "vbcc_target_m68k_amigaos" do
    url "http://todi.se/brew/vbcc/2018-02-07/vbcc_target_m68k-amigaos.lha", :using => :nounzip
    version '2017-02-07'
    sha256 '515e471b007b3cfe2ba2d83445d08c1d3696b48e93f106d070f7ee4eb72b0f42'
  end

  resource "vbcc_target_m68k_kick13" do
    url "http://todi.se/brew/vbcc/2018-02-07/vbcc_target_m68k-kick13.lha", :using => :nounzip
    version '2017-02-07'
    sha256 '68b73adb66dbb59302c9cb06f0a7fb91171b0b967a974d2d220916ac65926573'
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

    resource("vbcc_target_m68k_kick13").stage do
      system 'lha x vbcc_target_m68k-kick13.lha'
      (prefix/'targets/m68k-kick13').install Dir['vbcc_target_m68k-kick13/targets/m68k-kick13/*']
    end

  end

  def caveats; <<-EOS.undent
    You may need to add the following to your .bashrc:
      export VBCC=$(brew --prefix vbcc)
    EOS
  end

end
