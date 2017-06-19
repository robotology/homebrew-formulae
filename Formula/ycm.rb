class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "https://robotology.github.io/ycm"

  stable do
    url "https://github.com/robotology/ycm/archive/v0.4.0.tar.gz"
    sha256 "5c0baff55507361bd385ca6447a41b4d147fcdc129e26a4ed8616be2c633a1b2"
  end

  bottle do
    root_url "https://github.com/robotology/ycm/releases/download/v0.4.0"
    cellar :any_skip_relocation
    sha256 "5c18bd906c4b62991781844bc34c3c5a86e04d5fb5f37e3df6b80a4a30a0bae6" => :sierra
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
