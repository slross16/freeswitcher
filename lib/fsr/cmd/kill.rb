require "fsr/app"
module FSR
  module Cmd
    class Kill < Command
      attr_reader :uuid

      def initialize(fs_socket = nil, uuid_or_object)
        @fs_socket = fs_socket # FSR::CommandSocket obj
        # Either something that responds to :uuid or a string that is the uuid
        if uuid_or_object.respond_to?(:uuid)
          @uuid = uuid_or_object.uuid
        else
          @uuid = uuid_or_object
        end
      end

      # Send the command to the event socket, using bgapi by default.
      def run(api_method = :api)
        orig_command = "%s %s" % [api_method, raw]
        Log.debug "saying #{orig_command}"
        @fs_socket.say(orig_command)
      end

      # This method builds the API command to send to the freeswitch event socket
      def raw
        orig_command = "uuid_kill #{uuid}"
      end
    end

    register(:kill, Kill)
  end
end
