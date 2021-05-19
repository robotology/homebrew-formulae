class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "https://robotology.github.io/ycm"

  stable do
    url "https://github.com/robotology/ycm/releases/download/v0.12.2/ycm-0.12.2-offline.tar.gz"
    sha256 "bd08d9c8d5c80bb9d3c16d405b415748c0525b352d37176071db5fb2197ebf6e"
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
