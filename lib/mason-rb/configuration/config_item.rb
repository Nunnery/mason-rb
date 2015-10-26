module MasonRb
  # Contains logic for configuration of MasonRb.
  # All configuration logic is heavily inspired by fastlane_core.
  module Configuration
    # Contains logic related to an individual configuration item.
    class ConfigItem
      attr_accessor :key
      attr_accessor :env_name
      attr_accessor :description
      attr_accessor :short_option
      attr_accessor :default_value
      attr_accessor :verify_block
      attr_accessor :is_string
      attr_accessor :optional

      # Creates a new configuration option.
      # @param key [Symbol] the key which is used as a command parameter
      # @param env_name [String] the name of the environment variable
      # @param description [String] description shown to the user
      # @param short_option [String] a string of length 1 which is used for command parameters (e.g. -f)
      # @param default_value [Object] the returned value if no given value and no environment variable value
      # @param verify_block [Object] an optional block called when the new value is set
      # @param is_string [String] is the parameter a string? defaults to true. if it's true, the type string will be verified.
      # @param optional [Boolean] false by default; if true, string values will not be verified by the user
      def initialize(key = nil, env_name = nil, description = nil,
                     short_option = nil, default_value = nil, verify_block = nil,
                     is_string = nil, optional = nil)
        raise 'key must be a symbol' unless key.kind_of? Symbol
        raise 'env_name must be a String' unless (env_name || '').kind_of? String
        if short_option
          raise_it = (short_option.kind_of? String and short_option.delete('-').length == 1)
          raise 'short option must be a String of length 1' unless raise_it
        end
        if description
          raise_it = (description[-1] == '.')
          raise 'do not let descriptions end with a period as it is used for user input as well' unless raise_it
        end

        @key = key
        @env_name = env_name
        @description = description
        @short_option = short_option
        @default_value = default_value
        @verify_block = verify_block
        @is_string = is_string
        @optional = optional
      end

      # Raises an exception if this option is not valid.
      # @param value [Object] value of the option
      # @return [Boolean] if this option valid?
      def verify!(value)
        raise "Invalid value #{value} for option #{self}" unless valid? value
        true
      end

      # Make sure, the value is valid (based on the verify block)
      # @param value [Object] value to check
      # @return [Boolean] is value valid?
      def valid?(value)
        # we also allow nil values, which do not have to be verified.
        if value
          if @is_string
            raise "'#{self.key}' must be a String! Found #{value.class} instead." unless value.kind_of? String
          end

          if @verify_block
            begin
              @verify_block.call value
            rescue => ex
              Helper.log.fatal "Error setting value '#{value}' for option '#{@key}'"
              raise ex
            end
          end
        end

        true
      end

      # Returns an updated value type (if necessary)
      # @param value [Object] value to convert
      # @return [Object] true, false, or the passed in value
      def auto_convert_value(value)
        # Special treatment if the user specified true, false or YES, NO
        if %w(YES yes true).include?(value)
          value = true
        elsif %w(NO no false).include?(value)
          value = false
        end

        value
      end

      def to_s
        [@key, @description].join(': ')
      end
    end
  end
end