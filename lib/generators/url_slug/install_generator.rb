# frozen_string_literal: true

require_relative 'actions'

module UrlSlug
  module Generators
    class InstallGenerator < Thor::Group
      include Thor::Actions

      desc 'Install UrlSlug'
      argument :klass, type: :string

      include Actions

      namespace 'url_slug:install'
      class_option :path

      private

      def singular_name
        klass.singularize.downcase
      end

      def class_name
        klass
      end

      def class_file_path
        options[:path] || super
      end
    end
  end
end
