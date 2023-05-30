# frozen_string_literal: true

require_relative 'lib/url_slug/version'

Gem::Specification.new do |spec|
  spec.name = 'url_slug'
  spec.version = UrlSlug::VERSION
  spec.authors = ['Goran Gjuroski']
  spec.email = ['gorang.pub@gmail.com']

  spec.summary = 'Yet another URL slug plugin.'
  spec.description = 'UrlSlug is a slug/permalink plugin with ActiveRecord and I18n support. It lets you create SEO friendly URLs.'
  spec.homepage = 'https://github.com/gorangorun/url_slug'
  spec.extra_rdoc_files = %w(LICENSE README.md)
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  spec.files = `git ls-files`.split("\n")
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 4.0.0'
  spec.add_dependency 'thor'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'i18n', '~> 1.13'
  spec.add_development_dependency 'railties', '>= 4.0'
  spec.add_development_dependency 'activerecord', '>= 4.0'
end
