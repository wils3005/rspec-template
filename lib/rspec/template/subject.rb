# frozen_string_literal: true

module RSpec
  class Template
    class Subject
      attr_reader :to_s

      def initialize(subject_name:, object_name:, method_name:, parameters: [])
        @subject_name = subject_name
        @object_name = object_name
        @method_name = method_name
        @parameters = Array(parameters)
        @foo = _foo
        @arguments, @lets = _arguments_lets
        @subject_body = "#{@object_name}.#{@method_name}#{@arguments}"
        @to_s = _to_s
      end

      private

      def _foo
        @parameters.to_a.map do |it|
          parameter_name = it[/\w+/]
          "let :#{parameter_name} do\n  double('#{parameter_name}')\nend\n\n"
        end.join
      end

      def _arguments_lets
        @parameters.any? ?
          ["(#{@parameters.join(', ')})", @foo] :
          ['', '']
      end

      def _to_s
        subject_body = "#{@object_name}.#{@method_name}#{@arguments}"
        subject = "subject :#{@subject_name} do\n  #{subject_body}\nend"
        "#{subject}\n\n#{@lets}"
      end
    end
  end
end
