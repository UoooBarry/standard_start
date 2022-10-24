# frozen_string_literal: true

require "optparse"

module StandardStart
  # Parse arguments
  class ArgumentParser
    attr_accessor :args, :options

    class UnknownCommand < StandardError; end

    def initialize(args)
      self.options = {}
      self.args = args
    end

    def self.call!(args)
      new(args).call!
    end

    # rubocop:disable Metrics/MethodLength
    def call!
      OptionParser.new do |opts|
        opts.banner = "Usage: snatdard_start.rb [options]"

        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          options[:verbose] = v
        end

        opts.on("-r", "--rails", "Run verbosely") do |v|
          options[:rails] = v
        end

        opts.on("-d--string=STRING", String) do |v|
          options[:download] = v
        end
      end.parse!

      process_command!
    end
    # rubocop:enable Metrics/MethodLength

    private

    def process_command!
      command, *attributes = args

      begin
        clazz = StandardStart::Tasks.const_get(command.capitalize)

        clazz.call!(attributes, options)
      rescue NameError
        raise UnknownCommand, "Unknown command \"#{command}\""
      end
    end
  end
end
