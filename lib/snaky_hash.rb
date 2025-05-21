# frozen_string_literal: true

# third party gems
require "hashie"
require "version_gem"

require_relative "snaky_hash/version"
require_relative "snaky_hash/extensions"
require_relative "snaky_hash/serializer"
require_relative "snaky_hash/snake"
require_relative "snaky_hash/string_keyed"
require_relative "snaky_hash/symbol_keyed"

# This is the namespace for this gem
module SnakyHash
  class Error < StandardError
  end
end

SnakyHash::Version.class_eval do
  extend VersionGem::Basic
end
