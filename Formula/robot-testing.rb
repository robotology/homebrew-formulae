class RobotTesting < Formula
  desc "Robot Testing Framework (RTF)"
  homepage "https://robotology.github.io/robot-testing/index.html"

  stable do
    url "https://github.com/robotology/robot-testing/archive/v1.2.0.tar.gz"
    sha256 "d5147e190647b576c0219759467dfc7663a8262672cb8ef5209a7c455488b2e4"
  end

  head do
    url "https://github.com/robotology/robot-testing.git", :branch => "master"
  end

  depends_on "cmake" => :build

  depends_on "python" => :optional
  depends_on "lua" => :optional

  def install
    args = std_cmake_args + %w[
      -DENABLE_RUBY_PLUGIN:BOOL=ON
    ]

    args << "-DENABLE_LUA_PLUGIN:BOOL=ON" if build.with? "lua"
    args << "-DENABLE_PYTHON_PLUGIN:BOOL=ON" if build.with? "python"

    system "cmake", *args
    system "make", "install"
  end

  test do
  end
end
