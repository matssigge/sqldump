# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sqldump/version"

Gem::Specification.new do |s|
  s.name        = "sqldump"
  s.version     = Sqldump::VERSION
  s.authors     = ["Mats Sigge"]
  s.email       = ["mats.sigge@gmail.com"]
  s.homepage    = "http://github.com/matssigge/sqldump"
  s.summary     = %q{Dumps data as insert statements}
  s.description = %q{A command line tool to generate SQL insert or update statements from the data in a database.}

  # s.rubyforge_project = "sqldump"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency "dbi"
  s.add_dependency "dbd-sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "cucumber"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rb-fsevent" if RUBY_PLATFORM =~ /darwin/i
  s.add_development_dependency "dbd-pg"
end
