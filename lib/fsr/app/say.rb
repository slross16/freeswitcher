
require "fsr/app"
module FSR
  module App
    class Say < Application
      # http://wiki.freeswitch.org/wiki/Misc._Dialplan_Tools_say
      attr_reader :message

      def initialize(message, opts = {})
        # wav file you wish to play, full path
        @message = message
        @language = opts[:language] || "en"
        @data_type = opts[:data_type] || "number"
        @say_method = opts[:say_method] || "pronounced"
        @gender = opts[:gender] || "feminine"
      end

      def arguments
        [@language, @data_type, @say_method, @gender, @message]
      end

    end

    register(:say, Say)
  end
end
