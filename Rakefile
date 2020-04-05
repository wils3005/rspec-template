# frozen_string_literal: true

require_relative 'lib/rspec/template'

task :default do
  system 'rake -T'
end

desc 'Build'
task :build do
  system 'gem build rspec-template.gemspec'
end

desc 'Install'
task :install do
  Rake::Task['build'].invoke
  system "gem install rspec-template-#{RSpec::Template::VERSION}.gem"
end
