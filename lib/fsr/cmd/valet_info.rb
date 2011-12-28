require "fsr/app"
module FSR
  module Cmd
    class ValetInfo < Command

      def initialize(fs_socket = nil)
        @fs_socket = fs_socket # FSR::CommandSocket obj
      end

      # Send the command to the event socket, using bgapi by default.
      def run(api_method = :api)
        orig_command = "%s %s" % [api_method, raw]
        Log.debug "saying #{orig_command}"
        @fs_socket.say(orig_command)
      end

      # This method builds the API command to send to the freeswitch event socket
      def raw
        orig_command = "valet_info"
      end
    end

    register(:valet_info, ValetInfo)
  end
end
