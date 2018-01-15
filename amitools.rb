require 'formula'

class Amitools < Formula
  homepage 'https://github.com/cnvogelg/amitools/'
  url 'http://todi.se/brew/amitools/0.1.0/amitools.zip'
  version '0.1.0'
  sha256 '8718cfca1f987d49cb2cdd6bf5f64b080efb4aaf127fc76436e6400254cab565'

  depends_on 'cython' => :build

  def install
    ENV.prepend_path 'PYTHONPATH', Formula['cython'].opt_libexec/'lib/python2.7/site-packages'

    inreplace [
      'bin/amitools',
      'amitools/fs/block/BootBlock.py',
      'amitools/util/DataDir.py'
    ], 'os.path.dirname(__file__)', 'os.path.dirname(os.path.realpath(__file__))'
    inreplace 'amitools/tools/vamos.py', 'os.path.dirname(amitools.__file__)', 'os.path.dirname(os.path.realpath(amitools.__file__))'

    system 'make'

    prefix.install ['amitools', 'musashi']
    doc.install Dir['doc/*']
    bin.install Dir['bin/*']
  end
end
