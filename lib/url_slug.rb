# frozen_string_literal: true

require 'url_slug/version'
require 'url_slug/configuration'
require 'active_support/inflector'
require 'active_support/concern'

module UrlSlug
  include ActiveSupport::Inflector
  extend ActiveSupport::Concern

  class_methods do
    def url_slug_for(name, args = {})
      slug_name = args[:attr] || "#{name}_slug"

      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{slug_name}
          defined?(super) ? super : @#{slug_name}
        end

        def #{slug_name}=(value)
          return if value.nil?
          defined?(super) ? super(value.parameterize) : @#{slug_name} = value.parameterize
        end

        def #{name}=(value)
          self.#{slug_name} = value
          defined?(super) ? super(value) : @#{name} = value
        end
      CODE
    end
  end
end
