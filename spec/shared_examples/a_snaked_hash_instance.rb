RSpec.shared_examples_for "a snaky hash instance" do
  it { is_expected.to be_a(Hashie::Mash) }

  it "creates a new rash where all the keys are underscored instead of camelcased" do
    expect(subject.var_one).to eq(1)
    expect(subject.two).to eq(2)
    expect(subject.three).to eq(3)
    expect(subject.var_four).to eq(4)
    expect(subject.five_hump_humps).to eq(5)
    expect(subject.nested).to be_a(subject.class)
    expect(subject.nested.nested_one).to eq("One")
    expect(subject.nested.two).to eq("two")
    expect(subject.nested.nested_three).to eq("three")
    expect(subject.nested_two).to be_a(subject.class)
    expect(subject.nested_two.nested_two).to eq(22)
    expect(subject.nested_two.nested_three).to eq(23)
    expect(subject.spaced_key).to eq("When would this happen?")
    expect(subject.trailing_spaces).to eq("better safe than sorry")
    expect(subject.extra_spaces).to eq("hopefully this never happens")
  end

  it "allows camelCased accessors" do
    # avoiding hashie v5- warnings
    subject.class.disable_warnings(:varOne) if defined?(Hashie::VERSION) && Gem::Version.new(Hashie::VERSION) >= Gem::Version.new("5.0.0")

    expect(subject.varOne).to eq(1)
    subject.varOne = "once"
    expect(subject.varOne).to eq("once")
    expect(subject.var_one).to eq("once")
  end

  it "allows camelCased accessors on nested hashes" do
    # avoiding hashie v5-  warnings
    subject.class.disable_warnings(:nestedOne) if defined?(Hashie::VERSION) && Gem::Version.new(Hashie::VERSION) >= Gem::Version.new("5.0.0")

    expect(subject.nested.nestedOne).to eq("One")
    subject.nested.nestedOne = "once"
    expect(subject.nested.nested_one).to eq("once")
  end

  it "merges well with a Mash" do
    merged = subject.merge Hashie::Mash.new(
      nested: {fourTimes: "a charm"},
      nested3: {helloWorld: "hi"},
      )

    expect(merged.nested.four_times).to eq("a charm")
    expect(merged.nested.fourTimes).to eq("a charm")
    expect(merged.nested3).to be_a(subject.class)
    expect(merged.nested3.hello_world).to eq("hi")
    expect(merged.nested3.helloWorld).to eq("hi")
    expect(merged[:nested3][:helloWorld]).to eq("hi")
  end

  it "updates well with a Mash" do
    subject.update Hashie::Mash.new(
      nested: {fourTimes: "a charm"},
      nested3: {helloWorld: "hi"},
      )

    expect(subject.nested.four_times).to eq("a charm")
    expect(subject.nested.fourTimes).to eq("a charm")
    expect(subject.nested3).to be_a(subject.class)
    expect(subject.nested3.hello_world).to eq("hi")
    expect(subject.nested3.helloWorld).to eq("hi")
    expect(subject[:nested3][:helloWorld]).to eq("hi")
  end

  it "merges well with a Hash" do
    merged = subject.merge(
      nested: {fourTimes: "work like a charm"},
      nested3: {helloWorld: "hi"},
      )

    expect(merged.nested.four_times).to eq("work like a charm")
    expect(merged.nested.fourTimes).to eq("work like a charm")
    expect(merged.nested3).to be_a(subject.class)
    expect(merged.nested3.hello_world).to eq("hi")
    expect(merged.nested3.helloWorld).to eq("hi")
    expect(merged[:nested3][:helloWorld]).to eq("hi")
  end

  it "handles assigning a new Hash and convert it to a rash" do
    subject.nested3 = {helloWorld: "hi"}

    expect(subject.nested3).to be_a(subject.class)
    expect(subject.nested3.hello_world).to eq("hi")
    expect(subject.nested3.helloWorld).to eq("hi")
    expect(subject[:nested3][:helloWorld]).to eq("hi")
  end

  it "converts an array of Hashes" do
    expect(subject.nested_three).to be_a(Array)
    expect(subject.nested_three[0]).to be_a(subject.class)
    expect(subject.nested_three[0].nested_four).to eq(4)
    expect(subject.nested_three[1]).to be_a(subject.class)
    expect(subject.nested_three[1].nested_four).to eq(4)
  end

  it "allows initializing reader" do
    subject.nested3!.helloWorld = "hi"
    expect(subject.nested3.hello_world).to eq("hi")
  end

  it "does not transform non-Symbolizable keys" do
    skip("Hashie v5 is the oldest version of hashie that works with non-symbolizable keys") unless defined?(Hashie::VERSION) && Gem::Version.new(Hashie::VERSION) >= Gem::Version.new("5.0.0")
    expect(subject[4]).to eq("not symbolizable")
    expect(subject[:"4"]).to be_nil
    expect(subject["4"]).to be_nil
    expect(subject.key?("4")).to be false
    expect(subject.key?(:"4")).to be false
    expect(subject.key?(4)).to be true
  end
end
