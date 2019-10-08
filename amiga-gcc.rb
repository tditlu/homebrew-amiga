class AmigaGcc < Formula
    homepage "https://github.com/BartmanAbyss/gcc/tree/amiga-8_3_0"
    url "http:///todi.se/brew/amiga_gcc/amiga-gcc-8.3.0.zip"
    sha256 "becefa49ff38f0ee4aa87a3b573f3df85d1fded553c65cf4c64b28fb1c06b04e"

    depends_on "gmp"
    depends_on "mpfr"
    depends_on "libmpc"

    def install
      mkdir_p "build-binutils-2.32"
      cd "build-binutils-2.32" do
        system "../binutils-2.32/configure", "--disable-nls",
                                             "--disable-libssp",
                                             "--disable-gcov",
                                             "--disable-multilib",
                                             "--disable-threads",
                                             "--disable-libsanitizer",
                                             "--disable-libada",
                                             "--disable-libgomp",
                                             "--disable-libvtv",
                                             "--disable-nls",
                                             "--disable-clocale",
                                             "--disable-gdb",
                                             "--disable-werror",
                                             "--enable-languages=c",
                                             "--enable-lto",
                                             "--target=m68k-amiga-elf",
                                             "--with-cpu=68000",
                                             "--with-headers=../sys-include",
                                             "--prefix=#{prefix}"
        system "make", "-j6"
        system "make", "install"
      end

      mkdir_p "build-gcc-8.3.0"
      cd "build-gcc-8.3.0" do
        system "../gcc-8.3.0/configure", "--disable-nls",
                                         "--disable-libssp",
                                         "--disable-gcov",
                                         "--disable-multilib",
                                         "--disable-threads",
                                         "--disable-libsanitizer",
                                         "--disable-libada",
                                         "--disable-libgomp",
                                         "--disable-libvtv",
                                         "--disable-nls",
                                         "--disable-clocale",
                                         "--disable-gdb",
                                         "--disable-werror",
                                         "--enable-languages=c",
                                         "--enable-lto",
                                         "--target=m68k-amiga-elf",
                                         "--with-cpu=68000",
                                         "--with-headers=../sys-include",
                                         "--prefix=#{prefix}"
        system "make", "all-gcc", "-j6"
        system "make", "install-gcc"
      end

      cd "elf2hunk-0.7.0" do
        system ENV.cc, "-o#{prefix}/bin/elf2hunk", "-DDEBUG=0", "elf2hunk.c"
      end
    end
  end
