# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'carrierwave-document/version'

Gem::Specification.new do |gem|
  gem.name        = "carrierwave-document"
  gem.version     = Carrierwave::Document::VERSION
  gem.date        = Date.today
  gem.authors     = ["iicortex"]
  gem.email       = ["cortex@outlook.com"]
  gem.homepage    = "https://github.com/iicotex/carrierwave-document#readme"
  gem.summary     = %q{Carrierwave extension that uses docsplite to transcode documentgem.}
  gem.description = %q{Lets you make documents thumbnails in carrierwave via carrierwave-document.}
  
  #  gem.files         = `git ls-files`.split($/)
  #  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  #  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  #  gem.require_paths = ["lib"]

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_dependency "docsplit"
  gem.add_dependency "carrierwave"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"

  gem.requirements << 'ruby, version 1.9 or greater'
  gem.requirements << 'docsplite, version 0.6.4. or greater with GraphicsMagick, Ghostscript, OpenOffice, pdftk installed'
end