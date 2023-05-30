# frozen_string_literal: true

require 'active_support/concern'
require 'active_support/inflector'
require 'byebug'

module UrlSlug
  module Generators
    module Actions
      extend ActiveSupport::Concern

      included do
        argument :fields, type: :string

        def include_module_into_class
          puts "#{class_file_path} not found" unless class_exists?
          puts "Module already included in #{class_file_path}" if class_exists? && module_included?

          inject_into_file(
            class_file_path,
            "  include UrlSlug\n",
            after: /^class #{class_name}[^\n]*\n/
          )
        end

        def inject_macro_into_class
          puts "#{class_file_path} not found" unless class_exists?
          puts "Macro url_slug_for already included in #{class_file_path}" if class_exists? && macro_included?

          inject_into_file(
            class_file_path,
            build_macro,
            after: /^  include UrlSlug\n/
          )
        end
      end

      private

      def class_file_path
        "#{singular_name}.rb"
      end

      def class_exists?
        File.exist?(class_file_path)
      end

      def module_included?
        File.read(class_file_path).include?('include UrlSlug')
      end

      def macro_included?
        File.read(class_file_path).include?("url_slug_for :#{slug_for}")
      end

      def slug_for
        @slug_for ||= fields.split(':').first
      end

      def attr
        @attr ||= fields.split(':')[1]
      end

      def build_macro
        macro = '  url_slug_for '
        macro += ":#{slug_for}"
        macro += ", attr: :#{attr}" if attr.present?
        macro += "\n"
        macro
      end
    end
  end
end
