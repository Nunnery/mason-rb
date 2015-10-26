module MasonRb
  # Contains logic for configuration of MasonRb.
  # All configuration logic is heavily inspired by fastlane_core.
  module Configuration
    # Contains logic for loading configuration files.
    class ConfigurationFile
      # A reference to the actual configuration.
      attr_accessor :config

      def initialize(config, path, block_for_missing)
        self.config = config
        @block_for_missing = block_for_missing
        content = File.read(path)

        # From https://github.com/orta/danger/blob/master/lib/danger/Dangerfile.rb
        if content.tr!('“”‘’‛', %(""'''))
          Helper.log.error "Your #{File.basename(path)} has had smart quotes sanitised. " \
                    'To avoid issues in the future, you should not use ' \
                    'TextEdit for editing it. If you are not using TextEdit, ' \
                    'you should turn off smart quotes in your editor of choice.'
        end

        begin
          eval(content)
        rescue SyntaxError => ex
          line = ex.to_s.match(/\(eval\):(\d+)/)[1]
          raise Helper.PASTEL.red("Syntax error in your configuration file '#{path}' on line #{line}: #{ex}").to_s
        end
      end

      def method_missing(method_sym, *arguments, &block)
        # First, check if the key is actually available
        if self.config.all_keys.include? method_sym
          value = arguments.first || (block.call if block_given?) # this is either a block or a value
          if value
            self.config[method_sym] = value
          end
        else
          # We can't set this value, maybe the tool using this configuration system has its own
          # way of handling this block, as this might be a special block (e.g. ipa block) that's only
          # executed on demand
          if @block_for_missing
            @block_for_missing.call(method_sym, arguments, block)
          else
            self.config[method_sym] = '' # important, since this will raise a good exception for free
          end
        end
      end
    end
  end
end