# frozen_string_literal: true

require 'faker'
require_relative 'lib/rspec/template'

Gem::Specification.new do |it|
  it.name = 'rspec-template'
  it.version = RSpec::Template::VERSION
  it.date = Time.now.utc.strftime('%Y-%m-%d')
  it.author = 'Jack Wilson'
  it.email = 'wils3005@gmail.com'
  it.summary = Faker::Lorem.paragraph
  it.description = Faker::Lorem.paragraph(sentence_count: 5)
  it.homepage = 'https://github.com/wils3005/rspec-template'
  it.license = 'ISC'
  it.required_ruby_version = '>= 2.4.5'

  it.files =
    Dir.
    glob(File.join(Dir.pwd, '**', '*.rb')).
    map { |it| it[%r{(?<=#{Dir.pwd}/).+}] }
end
