# frozen_string_literal: true

require_relative "standard_start/version"
require_relative "standard_start/argument_parser"
Dir[File.join(__dir__, "standard_start", "tasks", "*.rb")].sort.each { |file| require file }

# Standard start the project
module StandardStart
  class Error < StandardError; end

  def self.call!(args)
    ArgumentParser.call!(args)
  rescue StandardError => e
    raise if ENV["DEBUG"]

    puts "Error: #{e.message}"
  end
end
