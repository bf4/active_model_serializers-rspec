$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "active_model_serializers/rspec"
require "pathname"

# The `.rspec` file also contains a few flags.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  # Skip specs tagged `:slow` unless SLOW_SPECS is set
  config.filter_run_excluding :slow unless ENV['SLOW_SPECS']
  # End specs on first failure if FAIL_FAST is set
  config.fail_fast = ENV.include?('FAIL_FAST')
  config.color = true
  config.disable_monkey_patching!
  config.expose_dsl_globally = false # No global "describe"
  # Allow more verbose output when running an individual spec file.
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
  config.profile_examples = 10 if ENV['PROFILE_SPECS'] =~ /true|0/
  if ENV['RANDOM'] =~ /true|0/
    config.order = :random
    # Seed global randomization in this process using the `--seed` CLI option.
    Kernel.srand config.seed
  end
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.include Module.new {
    def log(msg)
      RSpec.configuration.reporter.message "\n#{msg}\n"
    end
  }
  filter_gems_from_backtrace = []
  config.backtrace_exclusion_patterns << %r{gems/(#{filter_gems_from_backtrace.join('|')})}

  # :suite after/before all specs
  # :each every describe block
  # :all every it block
end
