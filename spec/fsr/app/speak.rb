require 'spec/helper'
require "fsr/app"
FSR::App.load_application("speak")

describe "Testing FSR::App::Speak" do
  it "Speaks a string" do
    speak = FSR::App::Speak.new("Say my name", engine: "flite", voice: "cms")
    speak.sendmsg.should == "call-command: execute\nexecute-app-name: speak\nexecute-app-arg: flite|cms|Say my name\nevent-lock:true\n\n"
  end

end
