#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), "..", 'lib', 'fsr')
require "fsr/listener/outbound"
$stdout.flush

class InboundCallerId < FSR::Listener::Outbound

  def session_initiated
    caller_number = @session.headers[:caller_caller_id_number]
    FSR::Log.info "*** Answering incoming call from #{exten}"

    answer do
      # Lookup number in the database
      caller_name = Ldap.find(telephoneNumber: caller_number).givenName
      set(caller_caller_id_name: caller_name) { continue }
    end

  end

end

FSR.start_oes! InboundCallerId, :port => 8084, :host => "127.0.0.1"
