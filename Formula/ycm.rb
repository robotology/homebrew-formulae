class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "https://robotology.github.io/ycm"

  stable do
    url "https://github.com/robotology/ycm/releases/download/v0.11.3/ycm-0.11.3-offline.tar.gz"
    sha256 "5fd381298200f209befddc8c6ab9857a5716ce1b172cbb876281fc2dcd4977a6"
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
