# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cacherite/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["itochan"]
  gem.email         = ["itochan315@gmail.com"]
  gem.description   = %q{caching gem}
  gem.summary       = %q{Simply and lite caching library.}
  gem.homepage      = "http://cacherite.ito315.com/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cacherite"
  gem.require_paths = ["lib"]
  gem.version       = Cacherite::VERSION
end
