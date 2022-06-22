module MatcherHelpers
  def expect_response_collection_to_have_keys(keys)
    expect(response_json.first.keys).to match_array keys
  end

  def expect_response_to_have_keys(keys)
    expect(response_json.keys).to match_array keys
  end
end

RSpec::Matchers.define :an_object_containing do |args|
  args.each do |key, value|
    match { |actual| actual.send(key).eql? value }
  end
end
