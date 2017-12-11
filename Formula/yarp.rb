class Yarp < Formula
  desc "Yet Another Robot Platform"
  homepage "http://yarp.it"

  stable do
    url "https://github.com/robotology/yarp/archive/v2.3.70.2.tar.gz"
    sha256 "888c4d2d85e0d9a3da4c4a111ed96c77c35a2849ed9bf079d69b08941f40ea79"
  end

  bottle do
    root_url "https://github.com/robotology/yarp/releases/download/v2.3.70.2"
    sha256 "d68bd7e09a45f3b066f1556c8016d3ad3b1f20ebd1c2b4868a75171aa14c0564" => :sierra
  end

  head do
      url "https://github.com/robotology/yarp.git", :branch => "master"
  end

  option "without-qt5", "Build without GUI applications"
  option "with-bindings", "Build with binding (LUA, Python) support"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "eigen" => :build
  depends_on "ace"
  depends_on "jpeg"
  depends_on "homebrew/science/opencv" => :optional
  depends_on "qt" => :recommended
  depends_on "robotology/formulae/ycm" => :recommended
  depends_on "robotology/formulae/robot-testing" => :recommended
  if build.with? "bindings"
    depends_on "lua"
    depends_on "swig"
    depends_on :python
  end

  def install
    args = std_cmake_args + %w[
      -DCREATE_LIB_MATH:BOOL=TRUE
      -DCREATE_DEVICE_LIBRARY_MODULES:BOOL=TRUE
      -DENABLE_YARPRUN_LOG:BOOL=FALSE
      -DCREATE_OPTIONAL_CARRIERS:BOOL=TRUE
      -DENABLE_yarpcar_mjpeg:BOOL=TRUE
      -DENABLE_yarpcar_rossrv:BOOL=TRUE
      -DENABLE_yarpcar_tcpros:BOOL=TRUE
      -DENABLE_yarpcar_xmlrpc:BOOL=TRUE
      -DENABLE_yarpcar_bayer:BOOL=TRUE
      -DENABLE_yarpcar_priority:BOOL=TRUE
    ]

    args << "-DCREATE_GUIS:BOOL=TRUE" if build.with? "qt"
    if build.with? "opencv"
      args << "-DENABLE_yarpmod_opencv_grabber:BOOL=TRUE"
    else
      args << "-DCMAKE_DISABLE_FIND_PACKAGE_OpenCV:BOOL=TRUE"
    end
    args << "-DYARP_COMPILE_RTF_ADDONS:BOOL=TRUE" if build.with? "robot-testing"

    if build.with? "bindings"
      args << "-DYARP_COMPILE_BINDINGS:BOOL=TRUE"
      args << "-DCREATE_LUA:BOOL=TRUE"
      args << "-DCREATE_PYTHON:BOOL=TRUE"
      args << "-DCMAKE_INSTALL_LUADIR=#{lib}/lua"
    end

    system "cmake", *args
    system "make", "install"
    bash_completion.install "scripts/yarp_completion"
  end

  def caveats
    s = <<-EOS.undent
    You need to add in your ~/.bash_profile or similar:

      export YARP_DATA_DIRS=#{HOMEBREW_PREFIX}/share/yarp
    EOS

    s += "  export LUA_CPATH=\";;;#{lib}/lua/?.so\"" if build.with? "bindings"
    s
  end

  test do
    system "#{bin}/yarp", "check"
  end
end
