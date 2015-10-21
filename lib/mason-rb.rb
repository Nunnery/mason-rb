require 'mason-rb/version'

# Contains all of the modules and classes relevant to mason-rb.
# @author Richard Harrah
module MasonRb
  # The root path for mason-rb source code files.
  # @return [String] path to source code files
  ROOT = File.expand_path(File.dirname(__FILE__))
end

# Require all Ruby core extension classes automagically
Dir.glob(File.join(MasonRb::ROOT, 'mason-rb', 'core_ext', '*.rb')).each do |file|
  require file
end

# Require autoload classes in order to ease compatibility
['autoload'].each do |file|
  require File.join(MasonRb::ROOT, 'mason-rb', file)
end