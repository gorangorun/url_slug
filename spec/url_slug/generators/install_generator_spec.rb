# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UrlSlug::Generators::InstallGenerator, :generator do
  let(:generator) { described_class.new(*params) }
  let(:class_name) { 'Post' }
  let(:field) { 'title' }

  before do
    allow(generator).to receive(:class_file_path).and_return(file(class_filename))

    provide_existing_class(class_filename, class_name.downcase)

    capture_output { generator.invoke_all }
  end

  describe 'class file' do
    let(:params) { [[class_name, field]] }

    it 'includes UrlSlug module' do
      expect(class_content).to include('include UrlSlug')
    end

    it 'includes macro' do
      expect(class_content).to include("url_slug_for :#{field}")
    end
  end

  def class_filename
    "#{class_name.downcase}.rb"
  end

  def field_slug
    "#{field}_slug"
  end

  def class_content
    file_content(class_filename)
  end
end
