class Vbcc < Formula
  homepage 'http://www.compilers.de/vbcc.html'
  url 'https://server.owl.de/~frank/tags/vbcc0_9g.tar.gz'
  mirror 'https://todi.se/brew/vbcc/0.9g/vbcc.tar.gz'
  version '0.9g'
  sha256 '25d347fbe9600b41e4f022bcea970040618511b36c1b2041bd0281e70626b555'

  resource 'vbcc_target_m68k_amigaos' do
    url 'https://server.owl.de/~frank/vbcc/2019-10-04/vbcc_target_m68k-amigaos.lha', :using => :nounzip
    mirror 'https://todi.se/brew/vbcc/2019-10-04/vbcc_target_m68k-amigaos.lha'
    version '2019-10-04'
    sha256 'b97b43546f25580deeda7b5376009daf9cde57f608ffb9e6afbd2cba28025865'
  end
  
  resource 'vbcc_target_m68k_kick13' do
    url 'https://server.owl.de/~frank/vbcc/2019-10-04/vbcc_target_m68k-kick13.lha', :using => :nounzip
    mirror 'https://todi.se/brew/vbcc/2019-10-04/vbcc_target_m68k-kick13.lha'
    version '2019-10-04'
    sha256 '4b4747812c3c3a46ea270278a4ed164ccbeb4e153e6cbc5373b7adc67351c3a6'
  end
  
  resource 'vbcc_unix_config' do
    url 'https://server.owl.de/~frank/vbcc/2019-10-04/vbcc_unix_config.tar.gz'
    mirror 'https://todi.se/brew/vbcc/2019-10-04/vbcc_unix_config.tar.gz'
    version '2019-10-04'
    sha256 'd8563016adefd3ef84b7a1e33e6a552feb978c16b5f63ec917861d72a531574e'
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
