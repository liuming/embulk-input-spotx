
Gem::Specification.new do |spec|
  spec.name          = "embulk-input-spotx"
  spec.version       = "0.1.0"
  spec.authors       = ["Ming Liu"]
  spec.summary       = "Spotx API data input plugin for Embulk"
  spec.description   = "Loads records from Spotx API."
  spec.email         = ["liuming@lmws.net"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/liuming/embulk-input-spotx"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'http', '~> 3.0.0'

  #spec.add_dependency 'YOUR_GEM_DEPENDENCY', ['~> YOUR_GEM_DEPENDENCY_VERSION']
  spec.add_development_dependency 'embulk', ['>= 0.8.39']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
