require 'ngrok/tunnel'

module Aws
  module Ecs
    class Compiler
      attr_reader :output,
                  :wait,
                  :without_task_logs,
                  :project,
                  :environment,
                  :command,
                  :url,
                  :errors,
                  :command_line

      def initialize(ops = {})
        @output = ops[:output] == 'true'
        @wait = ops[:wait] == 'true'
        @without_task_logs = ops[:without_task_logs] == 'true'
        @project = ops[:project]
        @environment = ops[:environment]
        @command = ops[:command]
        @url = compile_url

        validate_params
        save_commands_to_file
        compile
      end

      def compile
        @command_line =
          "bin/deploy/run " +
          "#{'--output ' if output}" +
          "#{'--wait ' if wait}" +
          "#{'--without-task-logs ' if without_task_logs}" +
          "--environment #{environment} " +
          "--projects #{project} " +
          "-- bundle exec ruby -r ./config/environment.rb -e " +
          "\"require 'open-uri'; eval(open('#{url}').read)\""
      end

      private

      def save_commands_to_file
        File.write('public/commands.rb', command)
      end

      def compile_url
        Ngrok::Tunnel.ngrok_url_https + '/welcome/file'
      end

      def validate_params
        return unless [project, environment, command, url].find(&:empty?)
        @errors = 'You must fill all params: environment, project, command!'
      end
    end
  end
end
