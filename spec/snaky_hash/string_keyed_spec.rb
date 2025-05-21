# frozen_string_literal: true

RSpec.describe SnakyHash::StringKeyed do
  subject(:instance) do
    described_class.new(base_hash)
  end

  it_behaves_like "a snaked hash"

  it "can transform keys to string" do
    skip_for(
      engine: "ruby",
      versions: %w(2.2.10 2.3.8 2.4.10),
      reason: "transform_keys is not available in these versions of Ruby",
    )
    a = described_class.new(asd: "asd")
    b = a.transform_keys(&:to_s)
    expect(b.keys).to eq(["asd"])
    expect(b["asd"]).to eq("asd")
  end
end
