class IcubMain < Formula
  desc "Libraries for the iCub humanoid robot"
  homepage "https://github.com/robotology/icub-main"

  stable do
    url "https://github.com/robotology/icub-main/archive/1.8.0.tar.gz"
    sha256 "947424d1ef908ffa2acf948b7724e32d2d9f1158767db18dfb61ba8ebe5bd75f"
  end

  bottle do
    root_url "https://github.com/robotology/icub-main/releases/download/1.8.0"
    sha256 "822911aba4d1c3f7f9b433cce179e1ae6ddbc7f8af5da71eca095cebda073d7d" => :sierra
  end

  head do
    url "https://github.com/robotology/icub-main", :branch => "master"
  end

  option "with-ipopt", "Build with Cartesian Solvers"
  option "with-opencv", "Build with OpenCV support"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "qt"
  depends_on "gsl"
  depends_on "opencv" => :optional
  depends_on "dartsim/dart/ipopt" => :optional

  def install
    args = std_cmake_args + %w[
      -DICUB_SHARED_LIBRARY:BOOL=TRUE
      -DICUB_USE_Qt5:BOOL=TRUE
      -DICUB_USE_SDL:BOOL=FALSE
    ]

    args << "-DICUB_USE_IPOPT:BOOL=TRUE" if build.with? "ipopt"
    args << "-DICUB_USE_OpenCV:BOOL=TRUE" if build.with? "opencv"

    system "cmake", *args
    system "make", "install"
  end

  test do
  end
end
