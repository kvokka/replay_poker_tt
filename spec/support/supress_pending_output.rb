# frozen_string_literal: true

# Remove output from pending tests

module FormatterOverrides
  def example_pending(*); end

  def dump_pending(*); end
end

RSpec::Core::Formatters::ProgressFormatter.prepend FormatterOverrides
