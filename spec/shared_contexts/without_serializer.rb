RSpec.shared_context "without serializer" do
  subject(:hash_klass) do
    Class.new(Hashie::Mash) do
      include SnakyHash::Snake.new(key_type: :string, serializer: false)
    end
  end
end
