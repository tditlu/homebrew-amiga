class Vbcc < Formula
  homepage 'http://www.compilers.de/vbcc.html'
  url 'https://todi.se/brew/vbcc/0.9h/vbcc.tar.gz'
  mirror 'http://phoenix.owl.de/tags/vbcc0_9h.tar.gz'
  version '0.9h'
  sha256 '92964268d51fe823fdb3b6ff5706273b14ed13fdbab1e6a8cfa9277597f7a93a'

  resource 'vbcc_target_m68k_amigaos' do
    url 'https://todi.se/brew/vbcc/2022-02-28/vbcc_target_m68k-amigaos.lha', :using => :nounzip
    mirror 'http://phoenix.owl.de/vbcc/2022-02-28/vbcc_target_m68k-amigaos.lha'
    version '2022-02-28'
    sha256 '28e44ce3d2b863b0da4752d96e2db2c9c6883a69c6a3503606269676091cefc0'
  end

  resource 'vbcc_target_m68k_kick13' do
    url 'https://todi.se/brew/vbcc/2022-02-28/vbcc_target_m68k-kick13.lha', :using => :nounzip
    mirror 'http://phoenix.owl.de/vbcc/2022-02-28/vbcc_target_m68k-kick13.lha'
    version '2022-02-28'
    sha256 'c17ff26e0bb011adb9d40d0704941b70f7997e8dd43ad36cb54e2b13ad0a1d34'
  end

  resource 'vbcc_unix_config' do
    url 'https://todi.se/brew/vbcc/2022-02-28/vbcc_unix_config.tar.gz'
    mirror 'http://phoenix.owl.de/vbcc/2022-02-28/vbcc_unix_config.tar.gz'
    version '2022-02-28'
    sha256 'bfdc80bfa04871a9fff908ed65ccc6da41949f737b04ece9abcf52b771a15dbc'
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

    resource('vbcc_target_m68k_amigaos').stage do
      system 'lha x vbcc_target_m68k-amigaos.lha'
      (prefix/'targets/m68k-amigaos').install Dir['vbcc_target_m68k-amigaos/targets/m68k-amigaos/*']
    end

    resource('vbcc_target_m68k_kick13').stage do
      system 'lha x vbcc_target_m68k-kick13.lha'
      (prefix/'targets/m68k-kick13').install Dir['vbcc_target_m68k-kick13/targets/m68k-kick13/*']
    end

    (prefix/'config').mkpath

    resource('vbcc_unix_config').stage do
      (prefix/'config').install Dir['{aos68k,aos68km,aos68kr,kick13,kick13m,kick13r}']
    end

  end

  def caveats; <<~EOS
    You may need to add the following to your .bashrc:
      export VBCC=$(brew --prefix vbcc)
    EOS
  end

end
