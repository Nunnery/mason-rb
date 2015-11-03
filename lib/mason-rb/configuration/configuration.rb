require 'mason-rb/configuration/commander_generator'
require 'mason-rb/configuration/config_item'
require 'mason-rb/configuration/configuration_file'

module MasonRb
  module Configuration
    # Contains the logic related to configuration.
    class Configuration
      attr_accessor :available_options

      attr_accessor :values

      attr_reader :all_keys

      attr_accessor :configuration_file_name

      def initialize(available_options, values)
        @available_options = available_options
        @values = values

        verify_input_types
        verify_value_exists
        verify_no_duplicates
        verify_default_value_matches_block
      end

      class << self

      end

      private

      def verify_input_types
        unless @available_options.kind_of? Array
          raise MasonRb::Errors::InvalidParameterError.new(
              'available_options', 'array of ConfigItems',
              @available_options.class)
        end
        @available_options.each do |item|
          unless item.kind_of? MasonRb::Configuration::ConfigItem
            raise MasonRb::Errors::InvalidParameterError.new(
                'available_options', 'array of ConfigItems',
                item.class)
          end
        end
        unless @values.kind_of? Hash
          raise MasonRb::Errors::InvalidTypeError.new('values', 'Hash')
        end
      end

      def verify_value_exists
        @values.each do |key, value|
          option = option_for_key(key)
          if option
            option.verify!(value)
          else
            raise MasonRb::Errors::OptionNotFoundError.new(key,
                                                           @available_options)
          end
        end
      end

      def verify_no_duplicates
        @available_options.each do |current|
          count = @available_options.count { |option| option.key == current
                                                                        .key }
          if count > 1
            raise MasonRb::Errors::OptionNotFoundError.new(current.key)
          end
          unless current.short_option.to_s.empty?
            count = @available_options.count { |option|
              option.short_option == current.short_option
            }
            if count > 1
              raise MasonRb::Errors::OptionNotFoundError.new(current.short_option)
            end
          end
        end
      end

      def verify_default_value_matches_block
        @available_options.each do |item|
          next unless item.verify_block && item.default_value

          begin
            item.verify_block.call(item.default_value)
          rescue => ex
            MasonRb::Helper.log.fatal ex
            raise MasonRb::Errors::InvalidDefaultError.new(item.key)
          end
        end
      end

    end
  end
end