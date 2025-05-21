# frozen_string_literal: true

RSpec.describe SnakyHash::Serializer do
  context "when included via argument to SnakyHash::Snake" do
    include_context "with serializer"

    it_behaves_like "a serialized hash"
  end

  context "when extended" do
    include_context "with extended serializer"

    it_behaves_like "a serialized hash"
  end
end
