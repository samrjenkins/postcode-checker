# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task default: %i[rubocop spec yalphabetize]

require 'rubocop/rake_task'
desc 'Run rubocop'
task rubocop: :environment do
  RuboCop::RakeTask.new
end

desc 'Run yalphabetize'
task yalphabetize: :environment do
  system('bundle exec yalphabetize')
end
