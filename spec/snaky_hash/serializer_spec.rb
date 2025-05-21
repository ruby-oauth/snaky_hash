# frozen_string_literal: true

RSpec.describe SnakyHash::Serializer do
  subject(:serialized_hash_klass) do
    Class.new(Hashie::Mash) do
      include SnakyHash::Snake.new(key_type: :string)
      extend SnakyHash::Serializer
    end
  end

  it_behaves_like "a serialized hash"
end
