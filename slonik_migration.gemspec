# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slonik_migration/version'

Gem::Specification.new do |spec|
  spec.name          = "slonik_migration"
  spec.version       = SlonikMigration::VERSION
  spec.authors       = ["Yoshikazu Kaneta"]
  spec.email         = ["kaneta@sitebridge.co.jp"]
  spec.summary       = %q{A rails migration gem for slony}
  spec.description   = %q{A rails migration gem for slony using slonik_execute_script command}
  spec.homepage      = "https://github.com/kanety/slonik_migration"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 5.0"

  spec.add_development_dependency "rails", ">= 5.0"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "simplecov"
end
