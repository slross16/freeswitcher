require "fsr/app"
module FSR
  module Cmd
    class Channels < Command

      include Enumerable
      def each(&block)
        @channels ||= run
        if @channels
          @channels.each { |call| yield call }
        end
      end

      def initialize(fs_socket = nil, filter = nil)
        @filter = filter
        @filter = nil if (@filter === true || @filter === false)
        @fs_socket = fs_socket # FSR::CommandSocket obj
      end

      # Send the command to the event socket, using bgapi by default.
      def run(api_method = :api)
        orig_command = "%s %s" % [api_method, raw]
        Log.debug "saying #{orig_command}"
        resp = @fs_socket.say(orig_command)
        unless resp["body"] == "0 total."
          call_info, count = resp["body"].split("\n\n")
          require "fsr/model/channel"
          require "csv"
          channels = CSV.parse(call_info) 
          headers = channels[0]
          @channels = channels[1 .. -1].map { |c| FSR::Model::Channel.new(headers ,*c) }
          return @channels
        end
        []
      end

      # This method builds the API command to send to the freeswitch event socket
      def raw
        if @filter.nil?
          'show channels'
        elsif @filter.is_a?(Fixnum)
          'show channels %d' % @filter
        elsif @filter.is_a?(String)
          'show channels like "%s"' % @filter
        else
          'show channels'
        end
      end
    end

    register(:channels, Channels)
  end
end
