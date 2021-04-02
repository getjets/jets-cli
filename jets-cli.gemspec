# frozen_string_literal: true

require_relative "lib/jets/cli/version"

rails_version = "~> 6.0"

Gem::Specification.new do |spec|
  spec.name = "jets-cli"
  spec.version = Jets::CLI::VERSION.dup
  spec.authors = ["Lauri Jutila"]

  spec.summary = "Jets CLI"
  spec.description = "Jets CLI for using Jets with your Rails application"
  spec.homepage = "https://github.com/getjets/jets-cli"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/getjets/jets-cli"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir = "bin"
  # spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.executables << "jets"
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", rails_version
  spec.add_dependency "thor", "~> 1.0"

  spec.add_development_dependency "aruba", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "pry", "~> 0.13"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.9"

  spec.add_development_dependency "jets-rubocop", "~> 0.1"
end
