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

  it "FSR::Cmd::Channels (string as the filter) should add the filter" do
    sofia = FSR::Cmd::Channels.new(nil, 'something')
    sofia.raw.should == 'show channels like "something"'
  end

  it "FSR::Cmd::Channels (number as the filter) should just limit the calls to that number" do
    sofia = FSR::Cmd::Channels.new(nil, 3)
    sofia.raw.should == "show channels 3"
  end

end
