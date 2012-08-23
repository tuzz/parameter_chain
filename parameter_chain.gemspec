Gem::Specification.new do |s|
  s.name        = 'parameter_chain'
  s.version     = '0.0.1'
  s.summary     = 'Parameter Chain'
  s.description = 'Chain methods to specify parameters'
  s.author      = 'Christopher Patuzzo'
  s.email       = 'chris@patuzzo.co.uk'
  s.files       = ['README.md'] + Dir['lib/**/*.*']
  s.homepage    = 'https://github.com/cpatuzzo/parameter_chain'

  s.add_development_dependency 'rspec'
end
