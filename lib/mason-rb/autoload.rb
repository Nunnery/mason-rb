# Returns the expanded path to the specified file, auto-prepends source root
# @return [String] expanded path to file
# @private
def __p(path) File.join(MasonRb::ROOT, 'mason-rb', *path.split('/')); end

module MasonRb
  autoload :Console, __p('console')
  autoload :Printing, __p('printing')
end