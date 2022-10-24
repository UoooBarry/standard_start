# frozen_string_literal: true

module StandardStart
  module Tasks
    # Straightforward task
    class BaseTask
      attr_accessor :options, :attributes

      def initialize(attributes, options)
        self.options = options
        self.attributes = attributes
      end

      def self.call!(attributes, options)
        new(attributes, options).call!
      end
    end
  end
end
