class MiniproAllowSkipId < Formula
  desc "Open controller for the MiniPRO TL866xx series of chip programmers"
  homepage "https://gitlab.com/DavidGriffith/minipro/"
  url "https://gitlab.com/DavidGriffith/minipro/-/archive/0.5/minipro-0.5.tar.gz"
  sha256 "80ce742675f93fd4e2a30ab31a7e4f3fcfed8d56aa7cf9b3938046268004dae7"
  license "GPL-3.0-or-later"

  depends_on "pkg-config" => :build
  depends_on "libusb"
  depends_on "srecord"

  patch :DATA

  def install
    system "make", "CC=#{ENV.cc}", "PREFIX=#{prefix}"
    system "make", "PREFIX=#{prefix}", "MANDIR=#{share}", "install"
  end

  test do
    output_minipro = shell_output("#{bin}/minipro 2>&1", 1)
    assert_match "minipro version #{version}", output_minipro
    output_miniprohex = shell_output("#{bin}/miniprohex 2>&1", 1)
    assert_match "miniprohex by Al Williams", output_miniprohex

    output_minipro_read_nonexistent = shell_output("#{bin}/minipro -p \"ST21C325@DIP7\" -b 2>&1", 1)
    if output_minipro_read_nonexistent.exclude?("Device ST21C325@DIP7 not found!") &&
       output_minipro_read_nonexistent.exclude?("Error opening device") &&
       output_minipro_read_nonexistent.exclude?("No programmer found.")
      raise "Error validating minipro device database."
    end
  end
end

__END__
diff --git a/main.c b/main.c
index 9d61b52..2db0e2a 100644
--- a/main.c
+++ b/main.c
@@ -2296,15 +2296,6 @@ int action_verify(minipro_handle_t *handle) {
       print_help_and_exit(argv[0]);
     }
 
-    // don't permit skipping the ID read in write/erase-mode or ID only mode
-    if ((cmdopts.action == WRITE || cmdopts.action == ERASE ||
-         cmdopts.idcheck_only) &&
-        cmdopts.idcheck_skip) {
-      fprintf(stderr,
-              "Skipping the ID check is not permitted for this action.\n");
-      print_help_and_exit(argv[0]);
-    }
-
     // Exit if no action is supplied
     if (cmdopts.action == NO_ACTION && !cmdopts.idcheck_only &&
         !cmdopts.pincheck) {
