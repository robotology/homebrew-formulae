class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "https://robotology.github.io/ycm"

  stable do
    url "https://github.com/robotology/ycm/releases/download/v0.10.2/ycm-0.10.2-offline.tar.gz"
    sha256 "25392d9bcf31def724f839b9347c958b92998743f84e63adc8843642439e988a"
  end

  bottle do
    root_url "https://github.com/robotology/ycm/releases/download/v0.10.2"
    cellar :any_skip_relocation
    sha256 "dbd241225a885d812781b0cf1ea6c830b7f596ce4fac6309132e659c92cf9003" => :mojave
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
