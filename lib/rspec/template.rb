# frozen_string_literal: true

require_relative 'template/describe_method'
require_relative 'template/described_methods'
require_relative 'template/method_parameters'
require_relative 'template/parameter_formatter'
require_relative 'template/subject'

module RSpec
  class Template
    VERSION = '0.1.0'

    attr_reader :to_s

    def initialize(receiver)
      @receiver = receiver
      @method_parameters = _method_parameters
      @described_instance = _described_instance
      @described_methods = DescribedMethods.new(@receiver)
      @to_s = _to_s
    end

    private

    def _described_instance      
      return '' unless @receiver.respond_to?(:new)
      
      Subject.new(
        subject_name: 'described_instance',
        object_name: 'described_class',
        method_name: 'new',
        parameters: @method_parameters
      ).to_s.gsub(/^/, '  ')
    end

    def _method_parameters
      MethodParameters.new(
        receiver: @receiver,
        method_scope: :instance_method,
        method_name: 'initialize'
      )
    end

    def _to_s
      "# frozen_string_literal: true\n\nRSpec.describe #{@receiver} do\n" \
      "#{@described_instance}#{@described_methods}end\n"
    end
  end
end
