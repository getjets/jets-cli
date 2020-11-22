# frozen_string_literal: true

require "thor"

module Jets
  module CLI
    class Main < Thor
      RESERVED_COMMANDS = %i[all generate gems engines].freeze

      class_option :ignore_failures, type: :boolean, default: false

      def self.exit_on_failure?
        true
      end

      desc "NAME bundle [OPTIONS]", "Run `bundle` command for given engine"
      long_desc <<-LONGDESC
        `jets NAME bundle` will run `bundle` command for given engine.
      LONGDESC
      def bundle(*args)
        exec_command("bundle", *args)
      end

      %w[rake rubocop rspec].each do |command|
        desc "NAME #{command} [OPTIONS]", "Run `#{command}` command for given engine"
        define_method(command) do |*args|
          bundle(*(["exec", command] + args))
        end
      end

      desc "NAME rails [OPTIONS]", "Run `rails` command for given engine"
      def rails(*args)
        exec_command("./bin/rails", *args)
      end

      private

      def engine
        @engine ||= options[:engine] || ENV["ENGINE"]
      end

      def engines
        @engines ||= Dir["*", base: "engines"]
      end

      def gems
        @gems ||= Dir["*", base: "gems"]
      end

      def engine_root
        @engine_root ||= "#{options[:gem] ? "gems" : "engines"}/#{engine}"
      end

      def app_root
        # @app_root ||= File.expand_path("..", __dir__)
        @app_root ||= if defined?(Rails)
          Rails.root
        else
          Dir.pwd
        end
      end

      def exec_command(*args)
        if engine.nil? || engine.empty?
          @engine = args.each do |arg|
            next unless match = arg&.match(%r{^(engines|gems)/(?<name>[a-z_]+)}) # rubocop:disable Lint/AssignmentInCondition
            break match[:name]
          end

          if engine
            args.map! { |arg| arg ? arg.sub("#{engine_root}/", "") : arg }
          else
            raise "You did not provide an engine name."
          end
        end

        subshell(engine_root, *args)
      end

      def subshell(dir, command, *args)
        Bundler.with_original_env do
          new_root = File.join(app_root, dir)

          Dir.chdir(new_root) do
            return if Kernel.system(command, *args)
          end
        end

        message = "Command `#{command}` (from #{dir}) returned non-zero exit code"

        $stdout.puts message
        raise CommandFailedException, message unless options[:ignore_failures]
      end
    end
  end
end
