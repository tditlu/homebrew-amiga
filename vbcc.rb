require 'formula'

class Vbcc < Formula
  homepage 'http://www.compilers.de/vbcc.html'
  url 'http://todi.se/brew/vbcc/0.9d/vbcc.tar.gz'
  version '0.9d'
  sha1 '325d043b6224c584a9c29abcfebc236f5b774607'

  resource "vbcc_target_cf_atari" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_cf-atari.lha", :using => :nounzip
    version '2014-12-30'
    sha1 '3444ba7c29476f45fc9f3793db03e1fb1d1cd546'
  end

  resource "vbcc_target_m68k_amigaos" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_m68k-amigaos.lha", :using => :nounzip
    version '2014-12-30'
    sha1 'f5942c7c8b57d9d54b0ba5bea534453c92e03205'
  end

  resource "vbcc_target_m68k_atari" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_m68k-atari.lha", :using => :nounzip
    version '2014-12-30'
    sha1 '5613329750f456c753b465f8f8be032bdcd4aed1'
  end

  resource "vbcc_target_ppc_amigaos" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_ppc-amigaos.lha", :using => :nounzip
    version '2014-12-30'
    sha1 'b3c8406a92cab47b6a6c9ab1cb8ca579544e0c40'
  end

  resource "vbcc_target_ppc_morphos" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_ppc-morphos.lha", :using => :nounzip
    version '2014-12-30'
    sha1 '3162b761e990c43817e7c12f2c70609122fd4264'
  end

  resource "vbcc_target_ppc_powerup" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_ppc-powerup.lha", :using => :nounzip
    version '2014-12-30'
    sha1 '83131805cd7bf3d42cd452f0ecee007fd1abe243'
  end

  resource "vbcc_target_ppc_warpos" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_ppc-warpos.lha", :using => :nounzip
    version '2014-12-30'
    sha1 '958e1cd8b412a60fc23b02c3589f22d48891f88a'
  end

  depends_on 'lha' => :build

  # Adding absolute path to vc, if VBCC is not defined
  # Remove interactive configuration, using default
  def patches
    DATA
  end

  def install

    mkdir 'bin'

    inreplace 'Makefile' do |s|
      s.change_make_var! 'CC', "#{ENV.cc} -std=c9x #{ENV.cflags}"
      s.change_make_var! 'LDFLAGS', "-lm #{ENV.ldflags}"
    end

    targets = ['alpha', 'c16x', 'generic', 'hc12', 'i386', 'm68k', 'm68ks', 'ppc', 'z']

    targets.each do |target|
      system "make TARGET=#{target}"
    end

    rm_f Dir['bin/dtgen']
    bin.install Dir['bin/*']


    (prefix/'targets').mkpath

    resource("vbcc_target_cf_atari").stage do
      system 'lha x vbcc_target_cf-atari.lha'
      (prefix/'targets/cf-atari').install Dir['vbcc_target_cf-atari/targets/cf-atari/*']
    end

    resource("vbcc_target_m68k_amigaos").stage do
      system 'lha x vbcc_target_m68k-amigaos.lha'
      (prefix/'targets/m68k-amigaos').install Dir['vbcc_target_m68k-amigaos/targets/m68k-amigaos/*']
    end

    resource("vbcc_target_m68k_atari").stage do
      system 'lha x vbcc_target_m68k-atari.lha'
      (prefix/'targets/m68k-atari').install Dir['vbcc_target_m68k-atari/targets/m68k-atari/*']
    end

    resource("vbcc_target_ppc_amigaos").stage do
      system 'lha x vbcc_target_ppc-amigaos.lha'
      (prefix/'targets/ppc-amigaos').install Dir['vbcc_target_ppc-amigaos/targets/ppc-amigaos/*']
    end

    resource("vbcc_target_ppc_morphos").stage do
      system 'lha x vbcc_target_ppc-morphos.lha'
      (prefix/'targets/ppc-morphos').install Dir['vbcc_target_ppc-morphos/targets/ppc-morphos/*']
    end

    resource("vbcc_target_ppc_powerup").stage do
      system 'lha x vbcc_target_ppc-powerup.lha'
      (prefix/'targets/ppc-powerup').install Dir['vbcc_target_ppc-powerup/targets/ppc-powerup/*']
    end

    resource("vbcc_target_ppc_warpos").stage do
      system 'lha x vbcc_target_ppc-warpos.lha'
      (prefix/'targets/ppc-warpos').install Dir['vbcc_target_ppc-warpos/targets/ppc-warpos/*']
    end

  end

  def caveats; <<-EOS.undent
    You may need to add the following to your .bashrc:
      export VBCC=$(brew --prefix vbcc)
    EOS
  end

end

__END__
--- a/datatypes/dtgen.c 2010-09-05 19:10:00.000000000 +0100
+++ b/datatypes/dtgen.c 2013-01-12 19:26:00.000000000 +0100
@@ -130,22 +130,13 @@
 int askyn(char *def)
 {
   char in[8];
-  do{
-    printf("Type y or n [%s]: ",def);
-    fflush(stdout);
-    fgets(in,sizeof(in),stdin);
-    if(*in=='\n') strcpy(in,def);
-  }while(*in!='y'&&*in!='n');
+  strcpy(in,def);
   return *in=='y';
 }

 char *asktype(char *def)
 {
   char *in=mymalloc(128);
-  printf("Enter that type[%s]: ",def);
-  fflush(stdout);
-  fgets(in,127,stdin);
-  if(in[strlen(in)-1]=='\n') in[strlen(in)-1]=0;
   if(!*in) strcpy(in,def);
   return in;
 }

