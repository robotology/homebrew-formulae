# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "http://robotology.github.io/ycm"
  
  stable do
    url "https://github.com/robotology/ycm/archive/v0.4.0.tar.gz"
    sha256 "5c0baff55507361bd385ca6447a41b4d147fcdc129e26a4ed8616be2c633a1b2"
  end
  
  head do
    url "https://github.com/robotology/ycm.git", :branch => "master"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
  end
end
