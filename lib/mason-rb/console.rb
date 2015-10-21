module MasonRb
  # Contains logic for executing system commands.
  # @author Richard Harrah
  class Console

    protected

    def execute(command)
      if respond_to? 'debug'
        debug command.to_s
      end

      unless system(command.to_s)
        if respond_to? 'error'
          error "Command failed: #{command.to_s}"
        end
        abort
      end

      nil
    end

  end
end