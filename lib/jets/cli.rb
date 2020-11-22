# frozen_string_literal: true

require "jets/cli/main"
require "jets/cli/version"
require "jets/cli/exceptions"

require "shellwords"

module Jets
  module CLI
    class Error < StandardError; end
  end
end
