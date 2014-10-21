require 'formula'

class Vbcc < Formula
  homepage 'http://www.compilers.de/vbcc.html'
  url 'http://todi.se/brew/vbcc/0.9b/vbcc.tar.gz'
  version '0.9b'
  sha1 'f62c34d14d378142d3c5d94517965b5ec41ca858'

  resource "vbcc_target_m68k_amigaos" do
    url "http://todi.se/brew/vbcc/2011-08-06/vbcc_target_m68k-amigaos.lha", :using => :nounzip
    version '2011-08-06'
    sha1 'f0a7ac5ffb670a2deb5213867fd75d516774c459'
  end

  resource "vbcc_target_m68k_atari" do
    url "http://todi.se/brew/vbcc/2011-08-06/vbcc_target_m68k-atari.lha", :using => :nounzip
    version '2011-08-06'
    sha1 'ee76920b2639057343ef322b95937c5493ef8dc7'
  end

  resource "vbcc_target_cf_atari" do
    url "http://todi.se/brew/vbcc/2011-08-06/vbcc_target_cf-atari.lha", :using => :nounzip
    version '2011-08-06'
    sha1 '3caa2823466940dab5ce57cbdd914c225dc19915'
  end

  resource "vbcc_target_ppc_morphos" do
    url "http://todi.se/brew/vbcc/2011-08-06/vbcc_target_ppc-morphos.lha", :using => :nounzip
    version '2011-08-06'
    sha1 '21bc3366d993d565478fd9d6413fe426afa6c049'
  end

  resource "vbcc_target_ppc_powerup" do
    url "http://todi.se/brew/vbcc/2011-08-06/vbcc_target_ppc-powerup.lha", :using => :nounzip
    version '2011-08-06'
    sha1 '603588b35594cf63cbb0fd8616c530aad765c880'
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

    targets = ['alpha', 'arm', 'c16x', 'generic', 'hc12', 'i386', 'm68k', 'm68ks', 'ppc', 'z']

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

    resource("vbcc_target_m68k_atari").stage do
      system 'lha x vbcc_target_m68k-atari.lha'
      (prefix/'targets/m68k-atari').install Dir['vbcc_target_m68k-atari/targets/m68k-atari/*']
    end

    resource("vbcc_target_cf_atari").stage do
      system 'lha x vbcc_target_cf-atari.lha'
      (prefix/'targets/cf-atari').install Dir['vbcc_target_cf-atari/targets/cf-atari/*']
    end

    resource("vbcc_target_ppc_morphos").stage do
      system 'lha x vbcc_target_ppc-morphos.lha'
      (prefix/'targets/ppc-morphos').install Dir['vbcc_target_ppc-morphos/targets/ppc-morphos/*']
    end

    resource("vbcc_target_ppc_powerup").stage do
      system 'lha x vbcc_target_ppc-powerup.lha'
      (prefix/'targets/ppc-powerup').install Dir['vbcc_target_ppc-powerup/targets/ppc-powerup/*']
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

