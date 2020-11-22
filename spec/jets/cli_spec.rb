require "spec_helper"

RSpec.describe Jets::CLI do
  it "has a version number" do
    expect(Jets::CLI::VERSION).not_to be nil
  end
end
