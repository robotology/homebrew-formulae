class Ycm < Formula
  desc "Extra CMake Modules for YARP and friends"
  homepage "https://robotology.github.io/ycm"

  stable do
    url "https://github.com/robotology/ycm/releases/download/v0.10.3/ycm-0.10.3-offline.tar.gz"
    sha256 "77e3634200e43db354b955ee1f123066649f963718b9a607ce48e9a3b3bd687d"
  end

  bottle do
    root_url "https://github.com/robotology/ycm/releases/download/v0.10.3"
    cellar :any_skip_relocation
    sha256 "a4c120d4ff189f41b09631822dd44e8fc510fe76418b91836aef049204168691" => :mojave
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
