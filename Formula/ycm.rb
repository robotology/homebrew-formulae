class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "https://robotology.github.io/ycm"

  stable do
    url "https://github.com/robotology/ycm/archive/v0.10.4.tar.gz"
    sha256 "d1a6c7f2cf71f5bacbc30ec01c46692db3e5c62e558a87a15e329911c78a4c2e"
  end

  bottle do
    root_url "https://github.com/robotology/ycm/releases/download/v0.10.4"
    cellar :any_skip_relocation
    sha256 "302f7194544812eff788478b24840ef94861157d5a68652f0531555398f43cac" => :mojave
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
