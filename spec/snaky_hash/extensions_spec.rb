# frozen_string_literal: true

RSpec.describe SnakyHash::Extensions do
  subject(:extensions) { described_class.new }

  describe "#add" do
    it "adds a new extension" do
      extensions.add(:test) { 1 }
      added = extensions.instance_variable_get(:@extensions)
      expect(added[:test]).to be_a Proc
      expect(added[:test].call).to eq 1
    end

    it "raises an error if an extension with a given name is already defined" do
      extensions.add(:test) { 1 }
      expect do
        extensions.add(:test) { 2 }
      end.to raise_error SnakyHash::Error, /already defined/
    end
  end

  describe "#run" do
    it "runs through all extensions" do
      extensions.add(:upcase) { |v| v.upcase }
      extensions.add(:exclaim) { |v| v.to_s + "!!!" }
      expect(extensions.run("hello")).to eq "HELLO!!!"
    end
  end

  describe "#has?" do
    it "returns true if the extension has been added" do
      extensions.add(:upcase) { |v| v.upcase }
      expect(extensions.has?(:upcase)).to be true
    end

    it "returns false if no extension exists" do
      expect(extensions.has?(:upcase)).to be false
    end
  end
end
