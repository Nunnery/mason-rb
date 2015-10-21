require 'mason-rb/console'
require 'mason-rb/printing'

module MasonRb
  # Contains logic for interacting with the command line. Stateless.
  # @author Richard Harrah
  class CLI
    include ::MasonRb::Console
    include ::MasonRb::Printing

    # Executes a command.
    # @param command [String] command to execute
    # @return [void]
    def cli(command)
      execute command
      nil
    end

    class << self
      # Executes a command.
      # @param command [String] command to execute
      # @return [void]
      def commandline(command)
        new.cli command
        nil
      end
    end
  end
end