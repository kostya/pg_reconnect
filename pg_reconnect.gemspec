# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "pg_reconnect"
  gem.version       = "0.1.2"
  gem.authors       = ["'Konstantin Makarchev'"]
  gem.email         = ["'kostya27@gmail.com'"]
  gem.description   = %q{ActiveRecord PostgreSQL auto-reconnection, works with 2.3 and 3.2 rails.}
  gem.summary       = %q{ActiveRecord PostgreSQL auto-reconnection, works with 2.3 and 3.2 rails. Uses hackety wrapper on adapter execute. Ideal for using with pgbouncer and large number of almost idle connections (in threads).}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'activerecord', ">=2"
end
