require 'formula'

class Vbcc < Formula
  homepage 'http://www.compilers.de/vbcc.html'
  url 'http://todi.se/brew/vbcc/0.9e/vbcc.tar.gz'
  version '0.9e'
  sha256 'bbc6fc1face799af3bfa07f5920c48e0729c2ad3f25af7e6611b51dff7c2d4ef'

  resource "vbcc_target_cf_atari" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_cf-atari.lha", :using => :nounzip
    version '2014-12-30'
    sha256 '5f125d4bace0e9c4d75dcc38b5824b7ab39b6c514d224c232152f9bb2b241e64'
  end

  resource "vbcc_target_m68k_amigaos" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_m68k-amigaos.lha", :using => :nounzip
    version '2014-12-30'
    sha256 '07003adc685fdbd981d62a90118683dbd36ee368991b12a22c809d25de843168'
  end

  resource "vbcc_target_m68k_atari" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_m68k-atari.lha", :using => :nounzip
    version '2014-12-30'
    sha256 '98f3d87777f6068009830320acc97e3c509bd067522f2d03869d7dd3409aadec'
  end

  resource "vbcc_target_ppc_amigaos" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_ppc-amigaos.lha", :using => :nounzip
    version '2014-12-30'
    sha256 '5690805ffcfa0835af50d31715ae5e60103189ae13168ffa6d025a26173f92d2'
  end

  resource "vbcc_target_ppc_morphos" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_ppc-morphos.lha", :using => :nounzip
    version '2014-12-30'
    sha256 '9653aea1d8de809283ab8f2b0e40a3d45708a5da6a5cd07e192a3a06a2fae4a4'
  end

  resource "vbcc_target_ppc_powerup" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_ppc-powerup.lha", :using => :nounzip
    version '2014-12-30'
    sha256 '8efe1d3d41497b59580174d1a879874af7d5bc7f179f3b9435d851dcc42ce71b'
  end

  resource "vbcc_target_ppc_warpos" do
    url "http://todi.se/brew/vbcc/2014-12-30/vbcc_target_ppc-warpos.lha", :using => :nounzip
    version '2014-12-30'
    sha256 'bcefc389a26977a3809b41678403c4a3bc6ae95e60ca8c8f613725ce2a0c0ccb'
  end

  depends_on 'lha' => :build

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
--- a/datatypes/dtgen.c 2015-06-25 10:02:46.000000000 +0200
+++ b/datatypes/dtgen.c 2015-06-25 10:03:21.000000000 +0200
@@ -130,23 +130,14 @@
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
-  if(!*in) strcpy(in,def);
+  strcpy(in,def);
   return in;
 }
