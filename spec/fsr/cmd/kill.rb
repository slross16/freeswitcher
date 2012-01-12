require 'spec/helper'
require "fsr/cmd"

FSR::Cmd.load_command("kill")

describe "Testing FSR::Cmd::Kill" do
  ## Kill ##
  # Kill a channel or call
  it "FSR::Cmd::Kill a channel as a string" do
    cmd = FSR::Cmd::Kill.new(nil, "abcd-1234-efgh-5678")
    cmd.raw.should == "uuid_kill abcd-1234-efgh-5678"
  end

  it "FSR::Cmd::Kill a call as a Call object" do
    require "fsr/model/call"
    call = FSR::Model::Call.new(["uuid"], 'abcd-1234-efgh-5678')
    cmd = FSR::Cmd::Kill.new(nil, call)
    cmd.raw.should == "uuid_kill abcd-1234-efgh-5678"
  end

  it "FSR::Cmd::Kill a call as a Channel object" do
    require "fsr/model/channel"
    channel = FSR::Model::Channel.new(["uuid"], 'abcd-1234-efgh-5678')
    cmd = FSR::Cmd::Kill.new(nil, channel)
    cmd.raw.should == "uuid_kill abcd-1234-efgh-5678"
  end

end
