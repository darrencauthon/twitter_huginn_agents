require "bundler/gem_tasks"
require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['spec/twitter_huginn_agents/*_spec.rb', 'spec/*_spec.rb']
  t.verbose = true
end

