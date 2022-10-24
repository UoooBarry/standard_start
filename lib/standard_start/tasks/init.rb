# frozen_string_literal: true

module StandardStart
  module Tasks
    # Straightforward task
    class Init < BaseTask
      def call!
        path = attributes.first

        full_path = File.expand_path(path)

        puts "Finding gemfile in #{full_path}"

        if File.exist?("#{full_path}/Gemfile")
          puts "Gemfile found, proceeding with installation"
          # install(full_path)
          puts self.options
        else
          puts "Gemfile not found, exiting"
        end
      end

      private

      def install(full_path)
        bundle_command = "bundle add rspec rubocop --group \"development, test\""

        puts `cd #{full_path} && #{bundle_command}`
      end
    end
  end
end
