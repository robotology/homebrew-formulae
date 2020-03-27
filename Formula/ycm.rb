class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "https://robotology.github.io/ycm"

  stable do
    url "https://github.com/robotology/ycm/releases/download/v0.11.1/ycm-0.11.1-offline.tar.gz"
    sha256 "f7f3c2641daaade3237ff6c0a1a6c03a2e231841a86b9739acb71dd0de1a324b"
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
