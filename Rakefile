# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'rake/dsl_definition'

require File.expand_path('../config/application', __FILE__)
require 'rake'

Thinner::Application.load_tasks

desc "Task for the travis CI service http://travis-ci.org"
task :travis => ['db:drop', 'db:create', 'db:migrate', 'spec', 'cucumber']
