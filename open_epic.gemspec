Gem::Specification.new do |s|
  s.name        = 'open_epic'
  s.version     = '0.1.0'
  s.date        = '2018-04-10'
  s.summary     = "Client for Open Epic"
  s.authors     = ["Alessio Signorini"]
  s.email       = 'alessio@signorini.us'
  s.files       = ["lib/open_epic.rb"]
  s.homepage    =
    'http://rubygems.org/gems/hola'
  s.license       = 'MIT'

  s.add_runtime_dependency 'oauth2', '~> 1.4', '>= 1.4.0'
  s.add_runtime_dependency 'fhir_client', '~> 3.0', '>= 3.0.4'
end
