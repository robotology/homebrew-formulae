class Yarp < Formula
  desc "Yet Another Robot Platform"
  homepage "http://yarp.it"

  stable do
    url "https://github.com/robotology/yarp/archive/v2.3.68.1.tar.gz"
    sha256 "17eafeed8cc5ca37e3c003527ad60ca133314bd6e9b1455ec7b6f5dbfa95567c"
  end

  bottle do
    root_url "https://github.com/robotology/yarp/releases/download/v2.3.68.1"
    sha256 "cdfceec0da0766384b80d96d0d82b2822510e5584ae46ae5ed05748f8c161d7f" => :sierra
  end

  head do
    url "https://github.com/robotology/yarp.git", :branch => "master"
  end

  option "without-qt5", "Build without GUI applications"
  option "with-yarprun-log", "Build with LOG support for YARPRUN processes"
  option "with-bindings", "Build with binding (LUA, Python) support"
  option "with-serial", "Build the serial/serialport devices"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "eigen" => :build
  depends_on "ace"
  depends_on "jpeg"
  depends_on "homebrew/science/opencv" => :optional
  depends_on "qt5" => :recommended
  if build.with? "bindings"
    depends_on "lua"
    depends_on "swig"
    depends_on :python
  end

  def install
    args = std_cmake_args + %W[
      -DCREATE_LIB_MATH=TRUE
      -DCREATE_DEVICE_LIBRARY_MODULES=TRUE
      -DCREATE_OPTIONAL_CARRIERS=TRUE
      -DENABLE_yarpcar_mjpeg_carrier=TRUE
      -DENABLE_yarpcar_rossrv_carrier=TRUE
      -DENABLE_yarpcar_tcpros_carrier=TRUE
      -DENABLE_yarpcar_xmlrpc_carrier=TRUE
      -DENABLE_yarpcar_bayer_carrier=TRUE
      -DENABLE_yarpcar_priority_carrier=TRUE
    ]

    args << "-DCREATE_GUIS=TRUE" if build.with? "qt5"
    args << "-DENABLE_YARPRUN_LOG=ON" if build.with? "yarprun-log"
    args << "-DENABLE_yarpmod_opencv_grabber=ON" if build.with? "opencv"

    if build.with? "bindings"
      args << "-DYARP_COMPILE_BINDINGS=ON"
      args << "-DCREATE_LUA=ON"
      args << "-DCREATE_PYTHON=ON"
      args << "-DCMAKE_INSTALL_LUADIR=#{lib}/lua"
    end

    if build.with? "serial"
      args << "-DENABLE_yarpmod_serial=ON"
      args << "-DENABLE_yarpmod_serialport=ON"
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
    
    if build.with? "bindings"
        s += "  export LUA_CPATH=\";;;#{lib}/lua/?.so\""
    end
    s
  end

  test do
    system "#{bin}/yarp", "check"
  end
end
