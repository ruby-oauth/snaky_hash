# A shared context that creates a hash class without serialization capabilities
#
# @example Using the shared context
#   RSpec.describe MyClass do
#     include_context "without serializer"
#     # ... rest of the spec
#   end
RSpec.shared_context "without serializer" do
  subject(:hash_klass) do
    Class.new(Hashie::Mash) do
      include SnakyHash::Snake.new(key_type: :string, serializer: false)
    end
  end
end
