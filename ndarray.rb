require 'formula'

class Ndarray < Formula
  homepage 'https://github.com/ndarray/'
  url 'https://github.com/ndarray/ndarray.git', :using => :git, :branch => 'master'
  version "0.0.1"

  depends_on 'scons' => :build

  depends_on 'eigen'

  depends_on 'boost' => 'with-python'
  depends_on 'numpy' => :python

  def install
    args = [
      "--with-eigen-include=" + %x[pkg-config eigen3 --cflags-only-I][2..-1].strip,
      "--with-boost-include=#{HOMEBREW_PREFIX}/include",
      "--with-boost-lib=#{HOMEBREW_PREFIX}/lib",
      "--prefix=#{prefix}"
    ]

    system "scons", "include", "m4", "Boost.NumPy", *args

    ## Temporary workaround for test ordering
    system "scons", "tests/.ndarray.cc.succeeded", *args
    system "scons", "tests", *args
    system "scons", *args
    system "scons", "install", *args
  end
end
