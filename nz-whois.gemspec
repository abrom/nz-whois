lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'nz-whois/gem_version'

Gem::Specification.new do |spec|
  spec.name          = 'nz-whois'
  spec.version       = NZWhois::VERSION
  spec.author        = 'abrom'
  spec.email         = 'a.bromwich@gmail.com'

  spec.summary       = 'NZ WHOIS scraper'
  spec.description   = 'New Zealand WHOIS registry scraper'
  spec.homepage      = 'https://github.com/abrom/nz-whois'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|docs)/})
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nokogiri', '~> 1.0', '>= 1.6.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.52'
  spec.add_development_dependency 'simplecov', '~> 0.15'
  spec.add_development_dependency 'webmock', '~> 3.2'
end
