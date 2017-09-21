class GazeboYarpPlugins < Formula
  desc "Gazebo plugins for the YARP middleware"
  homepage "https://github.com/robotology/gazebo-yarp-plugins"

  stable do
    url "https://github.com/robotology/gazebo-yarp-plugins/archive/v2.3.70.tar.gz"
    sha256 "7711f996f9ddebdda2c77f04748aa7145540b2b87f797efa5db3cae926c64c1f"
  end

  bottle do
    sha256 "e958e773443bfc175e068beb34cf78dad76782d8005f21686d4e99eaeed18a29" => :sierra
  end

  head do
    url "https://github.com/robotology/gazebo-yarp-plugins.git", :branch => "devel"
  end

  ## Dependencies
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "robotology/formulae/yarp"
  depends_on "gazebo8"
  depends_on "homebrew/science/opencv" => :optional

  ## The install method.
  def install
    args = std_cmake_args
    if build.with? "opencv"
      args << "-DGAZEBO_YARP_PLUGINS_HAS_OPENCV:BOOL=ON"
    else
      args << "-DGAZEBO_YARP_PLUGINS_HAS_OPENCV:BOOL=OFF"
    end

    system "cmake", *args
    system "make", "install"
  end

  test do
    (testpath/"test.sh").write <<-EOS.undent
      #!/bin/bash
      yarp namespace /brew_test
      yarpserver &
      PID_yarpserver=$!

      export GAZEBO_MODEL_DATABASE_URI=""
      gzserver -slibgazebo_yarp_clock.so --verbose &
      PID_gzserver=$!
      sleep 2
      yarp exists /clock
      SUCCESS=$?
      if [ ${SUCCESS} -eq 0 ]
        then echo "Test successfull";
      else
        echo "Test failed";
      fi

      kill -9 ${PID_gzserver}
      kill -9 ${PID_yarpserver}

      exit ${SUCCESS}
    EOS
    # To capture the output of a command, we use backtics:
    system "sh", (testpath/"test.sh")
    shell_output("echo $?")
    ohai "Success"
  end
end
