# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mason-rb/version'

Gem::Specification.new do |gem|
  gem.name = 'mason-rb'
  gem.version = MasonRb::VERSION

  gem.summary = 'A tool for generating new Ruby gems.'
  gem.description = 'A tool for generating new Ruby gems, under heavy development.'
  gem.licenses = ['MIT']
  gem.authors = ['Richard Harrah']
  gem.email = 'topplethenunnery@gmail.com'
  gem.homepage = 'https://nunnery.github.io/mason-rb'

  glob = lambda { |patterns| gem.files & Dir[*patterns] }

  gem.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  gem.require_paths = ['lib']
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.test_files = glob['{spec/{**/}*_spec.rb']
  gem.extra_rdoc_files = glob['*.{txt,rdoc}']

  gem.add_dependency 'commander', '~> 4.3'
  gem.add_dependency 'pastel', '~> 0.5'

  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'coveralls', '~> 0.8'
  gem.add_development_dependency 'fuubar', '~> 2.0'
  gem.add_development_dependency 'pry', '~> 0.10'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec', '~> 3.3'
  gem.add_development_dependency 'yard', '~> 0.8'
end