# frozen_string_literal: true

RSpec.describe "a bad one" do
  subject(:bad_snake) do
    Class.new(Hashie::Mash) do
      include SnakyHash::Snake.new(key_type: :slartibartfarst)
    end
  end

  it "raises an error" do
    block_is_expected.to raise_error(ArgumentError)
  end
end
