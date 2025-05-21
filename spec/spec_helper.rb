# frozen_string_literal: true

# ensure test env
ENV["RACK_ENV"] = "test"

# Third Party Libraries
require "rspec/block_is_expected"
require "rspec/pending_for"
require "version_gem/ruby"
require "version_gem/rspec"

# Extensions
require_relative "ext/backports"

# Library Configs
require_relative "config/debug"

# RSpec Configs
require_relative "config/rspec/rspec_core"

require_relative "shared_contexts/base_hash"
require_relative "shared_examples/a_serialized_hash"
require_relative "shared_examples/a_snaked_hash"
require_relative "shared_examples/a_snaked_hash_instance"

# NOTE: Gemfiles for older rubies won't have kettle-soup-cover.
#       The rescue LoadError handles that scenario.
begin
  require "kettle-soup-cover"
  require "simplecov" if Kettle::Soup::Cover::DO_COV # `.simplecov` is run here!
rescue LoadError => error
  # check the error message, if you are so inclined, and re-raise if not what is expected
  raise error unless error.message.include?("kettle")
end

# This gem
require "snaky_hash"
