# frozen_string_literal: true

module SnakyHash
  class Extensions
    def initialize
      reset
    end

    def reset
      @extensions = {}
    end

    def add(name, &block)
      if has?(name)
        raise Error, "Extension already defined named '#{name}'"
      end

      @extensions[name.to_sym] = block
    end

    def has?(name)
      @extensions.key?(name.to_sym)
    end

    def run(value)
      @extensions.each_value do |block|
        value = block.call(value)
      end
      value
    end
  end
end
