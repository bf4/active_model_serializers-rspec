# https://github.com/rails-api/active_model_serializers/issues/1470#issuecomment-181145809
module ActiveModelSerializers
  module Test
    module Serializer
      extend ActiveSupport::Concern

      def serializer_matches?(expectation)
        @assert_serializer.expectation = expectation
        @assert_serializer.message = message
        @assert_serializer.response = response
        @assert_serializer.matches?
      end

      def message
        @assert_serializer.message
      end

      RSpec::Matchers.define :use_serializer do |expected|
        match do |actual|
          serializer_matches?(expected)
        end
        failure_message do |actual|
          message
        end
      end
    end
  end
end
