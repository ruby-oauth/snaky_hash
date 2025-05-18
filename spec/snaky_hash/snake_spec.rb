# frozen_string_literal: true

RSpec.describe SnakyHash::Snake do
  class TheSnakedHash < Hashie::Mash
    include SnakyHash::Snake.new(key_type: :string)
  end

  subject do
    TheSnakedHash.new(base_hash)
  end

  it_behaves_like "a snaked hash"

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
end
