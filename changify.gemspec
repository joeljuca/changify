# frozen_string_literal: true

require_relative "lib/changify/version"

Gem::Specification.new do |spec|
  spec.name = "changify"
  spec.version = Changify::VERSION
  spec.authors = ["Joel Jucá"]
  spec.email = ["joelwallis@gmail.com"]

  spec.summary = "Data patching CLI"
  spec.description = "Data patching CLI"
  spec.homepage = "https://github.com/joeljuca/changify"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/joeljuca/changify"
  spec.metadata["changelog_uri"] = "https://github.com/joeljuca/changify/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "thor", "~> 1.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
