require "json-schema"
# https://github.com/rails-api/active_model_serializers/issues/1470#issuecomment-180182025
RSpec.configuration do |config|
  config.include Module {
    include ActiveModelSerializers::Test::Schema
    private def assert(bool, failure_message)
      return if bool
      RSpec.configuration.reporter.message failure_message
      expect(bool).to eq(true)
    end
  }
end

# via https://github.com/rails-api/active_model_serializers/issues/1011#issuecomment-127608121
# Json schema matcher
# Schema files should be placed at spec/support/fixtures/
#
# @example validate json against bundles.json schema
#   expect(json).to match_json_schema('bundles/show')
#
# @example it's also possible to validate test response
#   get :show, id: 664
#   is_expected.to match_json_schema('bundles/show')
#
RSpec::Matchers.define :match_json_schema do |against|
  match do |object_to_be_validated|
    file_name = Rails.root.join('json_schemas', "#{against}.json").to_s

    fail "Could not find schema file #{file_name}" unless File.exist?(file_name)

    @errors = validate(file_name, object_to_be_validated)

    return true if @errors.empty?
  end

  failure_message do
    @errors.join("\n")
  end

  private

  def validate(file_name, response_or_json)
    json = if response_or_json.is_a?(ActionController::TestResponse)
             JSON.parse(response_or_json.body).with_indifferent_access
           else
             response_or_json
           end

    JSON::Validator.fully_validate(file_name, json)
  end

