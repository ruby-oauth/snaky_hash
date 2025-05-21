# frozen_string_literal: true

RSpec.describe SnakyHash::Snake do
  class TheSnakedHash < Hashie::Mash
    include SnakyHash::Snake.new(key_type: :string)
  end

  subject(:instance) do
    TheSnakedHash.new(base_hash)
  end

  include_context "base hash"

  it_behaves_like "a snaky hash instance"

  it "returns a SnakyHash::Snake from a snake + snake merge" do
    a = TheSnakedHash.new("asd" => "asd")
    b = TheSnakedHash.new(zxc: "zxc")
    expect(a.merge(b)).to be_a(TheSnakedHash)
  end

  it "returns a SnakyHash::Snake from a snake + hash merge" do
    a = TheSnakedHash.new("asd" => "asd")
    b = {zxc: "zxc"}
    expect(a.merge(b)).to be_a(TheSnakedHash)
  end

  it "returns a Hash from a hash + snake merge" do
    a = TheSnakedHash.new("asd" => "asd")
    b = {zxc: "zxc"}
    res = b.merge(a)
    expect(res).not_to be_a(TheSnakedHash)
    expect(res).to be_a(Hash)
  end

  context "when serializer: true" do
    let(:snaky_klass) do
      klass = Class.new(Hashie::Mash) do
        include SnakyHash::Snake.new(
          key_type: :symbol, # default :string
          serializer: true,   # default: false
        )
      end

      klass.load_hash_extensions.add(:non_zero_keys_to_int) do |value|
        if value.is_a?(Hash)
          value.transform_keys do |key|
            key_int = key.to_s.to_i
            if key_int > 0
              key_int
            else
              key
            end
          end
        else
          value
        end
      end

      klass
    end

    let(:snake) { snaky_klass.new(1 => "a", 0 => 4, "VeryFineHat" => {3 => "v", 5 => 7, :very_fine_hat => "feathers"}) }
    let(:dump) { snaky_klass.dump(snake) }
    let(:hydrated) { snaky_klass.load(dump) }

    it "can initialize" do
      expect(snake).to eq({1 => "a", 0 => 4, :very_fine_hat => {3 => "v", 5 => 7, :very_fine_hat => "feathers"}})
    end

    it "can dump" do
      expect(dump).to eq "{\"1\":\"a\",\"0\":4,\"very_fine_hat\":{\"3\":\"v\",\"5\":7,\"very_fine_hat\":\"feathers\"}}"
    end

    it "can load" do
      expect(hydrated).to eq({1 => "a", :"0" => 4, :very_fine_hat => {3 => "v", 5 => 7, :very_fine_hat => "feathers"}})
    end

    it "can access keys" do
      expect(hydrated["1"]).to be_nil
      expect(hydrated[1]).to eq("a")
      expect(hydrated["0"]).to eq(4)
      expect(hydrated[0]).to be_nil
      expect(hydrated.very_fine_hat).to eq({3 => "v", 5 => 7, :very_fine_hat => "feathers"})
      expect(hydrated.very_fine_hat.very_fine_hat).to eq("feathers")
      expect(hydrated.very_fine_hat[:very_fine_hat]).to eq("feathers")
      expect(hydrated.very_fine_hat["very_fine_hat"]).to eq("feathers")
    end
  end
end
