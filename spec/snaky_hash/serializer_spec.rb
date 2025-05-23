# frozen_string_literal: true

RSpec.describe SnakyHash::Serializer do
  context "when included via argument to SnakyHash::Snake" do
    include_context "with serializer"

    it_behaves_like "a serialized hash"

    describe "#dump" do
      subject(:instance) { hash_klass[hello: "World"] }

      after do
        hash_klass.dump_value_extensions.reset
        hash_klass.dump_hash_extensions.reset
      end

      it "returns a JSON string" do
        value = instance.dump
        expect(value).to eq '{"hello":"World"}'
      end
    end
  end

  context "when extended" do
    include_context "with extended serializer"

    describe "#dump" do
      subject(:instance) { hash_klass[hello: "World"] }

      after do
        hash_klass.dump_value_extensions.reset
        hash_klass.dump_hash_extensions.reset
      end

      it "returns a JSON string" do
        value = instance.dump
        expect(value).to eq '{"hello":"World"}'
      end
    end

    it_behaves_like "a serialized hash"
  end
end
