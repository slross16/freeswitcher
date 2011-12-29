#!/usr/bin/env ruby

require File.expand_path('../../lib/fsr', __FILE__)
require "fsr/listener/outbound"
$stdout.flush

class OutboundRouter < FSR::Listener::Outbound

  def session_initiated
    @exten = @session.headers[:caller_caller_id_number]
    FSR::Log.info "Answering incoming call from #{@exten}"

    if action = @session.headers[:variable_action]
      FSR::Log.info "Action is #{action}"
      send(action) if respond_to?(action)
    else
      FSR::Log.info "No action specified, hanging up"
      hangup
    end
  end

  def echo_dtmf
    answer do
      FSR::Log.info "Reading DTMF from #{@exten}"
      #######################################################
      ## NOTE YOU MUST MAKE SURE YOU PASS A VALID WAV FILE ##
      #######################################################
      read("ivr/8000/ivr-please_enter_extension_followed_by_pound.wav", 4, 10, "input", 7000) do |read_var|
        FSR::Log.info "Success, grabbed #{read_var.to_s.strip} from #{@exten}"
        # Tell the caller what they entered
        # If you have mod_flite installed you should hear speech
        fs_sleep(1000) {
          speak("You Entered") {
            say(read_var.to_s.strip) { hangup }
          }
        }
      end
    end
  end

  def receive_reply(reply)
    FSR::Log.info "Received #{reply.inspect}"
  end


end

FSR.start_oes! OutboundRouter, :port => 8184, :host => "127.0.0.1"
