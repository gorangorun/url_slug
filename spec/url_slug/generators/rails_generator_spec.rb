# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UrlSlug::Generators::RailsGenerator, :generator do
  let(:generator) { described_class.new(*params) }
  let(:class_name) { 'Post' }
  let(:field) { 'title' }
  let(:migration_number) { '00000000000000' }

  before do
    stub_const('MODEL_DIR', 'app/models')
    stub_const('MIGRATION_DIR', 'db/migrate')

    allow(generator).to receive(:class_file_path).and_return(file(class_path))
    allow(generator).to receive(:migration_path).and_return('tmp/db/migrate')
    allow(generator).to receive(:table_exists?).and_return(true)
    allow(generator).to receive(:migration_version).and_return('7.0')
    allow(described_class).to receive(:next_migration_number).and_return(migration_number)

    provide_existing_class(class_path, class_name.downcase)

    capture_output { generator.invoke_all }
  end

  describe 'class file' do
    let(:params) { [[class_name, field]] }

    xit 'check syntaxt' do
    end

    it 'includes UrlSlug module' do
      expect(file_content(class_path)).to include('include UrlSlug')
    end

    it 'includes macro' do
      expect(file_content(class_path)).to include("url_slug_for :#{field}")
    end

    it 'doesnt generate migration file' do
      expect(migration_exists?).to be(false)
    end
  end

  describe 'migration file' do
    let(:params) { [[class_name, field], { migration: true }] }

    it 'generates migration file' do
      expect(migration_exists?).to be(true)
    end

    it 'contains add_column' do
      result = "add_column :#{plural_name}, :#{field_slug}, :string"
      expect(file_content(migration_path)).to include(result)
    end
  end

  def plural_name
    class_name.downcase.pluralize
  end

  def field_slug
    "#{field}_slug"
  end

  def class_filename
    "#{class_name.downcase}.rb"
  end

  def class_path
    File.join(MODEL_DIR, class_filename)
  end

  def migration_filename
    "#{migration_number}_add_#{field_slug}_to_#{plural_name}.rb"
  end

  def migration_path
    File.join(MIGRATION_DIR, migration_filename)
  end

  def migration_exists?
    file_exists?(migration_path)
  end
end
