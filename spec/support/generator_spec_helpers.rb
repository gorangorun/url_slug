# frozen_string_literal: true

module GeneratorSpecHelpers
  TMP_DIR = File.expand_path('tmp')

  def file(filename)
    File.join(TMP_DIR, filename)
  end

  def file_content(filename)
    File.read(file(filename))
  end

  def file_exists?(filename)
    File.exist?(file(filename))
  end

  def provide_existing_class(class_file, class_name)
    copy_to_generator_tmp(template_class(class_name), file(class_file))
  end

  def prepare_destination
    FileUtils.rm_rf(Dir[File.join(TMP_DIR, '*')])
  end

  def capture_output
    original_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original_stdout
  end

  private

  def copy_to_generator_tmp(template, destination)
    FileUtils.mkdir_p(File.dirname(destination))
    FileUtils.cp(template, destination)
  end

  def template_class(class_name)
    File.expand_path("spec/support/#{class_name}")
  end
end

RSpec.configure do |config|
  config.include GeneratorSpecHelpers

  config.after(:example, :generator) do
    prepare_destination
  end
end
