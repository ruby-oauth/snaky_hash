# frozen_string_literal: true

require "json"
require "version_gem/ruby"

module SnakyHash
  module Serializer
    class << self
      def extended(base)
        extended_module = Modulizer.to_extended_mod
        base.extend(extended_module)
        # :nocov:
        # This will be run in CI on Ruby 2.3, but we only collect coverage from current Ruby
        unless VersionGem::Ruby.gte_minimum_version?("2.4")
          base.include(BackportedInstanceMethods)
        end
        # :nocov:
      end
    end

    def dump(obj)
      hash = dump_hash(obj)
      hash.to_json
    end

    def load(raw_hash)
      hash = JSON.parse(presence(raw_hash) || "{}")
      hash = load_hash(hash)
      new(hash)
    end

    module Modulizer
      class << self
        def to_extended_mod
          Module.new do
            define_method :load_extensions do
              @load_extensions ||= Extensions.new
            end

            define_method :dump_extensions do
              @dump_extensions ||= Extensions.new
            end

            define_method :load_hash_extensions do
              @load_hash_extensions ||= Extensions.new
            end
          end
        end
      end
    end

    module BackportedInstanceMethods
      # :nocov:
      # This will be run in CI on Ruby 2.3, but we only collect coverage from current Ruby
      # Rails <= 5.2 had a transform_values method, which was added to Ruby in version 2.4.
      # This method is a backport of that original Rails method for Ruby 2.2 and 2.3.
      def transform_values(&block)
        return enum_for(:transform_values) { size } unless block_given?
        return {} if empty?
        result = self.class.new
        each do |key, value|
          result[key] = yield(value)
        end
        result
      end
      # :nocov:
    end

  private

    def blank?(value)
      return true if value.nil?
      return true if value.is_a?(String) && value.empty?

      false
    end

    def presence(value)
      blank?(value) ? nil : value
    end

    def dump_hash(hash)
      hash = hash.transform_values do |value|
        dump_value(value)
      end
      hash.reject { |_, v| blank?(v) }
    end

    def dump_value(value)
      if blank?(value)
        return
      end

      if value.is_a?(::Hash)
        return dump_hash(value)
      end

      if value.is_a?(::Array)
        return value.map { |v| dump_value(v) }.compact
      end

      dump_extensions.run(value)
    end

    def load_hash(hash)
      # The hash will be a raw hash, not a hash of this class.
      # So first we make it a hash of this class.
      self[hash].transform_values do |value|
        load_value(value)
      end
    end

    def load_value(value)
      if value.is_a?(::Hash)
        hash = load_hash_extensions.run(value)

        # If the result is still a hash, we'll return that here
        return load_hash(hash) if hash.is_a?(::Hash)

        # If the result is not a hash, we'll just return whatever
        # was returned as a normal value.
        return load_value(hash)
      end

      return value.map { |v| load_value(v) } if value.is_a?(Array)

      load_extensions.run(value)
    end
  end
end
