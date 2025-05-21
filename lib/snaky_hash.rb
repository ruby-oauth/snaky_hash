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

  class << self
    def load_extensions
      @load_extensions ||= Extensions.new
    end

    def dump_extensions
      @dump_extensions ||= Extensions.new
    end

    def load_hash_extensions
      @load_hash_extensions ||= Extensions.new
    end
  end
end

SnakyHash::Version.class_eval do
  extend VersionGem::Basic
end
