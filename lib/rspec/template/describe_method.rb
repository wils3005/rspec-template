# frozen_string_literal: true

module RSpec
  class Template
    class DescribeMethod
      CONTEXT =
        "context 'when called' do\n" \
        "  it 'does not raise an error' do\n" \
        "    expect { described_method }.not_to(raise_error)\n" \
        "  end\n" \
        "end"

      INVALID_SOURCE_LOCATION = %r{/(ruby|gems)/\d\.\d\.\d/}.freeze

      attr_reader :to_s

      def initialize(receiver:, method_scope:, method_name:)
        @receiver = receiver
        @method_scope = method_scope
        @method_name = method_name
        @method_object = @receiver.__send__(@method_scope, @method_name)
        @prefix = @method_scope == 'method' ? '.' : '#'
        @object_name = _object_name
        @method_parameters = _method_parameters
        @subject = _subject
        @context = CONTEXT
        @body = "#{@subject}#{@context}".gsub(/^/, '  ')
        @to_s = _to_s
      end

      private

      def _object_name
        @method_scope == 'method' ? 'described_class' : 'described_instance'
      end

      def _method_parameters
        MethodParameters.new(
          receiver: @receiver,
          method_scope: @method_scope,
          method_name: @method_name
        )
      end

      def _subject
        Subject.new(
          subject_name: 'described_method',
          object_name: @object_name,
          method_name: @method_name,
          parameters: @method_parameters
        )
      end

      def _to_s
        source_location = @method_object.source_location.to_s
        return '' if source_location.empty? || source_location.match(INVALID_SOURCE_LOCATION)
          
        "describe '#{@prefix}#{@method_name}' do\n#{@body}\nend\n"
      end
    end
  end
end
