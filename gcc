class GccAmiga < Formula
  homepage "https://github.com/BartmanAbyss/gcc/tree/amiga-8_3_0"
  url "http://todi.se/brew/gcc_amiga/8.3.0/gcc-amiga-8_3_0.zip"
  sha256 "9b22c6683f4ca3045c0f3cbb7cf3a7ef137ecf64fa90896d2788b2bff9d37b60"

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",

                          "--target=m68k-amiga-elf",
                          "--disable-nls",
                          "--enable-languages=c",
                          "--enable-lto",
                          "--disable-libssp",
                          "--disable-gcov",
                          "--disable-multilib",
                          "--disable-threads",
                          "--with-cpu=68000",
                          "--disable-libsanitizer",
                          "--disable-libada",
                          "--disable-libgomp",
                          "--disable-libvtv",
                          "--disable-nls",
                          "--disable-clocale",
                          "--prefix=#{prefix}"
    system "make", "all-gcc", "-j6"
    system "make", "install-gcc"
  end
end
