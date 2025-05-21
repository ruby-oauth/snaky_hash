# frozen_string_literal: true


RSpec.shared_examples_for "a snaked hash" do
  context "when serializer: true" do
    subject(:serialized_hash_klass) do
      Class.new(Hashie::Mash) do
        include SnakyHash::Snake.new(key_type: :string, serializer: true)
      end
    end

    it_behaves_like "a serialized hash"

    context "when an instance" do
      subject(:instance) do
        serialized_hash_klass.new(base_hash)
      end

      include_context "base hash"

      it_behaves_like "a snaky hash instance"
    end
  end

  context "when serializer: false" do
    subject(:non_serialized_hash_klass) do
      Class.new(Hashie::Mash) do
        include SnakyHash::Snake.new(key_type: :string, serializer: false)
      end
    end

    it "does not respond_to load" do
      expect(non_serialized_hash_klass.respond_to?(:load)).to be_false
    end

    it "does not respond_to dump" do
      expect(non_serialized_hash_klass.respond_to?(:dump)).to be_false
    end

    context "when an instance" do
      subject(:instance) do
        non_serialized_hash_klass.new("apple" => "tart")
      end

      include_context "base hash"

      it_behaves_like "a snaky hash instance"
    end
  end
end
