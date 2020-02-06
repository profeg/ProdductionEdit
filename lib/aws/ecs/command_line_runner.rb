module Aws
  module Ecs
    class CommandLineRunner
      attr_reader :output, :oso_path, :command_line

      def initialize(command_line)
        @oso_path = ENV['OSO_PATH']
        @command_line = command_line
        @output = run
      end

      private

      def run
        %x[cd #{oso_path} &&#{command_line}]
      end
    end
  end
end
