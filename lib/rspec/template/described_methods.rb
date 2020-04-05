# frozen_string_literal: true

module RSpec
  class Template
    class DescribedMethods
      attr_reader :to_s

      def initialize(receiver)
        @receiver = receiver
        @class_methods = _class_methods
        @instance_methods = _instance_methods
        @to_s = _to_s
      end

      private

      def _class_methods
        @receiver.public_methods.sort.map do |it|
          DescribeMethod.new(
            receiver: @receiver, 
            method_scope: :method, 
            method_name: it
          )
        end
      end

      def _instance_methods
        @receiver.public_instance_methods.tap(&:sort!).map do |it|
          DescribeMethod.new(
            receiver: @receiver, 
            method_scope: :instance_method, 
            method_name: it
          )
        end
      end

      def _to_s
        [*@class_methods, *@instance_methods].
          map(&:to_s).
          reject(&:empty?).
          join("\n").
          gsub(/^/, '  ')
      end
    end
  end
end
