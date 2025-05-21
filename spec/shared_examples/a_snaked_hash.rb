# frozen_string_literal: true

RSpec.shared_examples_for "a snaked hash" do
  context "when serializer: true" do
    include_context "with serializer"

    it "does respond_to load" do
      expect(hash_klass.respond_to?(:load)).to be(true)
    end

    it "does respond_to dump" do
      expect(hash_klass.respond_to?(:dump)).to be(true)
    end

    it_behaves_like "a serialized hash"

    context "when an instance" do
      subject(:instance) do
        hash_klass.new(base_hash)
      end

      include_context "base hash"

      it_behaves_like "a snaky hash instance"
    end
  end

  context "when serializer: false" do
    include_context "without serializer"

    it "does not respond_to load" do
      expect(hash_klass.respond_to?(:load)).to be(false)
    end

    it "does not respond_to dump" do
      expect(hash_klass.respond_to?(:dump)).to be(false)
    end

    context "when an instance" do
      subject(:instance) do
        hash_klass.new("apple" => "tart")
      end

      include_context "base hash"

      it_behaves_like "a snaky hash instance"
    end
  end
end
