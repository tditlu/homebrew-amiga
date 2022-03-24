class Vbcc < Formula
  homepage 'http://www.compilers.de/vbcc.html'
  url 'https://todi.se/brew/vbcc/0.9hp2/vbcc.tar.gz'
  mirror 'http://phoenix.owl.de/tags/vbcc0_9hP2.tar.gzz'
  version '0.9hp2'
  sha256 '26bc67a217232f32d264eb77d79682d3da40aa0e3ef5ed10e46ac019b2913109'

  resource 'vbcc_target_m68k_amigaos' do
    url 'https://todi.se/brew/vbcc/2022-03-23/vbcc_target_m68k-amigaos.lha', :using => :nounzip
    mirror 'http://phoenix.owl.de/vbcc/2022-03-23/vbcc_target_m68k-amigaos.lha'
    version '2022-03-23'
    sha256 '64640fbdfa324ca3eddebf4b6453dcff663234758b08f646d217b99e34f68d02'
  end

  resource 'vbcc_target_m68k_kick13' do
    url 'https://todi.se/brew/vbcc/2022-03-23/vbcc_target_m68k-kick13.lha', :using => :nounzip
    mirror 'http://phoenix.owl.de/vbcc/2022-03-23/vbcc_target_m68k-kick13.lha'
    version '2022-03-23'
    sha256 '513a8db2188ebf6fcb1dd7527b9d7b437970933b1137e1d777abe61985a1fbd4'
  end

  resource 'vbcc_unix_config' do
    url 'https://todi.se/brew/vbcc/2022-03-23/vbcc_unix_config.tar.gz'
    mirror 'http://phoenix.owl.de/vbcc/2022-03-23/vbcc_unix_config.tar.gz'
    version '2022-03-23'
    sha256 '9061fc9d2a7fc7817f0aa3a135c1bb04b542fa22eaf2879def4e8171b869f885'
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
