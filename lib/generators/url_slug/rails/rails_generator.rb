# frozen_string_literal: true

require 'rails/generators/named_base'
require 'rails/generators/active_record'
require_relative '../actions'

module UrlSlug
  module Generators
    class RailsGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration
      include Actions
      source_root File.expand_path('templates', __dir__)

      class_option :migration, type: :boolean

      def create_url_slug_migration
        return unless include_migration?

        if table_exists?
          create_add_slug_to_table_migration
        else
          puts "#{table_name} table does not exists"
        end
      end

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

      private

      def create_add_slug_to_table_migration
        config = {
          migration_version: migration_version,
          column: slug_attr,
          table: table_name
        }

        migration_template(
          'db/migrate/add_slug_to_table.rb.erb',
          File.join(migration_path, "add_#{slug_attr}_to_#{plural_name}.rb"),
          config
        )
      end

      def class_file_path
        "app/models/#{super}"
      end

      def migration_path
        'db/migrate'
      end

      def include_migration?
        options.key?(:migration)
      end

      def table_exists?
        ActiveRecord::Base.connection.data_source_exists?(table_name)
      end

      def slug_attr
        attr.present? ? attr : "#{slug_for}_slug"
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end
    end
  end
end
