class Yarp < Formula
  desc "Yet Another Robot Platform"
  homepage "http://yarp.it"

  stable do
    url "https://github.com/robotology/yarp/archive/v2.3.70.tar.gz"
    sha256 "a44aaae8502946effed6d3284e70f90c4234a9c29da6229355607ee9b98fd223"
  end

  bottle do
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
  depends_on "ycm" => :recommended
  depends_on "robot-testing" => :recommended
  if build.with? "bindings"
    depends_on "lua"
    depends_on "swig"
    depends_on :python
  end

  def install
    args = std_cmake_args + %w[
      -DCREATE_LIB_MATH:BOOL=TRUE
      -DCREATE_DEVICE_LIBRARY_MODULES:BOOL=TRUE
      -DENABLE_YARPRUN_LOG:BOOL=TRUE
      -DCREATE_OPTIONAL_CARRIERS:BOOL=TRUE
      -DENABLE_yarpcar_mjpeg_carrier:BOOL=TRUE
      -DENABLE_yarpcar_rossrv_carrier:BOOL=TRUE
      -DENABLE_yarpcar_tcpros_carrier:BOOL=TRUE
      -DENABLE_yarpcar_xmlrpc_carrier:BOOL=TRUE
      -DENABLE_yarpcar_bayer_carrier:BOOL=TRUE
      -DENABLE_yarpcar_priority_carrier:BOOL=TRUE
    ]

    args << "-DCREATE_GUIS:BOOL=TRUE" if build.with? "qt"
    args << "-DENABLE_yarpmod_opencv_grabber:BOOL=TRUE" if build.with? "opencv"
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
