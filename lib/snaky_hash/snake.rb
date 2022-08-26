require "hashie/mash"

module SnakyHash
  class Snake < Hashie::Mash
    # This is similar to the functionality we want.
    # include Hashie::Extensions::Mash::SymbolizeKeys

    protected

    # Converts a key to a string,
    #   but only if it is able to be converted to a symbol.
    #
    # @api private
    # @param [<K>] key the key to attempt convert to a symbol
    # @return [String, K]
    def convert_key(key)
      key.respond_to?(:to_sym) ? underscore_string(key.to_s) : key
    end

    # Unlike its parent Mash, a SnakyHash::Snake will convert other
    #   Hashie::Hash values to a SnakyHash::Snake when assigning
    #   instead of respecting the existing subclass
    def convert_value(val, duping = false) #:nodoc:
      case val
      when self.class
        val.dup
      when ::Hash
        val = val.dup if duping
        self.class.new(val)
      when ::Array
        val.collect { |e| convert_value(e) }
      else
        val
      end
    end

    # converts a camel_cased string to a underscore string
    # subs spaces with underscores, strips whitespace
    # Same way ActiveSupport does string.underscore
    def underscore_string(str)
      str.to_s.strip
         .tr(" ", "_")
         .gsub(/::/, "/")
         .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
         .gsub(/([a-z\d])([A-Z])/, '\1_\2')
         .tr("-", "_")
         .squeeze("_")
         .downcase
    end
  end
end
