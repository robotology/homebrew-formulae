class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "https://robotology.github.io/ycm"

  stable do
    url "https://github.com/robotology/ycm/releases/download/v0.13.0/ycm-0.13.0-offline.tar.gz"
    sha256 "c1313db45e0b8e7f27cf7c2d6cd0c34aea74c854b5aa9c26f7cee8f5defa32a8"
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
