$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'unilevel_settlement/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'unilevel_settlement'
  spec.version     = UnilevelSettlement::VERSION
  spec.authors     = ['Kevin Liebholz']
  spec.email       = ['liebholz@crowddesk.de'] # TODO
  spec.homepage    = 'https://www.efairsorger.de' # TODO
  spec.summary     = 'Settle network marketing payouts for unilevel systems' # TODO
  spec.description = 'Settle network marketing payouts for unilevel systems' # TODO
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'" # TODO
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'cocoon' # nested forms
  spec.add_dependency 'hamlit' # haml files
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'rails', '>= 6.1.4.6'
  spec.add_dependency 'roo' # read excel files
  spec.add_dependency 'sass-rails', '>= 6' # use .sass instead of .css

  spec.add_development_dependency 'pg'
end
