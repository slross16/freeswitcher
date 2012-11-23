require "fsr/app"
module FSR
  module Cmd
    class Chat < Command

      attr_reader :fs_socket

      def initialize(fs_socket = nil, args = {})
        @fs_socket = fs_socket # FSR::CommandSocket obj
        @protocol = args[:protocol] ? args[:protocol] : 'sip'
        @from = '1001'
        @to   = '1003@192.168.0.6'
        @message = 'Oh, hello!' 
      end

      # Send the command to the event socket, using api by default.
      def run(api_method = :api)
        orig_command = "%s %s" % [api_method, raw]
        Log.debug "saying #{orig_command}"
        @fs_socket.say(orig_command)
      end
    
      # This method builds the API command to send to the freeswitch event socket
      def raw
        %Q(chat #{@protocol}|#{@from}|#{@to}|#{@message})
      end
    end

  register(:chat, Chat) 
  end
end