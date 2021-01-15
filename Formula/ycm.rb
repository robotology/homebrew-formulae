class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "https://robotology.github.io/ycm"

  stable do
    url "https://github.com/robotology/ycm/releases/download/v0.12.1/ycm-0.12.1-offline.tar.gz"
    sha256 "b1793f31e2b9c68c4a1d69a60fe4b8ae6d1d421c268e7a42bf9fd6c157ed7697"
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
