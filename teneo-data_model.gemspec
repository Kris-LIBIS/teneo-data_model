$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'teneo/data_model/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'teneo-data_model'
  s.version     = Teneo::DataModel::VERSION
  s.authors     = ['Kris Dekeyser']
  s.email       = ['kris.dekeyser@libis.be']
  s.homepage    = 'https://github.com/Kris-LIBIS/teneo-data_model'
  s.summary     = 'ActiveRecord data model for Teneo.'
  s.description = 'Rails engine containing an ActiveRecord implementation of the libis-workflow data model for Teneo.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2.1'
  s.add_dependency 'libis-tools', '~> 1.0'
  s.add_dependency 'libis-workflow', '~> 2.0'
  s.add_dependency 'devise'
  s.add_dependency 'devise-jwt'
  s.add_dependency 'rack-cors'
  s.add_dependency 'tty-prompt'
  s.add_dependency 'tty-spinner'

  s.add_development_dependency 'pg'
end
