require 'pastel'

module MasonRb
  # Contains logic for printing messages to the console. Supports ANSI colors.
  # Inspired by rubygems-tasks' printing.rb
  # @author Richard Harrah
  module Printing

    private

    PASTEL = Pastel.new

    # String to prepend to any status messages
    # @return [String] prefix for status messages
    STATUS_PREFIX = if $stdout.tty?
                      "#{PASTEL.bright_green('>>>', PASTEL.clear(''))}"
                    else
                      '>>>'
                    end

    # String to prepend to any debug messages
    # @return [String] prefix for debug messages
    DEBUG_PREFIX = if $stdout.tty?
                     "#{PASTEL.bright_yellow('>>>', PASTEL.clear(''))}"
                   else
                     '>>>'
                   end
    # String to prepend to any error messages
    # @return [String] prefix for error messages
    ERROR_PREFIX = if $stderr.tty?
                     "#{PASTEL.bright_red('>>>', PASTEL.clear(''))}"
                   else
                     '>>>'
                   end

    # String to prepend to any intake messages
    # @return [String] prefix for intake messages
    INTAKE_PREFIX = if $stdout.tty?
                      "#{PASTEL.bright_blue('<<<', PASTEL.clear(''))}"
                    else
                      '<<<'
                    end

    protected

    # Prints a status message to the console
    # @param [String] message message to print to the console
    # @return [void]
    def status(message = '')
      $stdout.puts "#{STATUS_PREFIX} #{message}"
      nil
    end

    # Prints a debug message to the console
    # @param [String] message message to print to the console
    # @return [void]
    def debug(message = '')
      $stdout.puts "#{DEBUG_PREFIX} #{message}"
      nil
    end

    # Prints an error message to the console
    # @param [String] message message to print to the console
    # @return [void]
    def error(message = '')
      $stderr.puts "#{ERROR_PREFIX} #{message}"
      nil
    end

    # Prints an intake message to the console
    # @param [String] message message to print to the console
    # @return [void]
    def intake(message = '')
      status message
      $stdout.print "#{INTAKE_PREFIX} "
      nil
    end
  end
end