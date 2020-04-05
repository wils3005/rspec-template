# frozen_string_literal: true

module RSpec
  class Template
    class ParameterFormatter
      attr_reader :to_s
      
      def initialize(parameter)
        @parameter_type, @parameter_name = parameter
        @to_s = _to_s
      end

      private

      def _to_s
        case @parameter_type
        when :req, :opt then @parameter_name.to_s
        when :rest then @parameter_name.to_s
        when :keyreq, :key then "#{@parameter_name}: #{@parameter_name}"
        when :keyrest then "#{@parameter_name}: **#{@parameter_name}"
        when :block then "&#{@parameter_name}"
        else ''
        end
      end
    end
  end
end
