require 'spec/helper'
require "fsr/app"
FSR::App.load_application("say")

describe "Testing FSR::App::Say" do
  it "Says number, pronounced, masculine" do
    say = FSR::App::Say.new("12345", language: "en", data_type: "number", say_method: "pronounced", gender: "masculine")
    say.sendmsg.should == "call-command: execute\nexecute-app-name: say\nexecute-app-arg: en|number|pronounced|masculine|12345\nevent-lock:true\n\n"
  end

end
