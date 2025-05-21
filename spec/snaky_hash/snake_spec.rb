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

      klass.load_hash_extensions.add(:keys_are_based) do |value|
        if value.is_a?(Hash)
          value.keys.sort.each_with_index do |key, index|
            key_int = key.to_s.to_i
            ref = value.delete(key)
            encoded_key = if key_int > 0
              # See: https://idiosyncratic-ruby.com/4-what-the-pack.html#m0--base64-encoding-rfc-4648
              "dog-#{index}"
            else
              "cat-#{index}"
            end
            value[encoded_key] = ref
          end
        end
        value
      end

      klass
    end

    let(:snake) { snaky_klass.new("1" => "a", "0" => 4, "VeryFineHat" => {"3" => "v", "5" => 7, :very_fine_hat => "feathers"}) }
    let(:dump) { snaky_klass.dump(snake) }
    let(:hydrated) { snaky_klass.load(dump) }

    it "can initialize" do
      expect(snake).to eq({"0": 4, "1": "a", very_fine_hat: {"3": "v", "5": 7, very_fine_hat: "feathers"}})
    end

    it "can dump" do
      expect(dump).to eq "{\"1\":\"a\",\"0\":4,\"very_fine_hat\":{\"3\":\"v\",\"5\":7,\"very_fine_hat\":\"feathers\"}}"
    end

    it "can load" do
      expect(hydrated).to eq(
        {
          dog_1: "a",
          cat_0: 4,
          cat_2: {
            dog_0: "v",
            dog_1: 7,
            cat_2: "feathers",
          },
        },
      )
    end

    it "can access keys" do
      expect(hydrated["1"]).to be_nil
      expect(hydrated[1]).to be_nil
      expect(hydrated["dog_1"]).to eq("a")
      expect(hydrated[:dog_1]).to eq("a")
      expect(hydrated.dog_1).to eq("a")
      expect(hydrated["0"]).to be_nil
      expect(hydrated[0]).to be_nil
      expect(hydrated["cat_0"]).to eq(4)
      expect(hydrated[:cat_0]).to eq(4)
      expect(hydrated.cat_0).to eq(4)
      expect(hydrated.very_fine_hat).to be_nil
      expect(hydrated.cat_2).to eq({cat_2: "feathers", dog_0: "v", dog_1: 7})
      expect(hydrated.cat_2.cat_2).to eq("feathers")
      expect(hydrated.cat_2["cat_2"]).to eq("feathers")
      expect(hydrated.cat_2[:cat_2]).to eq("feathers")
      expect(hydrated.cat_2.dog_0).to eq("v")
      expect(hydrated.cat_2.dog_1).to eq(7)
    end
  end
end
