require 'spec/helper'
require "fsr/cmd"
FSR::Cmd.load_command("calls")

describe "Testing FSR::Cmd::Calls" do
  ## Calls ##
  # Interface to calls
  it "FSR::Cmd::Calls should send show calls" do
    cmd = FSR::Cmd::Calls.new
    cmd.raw.should == "show calls"
  end

  it "FSR::Cmd::Calls with the :detailed argument should send show detailed_calls" do
    cmd = FSR::Cmd::Calls.new(nil, :detailed)
    cmd.raw.should == "show detailed_calls"
  end

  it "FSR::Cmd::Calls with the :bridged argument should send show detailed_calls" do
    cmd = FSR::Cmd::Calls.new(nil, :bridged)
    cmd.raw.should == "show bridged_calls"
  end

  it "FSR::Cmd::Calls with the :detailed_bridged argument should send show detailed_calls" do
    cmd = FSR::Cmd::Calls.new(nil, :detailed_bridged)
    cmd.raw.should == "show detailed_bridged_calls"
  end

  it "FSR::Cmd::Calls fails with an invalid type argument" do
    lambda { FSR::Cmd::Calls.new(nil, :food) }.should.raise ArgumentError
  end

  it "FSR::Cmd::Calls sends a filter, when supplied" do
    cmd = FSR::Cmd::Calls.new(nil, nil, "1234")
    cmd.raw.should == "show calls like '1234'"
  end

end
