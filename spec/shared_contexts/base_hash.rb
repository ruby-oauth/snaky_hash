# frozen_string_literal: true

RSpec.shared_context "base hash" do
  let(:base_hash) do
    {
      "varOne" => 1,
      "two" => 2,
      :three => 3,
      :varFour => 4,
      "fiveHumpHumps" => 5,
      :nested => {
        "NestedOne" => "One",
        :two => "two",
        "nested_three" => "three",
      },
      "nestedTwo" => {
        "nested_two" => 22,
        :nestedThree => 23,
      },
      :nestedThree => [
        {nestedFour: 4},
        {"nestedFour" => 4},
      ],
      "spaced Key" => "When would this happen?",
      "trailing spaces " => "better safe than sorry",
      "extra   spaces" => "hopefully this never happens",
      4 => "not symbolizable",
    }
  end
end
