RSpec.shared_context "with serializer" do
  subject(:hash_klass) do
    Class.new(Hashie::Mash) do
      include SnakyHash::Snake.new(key_type: :string, serializer: true)
    end
  end
end
