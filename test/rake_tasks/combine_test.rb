require File.expand_path('../helpers', File.dirname(__FILE__))
require 'nbmd_ps/rake_tasks/combine'
require 'rake'

# due to the nature of these Rake Tests, this should not be executed in a
# read-only filesystem or directory.
class NbmdPsRakeTaskCombineTest < Minitest::Test
  def test_define_wo_options
    paths = [input_schemas_path('rake_combine')]
    #output_file = output_schemas_path('rake_combine_with_options.json')
    output_file = nil
    File.delete(output_file) if File.exist?(output_file) if output_file
    NbmdPs::RakeTasks::Combine.new do |t|
      t.name = :combine_wo_options
      t.options[:meta] = input_schemas_path('rake-meta.json')
      t.paths.concat(paths)
      t.output_file = output_file
    end
    Rake::Task['combine_wo_options'].invoke
    assert File.exist?(output_file) if output_file
  end

  def test_define_with_options
    paths = [input_schemas_path('rake_combine')]
    #output_file = output_schemas_path('rake_combine_with_options.json')
    output_file = nil
    options = {
      meta: input_schemas_path('rake-meta.json')
    }
    File.delete(output_file) if File.exist?(output_file) if output_file
    NbmdPs::RakeTasks::Combine.new(name: :combine_with_options,
                                 paths: paths,
                                 output_file: output_file,
                                 options: options)
    Rake::Task['combine_with_options'].invoke
    assert File.exist?(output_file) if output_file
  end
end
