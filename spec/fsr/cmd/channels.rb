require 'spec/helper'
require "fsr/cmd"
FSR::Cmd.load_command("channels")

describe "Testing FSR::Cmd::Channels" do
  ## Channels ##
  # Interface to channels
  it "FSR::Cmd::Channels (false as the filter) should send show channels" do
    sofia = FSR::Cmd::Channels.new(nil, false)
    sofia.raw.should == "show channels"
    sofia.instance_variable_get("@filter").should.be.nil
  end

  it "FSR::Cmd::Channels (true as the filter) should send show channels" do
    sofia = FSR::Cmd::Channels.new(nil, true)
    sofia.raw.should == "show channels"
    sofia.instance_variable_get("@filter").should.be.nil
  end

  it "FSR::Cmd::Channels (regex as the filter) should store the proper filter" do
    sofia = FSR::Cmd::Channels.new(nil, /something/)
    sofia.raw.should == "show channels"
    sofia.instance_variable_get("@filter").should == /something/
  end

end
