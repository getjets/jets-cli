# frozen_string_literal: true

require "spec_helper"

RSpec.describe Jets::CLI do
  it "has a version number" do
    expect(Jets::CLI::VERSION).not_to be nil
  end

  describe "method missing" do
    subject(:cli) { described_class::Main.new }

    it "responds appropriately" do
      expect(cli).to respond_to(:all)
      expect(cli).to respond_to(:"all-gems")
      expect(cli).to respond_to(:"all-engines")
    end
  end
end
