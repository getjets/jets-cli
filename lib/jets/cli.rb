require "thor"

require "jets/cli/version"
require "jets/cli/exceptions"

require "shellwords"

module Jets
  module CLI
    class Error < StandardError; end
    
    class Main < Thor
      RESERVED_COMMANDS = %i[all generate gems engines].freeze

      def self.exit_on_failure?
        true
      end

      desc "help", "Jets CLI help"
      def help
        puts "Here's the help!"
      end
    end
  end
end
