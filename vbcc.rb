class Vbcc < Formula
  homepage 'http://www.compilers.de/vbcc.html'
  url 'https://todi.se/brew/vbcc/0.9hp3/vbcc.tar.gz'
  version '0.9hp3'
  sha256 '4946f3e2a5dcf06f5f1993c17eec870529998277757dbe5c76d4039bd3e150a1'

  resource 'vbcc_target_m68k_amigaos' do
    url 'https://todi.se/brew/vbcc/2022-05-22/vbcc_target_m68k-amigaos.lha', :using => :nounzip
    mirror 'http://phoenix.owl.de/vbcc/2022-05-22/vbcc_target_m68k-amigaos.lha'
    version '2022-05-22'
    sha256 'ec734d7115359cdb5d1c70349284ecbd5712ef47e8bc28d4150117c6f8c73289'
  end

  resource 'vbcc_target_m68k_kick13' do
    url 'https://todi.se/brew/vbcc/2022-05-22/vbcc_target_m68k-kick13.lha', :using => :nounzip
    mirror 'http://phoenix.owl.de/vbcc/2022-05-22/vbcc_target_m68k-kick13.lha'
    version '2022-05-22'
    sha256 '8815948604eb50ec8b82d4fd2c9d673f5ec59a6623778edfcb29a7df608ea711'
  end

  resource 'vbcc_unix_config' do
    url 'https://todi.se/brew/vbcc/2022-05-22/vbcc_unix_config.tar.gz'
    mirror 'http://phoenix.owl.de/vbcc/2022-05-22/vbcc_unix_config.tar.gz'
    version '2022-05-22'
    sha256 'c643a095439aaf0cbcf7521920c0ff5d1cb07a4fc6fe8cc59e69ae1dbb329497'
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
