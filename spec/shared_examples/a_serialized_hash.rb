RSpec.shared_examples_for "a serialized hash" do
  describe "::dump" do
    after do
      subject.dump_value_extensions.reset
      subject.dump_hash_extensions.reset
    end

    it "returns a JSON string" do
      value = subject.dump({hello: "World"})
      expect(value).to eq '{"hello":"World"}'
    end

    it "does not remove nil values" do
      value = subject.dump({hello: "World", nilValue: nil})
      expect(value).to eq "{\"hello\":\"World\",\"nil_value\":null}"
    end

    it "does not remove empty strings" do
      value = subject.dump({hello: "World", nilValue: ""})
      expect(value).to eq "{\"hello\":\"World\",\"nil_value\":\"\"}"
    end

    it "does not remove false" do
      value = subject.dump({hello: "World", falseValue: false})
      expect(value).to eq '{"hello":"World","false_value":false}'
    end

    it "removes any empty items from top-level arrays" do
      value = subject.dump({hello: "World", array: [nil, 1, 2, "", false]})
      expect(value).to eq '{"hello":"World","array":[1,2,"",false]}'
    end

    it "passes through any extensions that have been added" do
      subject.dump_extensions.add(:test) { |value| value.upcase }
      value = subject.dump({hello: "WORLD"})
      expect(value).to eq '{"hello":"WORLD"}'
    end

    it "works with nested hashes" do
      subject.dump_extensions.add(:test) { |value| value.is_a?(String) ? value.upcase : value }
      value = subject.dump({hello: "world", nested: {vegetable: "potato", more_nesting: {fruit: "banana"}}})
      expect(value).to eq '{"hello":"WORLD","nested":{"vegetable":"POTATO","more_nesting":{"fruit":"BANANA"}}}'
    end

    it "works with nested hashes in arrays" do
      subject.dump_extensions.add(:test) { |value| value.is_a?(String) ? value.upcase : value }
      value = subject.dump({hello: "world", nested: {vegetables: [{name: "potato"}, {name: "cucumber"}], more_nesting: {fruits: [{name: "banana"}, {name: "apple"}]}}})
      expect(value).to eq '{"hello":"WORLD","nested":{"vegetables":[{"name":"POTATO"},{"name":"CUCUMBER"}],"more_nesting":{"fruits":[{"name":"BANANA"},{"name":"APPLE"}]}}}'
    end
  end

  describe "::load" do
    after do
      subject.load_value_extensions.reset
      subject.load_hash_extensions.reset
    end

    it "creates a Hashie::Mash from the given JSON" do
      hash = subject.load('{"hello":"world"}')
      expect(hash).to be_a Hashie::Mash
      expect(hash["hello"]).to eq "world"
    end

    it "creates an empty Mash if the given value is nil" do
      hash = subject.load(nil)
      expect(hash).to be_a Hashie::Mash
      expect(hash).to be_empty
    end

    it "creates a hash with nil value" do
      hash = subject.load('{"myCount":null}')
      expect(hash).to be_a Hashie::Mash
      expect(hash["myCount"]).to be_nil
    end

    it "creates a hash with empty value" do
      hash = subject.load('{"myCount":""}')
      expect(hash).to be_a Hashie::Mash
      expect(hash["myCount"]).to eq("")
    end

    it "creates a hash with 0 value" do
      hash = subject.load('{"myCount":0}')
      expect(hash).to be_a Hashie::Mash
      expect(hash["myCount"]).to eq(0)
    end

    it "creates an empty Mash if the JSON is an empty string" do
      hash = subject.load("")
      expect(hash).to be_a Hashie::Mash
      expect(hash).to be_empty
    end

    it "passes through any extensions that have been added" do
      subject.load_extensions.add(:test) { |value| value.upcase }
      hash = subject.load('{"hello":"world"}')
      expect(hash).to be_a Hashie::Mash
      expect(hash["hello"]).to eq "WORLD"
    end

    it "works with nested hashes" do
      subject.load_extensions.add(:test) { |value| value.is_a?(String) ? value.downcase : nil }
      hash = subject.load('{"hello":"WORLD","nested":{"vegetable":"POTATO","more_nesting":{"fruit":"BANANA"}}}')
      expect(hash).to be_a Hashie::Mash
      expect(hash).to eq({"hello" => "world", "nested" => {"vegetable" => "potato", "more_nesting" => {"fruit" => "banana"}}})
    end

    it "works with nested hashes in arrays" do
      subject.load_extensions.add(:test) { |value| value.is_a?(String) ? value.downcase : nil }
      hash = subject.load('{"num":3,"hello":"WORLD","nested":{"vegetables":[{"name":"POTATO"},{"name":"CUCUMBER"}],"more_nesting":{"fruits":[{"name":"BANANA"},{"name":"APPLE"}]}}}')
      expect(hash).to be_a Hashie::Mash
      expect(hash).to eq({"num" => nil, "hello" => "world", "nested" => {"vegetables" => [{"name" => "potato"}, {"name" => "cucumber"}], "more_nesting" => {"fruits" => [{"name" => "banana"}, {"name" => "apple"}]}}})
    end

    it "is unable to upcase keys, because instantiation of a SnakyHash downcases keys" do
      subject.load_hash_extensions.add(:test) { |value|
        if value.is_a?(Hash)
          value.transform_keys(&:upcase)
        else
          value
        end
      }
      hash = subject.load('{"some_hash":{"name":"Michael"}}')
      expect(hash).to be_a Hashie::Mash
      expect(hash).to eq({"some_hash" => {"name" => "Michael"}})
    end

    it "passes through hashes through their own extensions" do
      subject.load_hash_extensions.add(:test) { |value|
        if value.is_a?(Hash)
          value.transform_keys(&:next)
        else
          value
        end
      }
      hash = subject.load('{"some_hash":{"name":"Michael"}}')
      expect(hash).to be_a Hashie::Mash
      expect(hash).to eq({"some_hasi" => {"namf" => "Michael"}})
    end

    it "passes hashes through their own extension and return non-hash values properly" do
      subject.load_hash_extensions.add(:test) { |value|
        if value.is_a?(Hash)
          value.key?("name") ? value["name"] : value
        else
          value
        end
      }
      hash = subject.load('{"some_hash":{"name":"Michael"}}')
      expect(hash).to be_a Hashie::Mash
      expect(hash).to eq({"some_hash" => "Michael"})
    end
  end
end
