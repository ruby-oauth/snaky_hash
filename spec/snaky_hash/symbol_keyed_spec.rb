# frozen_string_literal: true

RSpec.describe SnakyHash::SymbolKeyed do
  subject(:instance) do
    described_class.new(base_hash)
  end

  it_behaves_like "a snaked hash"

  it "can transform keys to symbol" do
    a = described_class.new("asd" => "asd")
    b = a.transform_keys(&:to_sym)
    expect(b.keys).to eq([:asd])
    expect(b[:asd]).to eq("asd")
  end
end
