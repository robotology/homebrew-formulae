class Rfsm < Formula
  desc "Lightweight Statechart implementation in Lua"
  homepage "https://github.com/kmarkus/rFSM"
  url "https://github.com/kmarkus/rFSM.git", :branch => "master"
  version "1.0"

  depends_on "lua"

  def install
    bindingsShare = Pathname.new("#{share}/rFSM")
    bindingsShare.install Dir["*"] #e.g. copy all files
  end

  def caveats
    <<-EOS.undent
    You need to set the LUA_PATH environment variable
    (e.g. You need to add in your ~/.bash_profile or similar)

      export LUA_PATH=";;;#{share}/rFSM/?.lua"
    EOS
  end

  test do
      (testpath/"root_fsm.lua").write <<-EOS.undent
      return rfsm.state {

         ----------------------------------
         -- state HOME                   --
         ----------------------------------
         ST_HOME = rfsm.state{
                 entry=function()
                         print("everything is fine, now exiting")
                 end
         },

         ----------------------------------
         -- state FINI                   --
         ----------------------------------
         ST_FINI = rfsm.state{
                 entry=function()
                         print("Closing...")
                         shouldExit = true;
                 end
         },


         ----------------------------------
         -- setting the transitions      --
         ----------------------------------

         rfsm.transition { src='initial', tgt='ST_HOME' },
         rfsm.transition { src='ST_HOME', tgt='ST_FINI', events={ 'e_done' } },

      }
      EOS

    (testpath/"main.lua").write <<-EOS.undent
        #!/usr/bin/lua

        require("rfsm")

        -------
        shouldExit = false

        fsm_file = "root_fsm.lua"

        fsm_model = rfsm.load(fsm_file)
        fsm = rfsm.init(fsm_model)
        rfsm.run(fsm)

        repeat
            rfsm.run(fsm)
        until shouldExit ~= false

        print("finishing")
    EOS
    # To capture the output of a command, we use backtics:
    ENV.append("LUA_PATH",";;;#{share}/rFSM/?.lua",";")
    # system "export LUA_PATH=\";;;#{share}/rFSM/?.lua\""
    system 'lua', (testpath/"main.lua")
    ohai "Success"
  end

end
