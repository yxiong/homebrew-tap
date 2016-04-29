require 'formula'

class BoostNumpy < Formula
  homepage 'https://github.com/ndarray/'
  url 'git@github.com:asford/Boost.NumPy.git', :using => :git, :branch => 'master'
  version "0.0.1"

  depends_on 'scons' => :build

  depends_on 'boost' => 'with-python'
  depends_on 'numpy' => :python

  def install
    args = [
      "--with-boost-include=#{HOMEBREW_PREFIX}/include",
      "--with-boost-lib=#{HOMEBREW_PREFIX}/lib",
      "--prefix=#{prefix}"
    ]

    system "scons", *args
    system "scons", "install", *args
  end
end
