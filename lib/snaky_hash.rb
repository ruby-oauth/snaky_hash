# frozen_string_literal: true

# third party gems
require "hashie"
require "version_gem"

require_relative "snaky_hash/version"
require_relative "snaky_hash/snake"

module SnakyHash
end

SnakyHash::Version.class_eval do
  extend VersionGem::Basic
end
