# frozen_string_literal: true

module UrlSlug
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    def i18n_load_path
      ::I18n.load_path
    end

    def i18n_load_path=(value)
      ::I18n.load_path += value
    end
  end
end
