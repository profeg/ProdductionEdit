# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index;end

  def create
    compiler = Aws::Ecs::Compiler.new(request.params)

    if compiler.errors
      json = { result: compiler.errors }
    else
      runner = Aws::Ecs::CommandLineRunner.new(compiler.command_line)

      json = {
        result: compiler.command_line,
        command_output: runner.output
      }
    end

    render json: json
  end

  def file
    send_file(
      "#{Rails.root}/public/commands.rb",
      filename: 'commands.rb',
      type: 'text/html'
    )
  end
end
