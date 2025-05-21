RSpec.shared_context "with extended serializer" do
  subject(:hash_klass) do
    Class.new(Hashie::Mash) do
      include SnakyHash::Snake.new(key_type: :string, serializer: false)
      extend SnakyHash::Serializer # Should have the same effect as serializer: true.
    end
  end
end
