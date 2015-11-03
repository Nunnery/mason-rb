require 'pastel'

module MasonRb
  # Contains logic related to errors and their use.
  module Errors
    # A constant copy of the Pastel string coloring library.
    # @return [Pastel] string coloring library
    PASTEL = Pastel.new

    class BaseError < RuntimeError
      attr_reader :message

      def initialize(message = '')
        @message = MasonRb::Errors::PASTEL.red(message)
      end
    end

    class InvalidParameterError < BaseError
      def initialize(parameter, expected_type, actual_type)
        super("#{parameter} must be a #{expected_type} but was #{actual_type}")
      end
    end

    class InvalidTypeError < BaseError
      def initialize(parameter, expected_type)
        super("#{parameter} must be a(n) #{expected_type}")
      end
    end

    class OptionNotFound < BaseError
      def initialize(key, options)
        super("Could not find option '#{key}' in the list " +
                  "of available options #{options.collect(&:key).join(', ')}")
      end
    end

    class MultipleEntryError < BaseError
      def initialize(key)
        super("Multiple entries for key '#{key}' found!")
      end
    end

    class InvalidDefaultError < BaseError
      def initialize(key)
        super("Invalid default value for #{key}, doesn't match verify_block")
      end
    end
  end
end