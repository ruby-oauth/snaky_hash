# frozen_string_literal: true

require_relative "lib/snaky_hash/version"

Gem::Specification.new do |spec|
  spec.cert_chain = ["certs/pboling.pem"]
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $PROGRAM_NAME.end_with?("gem")

  spec.add_dependency "hashie"
  spec.add_dependency "version_gem", ["~> 1.1", ">= 1.1.1"]

  spec.name = "snaky_hash"
  spec.version = SnakyHash::Version::VERSION
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com", "oauth-ruby@googlegroups.com"]

  spec.summary = "A very snaky hash"
  spec.description = "A Hashie::Mash joint to make #snakelife better"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.2"

  spec.homepage = "https://gitlab.com/oauth-xx/snaky_hash"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/-/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/-/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/-/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/-/wiki"
  spec.metadata["mailing_list_uri"] = "https://groups.google.com/g/oauth-ruby"
  spec.metadata["funding_uri"] = "https://liberapay.com/pboling"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir[
    "lib/**/*",
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md",
  ]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", ">= 12"
  spec.add_development_dependency "rspec", ">= 3"
  spec.add_development_dependency "rspec-block_is_expected"
  spec.add_development_dependency "rubocop-lts", "~> 8.0"
end
