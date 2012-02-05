require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require "cucumber/rake/task"

RSpec::Core::RakeTask.new(:spec)

Cucumber::Rake::Task.new(:cucumber) do |task|
  task.cucumber_opts = ["features"]
end

task default: :spec
