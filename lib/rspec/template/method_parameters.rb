# frozen_string_literal: true

module RSpec
  class Template
    class MethodParameters
      attr_reader :to_a

      def initialize(receiver:, method_scope:, method_name:)
        @receiver = receiver
        @method_scope = method_scope
        @method_name = method_name
        @to_a = _to_a
      end

      private

      def _to_a
        @receiver.
          __send__(@method_scope, @method_name).
          parameters.
          map { |it| ParameterFormatter.new(it) }.
          map(&:to_s).
          reject(&:empty?)
      end
    end
  end
end
