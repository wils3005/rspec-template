# frozen_string_literal: true

module Rspec
  class TemplateGenerator < Rails::Generators::Base
    argument :receiver, type: :string

    def run_template
      puts("\n#{RSpec::Template.new(receiver.classify.constantize)}\n")
    end
  end
end
