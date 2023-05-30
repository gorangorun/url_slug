# frozen_string_literal: true

require 'byebug'

RSpec.describe UrlSlug do
  let(:klass) do
    Class.new do
      include UrlSlug

      attr_accessor :title

      url_slug_for :title, persistence: false
    end
  end

  let(:instance) { klass.new }

  it 'has a version number' do
    expect(UrlSlug::VERSION).not_to be nil
  end

  it 'defines the slug_name reader' do
    expect(instance.respond_to?(:title_slug)).to be true
  end

  it 'defines the slug_name writer' do
    expect(instance.respond_to?(:title_slug=)).to be true
  end

  it 'parameterizes slug' do
    instance.title = 'foo bar'
    expect(instance.title_slug).to eq('foo-bar')
  end

  it 'does not parameterize slug for empty string' do
    expect(instance.title_slug).to eq(nil)
  end

  describe 'With i18n support' do
    before do
      described_class.configure do |config|
        config.i18n_load_path = Dir[File.join('spec/support/locales', '**/*.*')]
      end
    end

    it 'parameterizes and transliterates slug' do
      I18n.available_locales = %i[en mk]

      I18n.with_locale(:mk) do
        instance.title = 'фоо бар'
        expect(instance.title_slug).to eq('foo-bar')
      end
    end
  end
end
