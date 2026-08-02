# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]

### Added

- kettle-jem-template-20260720-005 - README Support & Community links now
  include RubyForum.
- kettle-jem-template-20260726-001 - Projects now include YARD lint
  configuration and documentation dependencies so documentation issues fail
  before generated docs are refreshed.
- kettle-jem-template-20260727-001 - Spec harness documentation now lists the
  RSpec helpers provided by `kettle-test`.

### Changed

- kettle-jem-template-20260716-002 - Generated gemspec manifests now ship fewer
  repository-only files by default to reduce downstream distro packaging churn.

- kettle-jem-template-20260720-002 - Development Gemfiles now use the released
  `tree_sitter_language_pack` gem 1.13.3 or newer by default.
- kettle-jem-template-20260725-002 - Version specs now use `anonymous_loader` to
  cover `version.rb` without redefining constants, or are removed when version
  specs are not managed for the project.
- kettle-jem-template-20260728-001 - Generated Ruby workflows now use clearer
  setup-ruby-flash planning and can prepare appraisal-only jobs without
  installing the main Gemfile bundle.

- kettle-jem-template-20260801-001 - Generated README gem dashboard links now
  use ClickGems instead of BestGems.

### Deprecated

### Removed

### Fixed

- kettle-jem-template-20260720-003 - StructuredMerge Git diff driver config now
  uses the installed `smorg-rb` driver command.
- kettle-jem-template-20260725-001 - Release pull request branches beginning
  with `feature/release` now run JRuby and TruffleRuby workflows.
- kettle-jem-template-20260726-002 - Generated version files now document their
  version namespace and constants, reducing warning-only YARD lint output.
- kettle-jem-template-20260726-003 - Coverage upload steps now treat Coveralls,
  QLTY, and Codecov as optional, so provider outages do not fail CI when local
  coverage thresholds still pass.
- kettle-jem-template-20260728-002 - Generated RuboCop configs now ignore the
  same `gemfiles/vendor/bundle` tree as `.gitignore`, so vendored dependency
  installs are not reported as project lint debt.
- kettle-jem-template-20260728-003 - Generated dep-heads workflows now run
  TruffleRuby jobs with current RubyGems and Bundler, avoiding setup failures
  before the test suite starts.
- kettle-jem-template-20260728-004 - Generated dep-heads workflows now use the
  setup-ruby Bundler install path for direct appraisal Gemfiles, avoiding rv
  lockfile parser failures on Git and path dependencies.
- kettle-jem-template-20260728-005 - VersionGem bootstrap now creates the
  missing canonical version spec when a project only has shim namespace version
  specs.
- kettle-jem-template-20260729-001 - Generated JRuby 9.4 workflows now use the
  legacy manual bundle install path, avoiding setup-time Bundler full-index
  failures against `gem.coop`.
- kettle-jem-template-20260730-001 - Gemspec package file enumeration now runs
  relative to the gemspec directory, so release package contents stay correct
  even when the gemspec is loaded from another working directory.

- kettle-jem-template-20260801-002 - Generated RSpec helpers now normalize
  managed configuration block bindings structurally, preventing mixed block
  parameter names from producing invalid configuration after a merge.
- kettle-jem-template-20260801-003 - Generated project metadata and
  documentation now normalize configured underscore hostnames to valid
  hyphenated hostnames.
- kettle-jem-template-20260801-004 - Generated organization README logos now
  use GitHub's stable organization avatar endpoint instead of assuming a
  matching Galtzo-hosted asset exists.
- kettle-jem-template-20260802-001 - Devcontainer JSON files now merge as JSONC,
  preserving comments and trailing commas during template updates.

### Security

## [2.0.7] - 2026-07-14

- TAG: [v2.0.7][2.0.7t]
- COVERAGE: 100.00% -- 133/133 lines in 7 files
- BRANCH COVERAGE: 100.00% -- 38/38 branches in 7 files
- 92.86% documented

### Added

- Added support for JRuby 10.1 and TruffleRuby 34.0.

### Changed

- Retemplated generated project metadata, support documentation, CI workflows,
  binstubs, and development dependency floors with `kettle-jem` v7.0.0.

### Fixed

- Corrected RubyGems homepage metadata to point at the gem documentation site.
- Corrected persisted Open Collective and repository topology metadata used by
  future template runs.

- Package configured license files in gem release file lists.

- Removed stale local-path `version_gem` state from the main lockfile.

## [2.0.6] - 2026-06-11

- TAG: [v2.0.6][2.0.6t]
- COVERAGE: 100.00% -- 133/133 lines in 7 files
- BRANCH COVERAGE: 100.00% -- 38/38 branches in 7 files
- 92.86% documented

### Fixed

- Restored `docs/CNAME` so the generated documentation site keeps its custom domain.
- Removed stale legacy CI workflows and duplicate extracted-stdlib gem
  declarations from generated Appraisal gemfiles.

## [2.0.5] - 2026-06-07

- TAG: [v2.0.5][2.0.5t]
- COVERAGE: 100.00% -- 133/133 lines in 7 files
- BRANCH COVERAGE: 100.00% -- 38/38 branches in 7 files
- 92.86% documented

### Changed

- Refreshed project scaffolding with the current `kettle-jem` template, including
  updated CI workflows, modular gemfiles, and development tooling floors.

## [2.0.4] - 2026-05-16

- TAG: [v2.0.4][2.0.4t]
- COVERAGE: 100.00% -- 133/133 lines in 7 files
- BRANCH COVERAGE: 100.00% -- 38/38 branches in 7 files
- 100.00% documented

### Added

- Incident Response Plan in IRP.md
- SnakyHash::VERSION (Traditional Constant Location)
- kettle-dev & kettle-test dev harnesses

### Changed

- Contributor Conenant updated to version 2.1

### Fixed

- Specs

## [2.0.3] - 2025-05-23

- TAG: [v2.0.3][2.0.3t]
-  COVERAGE: 100.00% -- 132/132 lines in 7 files
-  BRANCH COVERAGE: 100.00% -- 38/38 branches in 7 files
- 100.00% documented

### Added

- `#dump` instance method injected by `extend SnakyHash::Serializer` (@pboling)
- `dump_hash_extensions` - new feature, analogous to `load_hash_extensions` (@pboling)
- `dump_value_extensions` - alternate name for `dump_extensions` (@pboling)
- `load_value_extensions` - alternate name for `load_extensions` (@pboling)
- Clarifying documentation (@pboling)

### Fixed

- [gh4](https://github.com/oauth-xx/snaky_hash/pull/4) - Serializer extensions dump and load empty values properly (@pboling)
  - Fixed `dump_extensions`, `load_extensions`, `load_hash_extensions`
  - Intended usage is primarily JSON, and oauth2 gem
  - OAuth2 spec can have legitimately empty values (e.g. scopes could be empty)
  - Previous logic was inherited from design decisions made by `serialized_hashie` gem; doesn't apply here

## [2.0.2] - 2025-05-21

- TAG: [v2.0.2][2.0.2t]
- COVERAGE: 100.00% -- 119/119 lines in 7 files
- BRANCH COVERAGE: 100.00% -- 35/35 branches in 7 files
- 100.00% documented

### Added

- Gem is signed by 20-year cert (@pboling)
  - Expires 2045-04-29
- Gemspec metadata updates (@pboling)
- Documentation updates (@pboling)
- CI covering all code, and all key versions of runtime dependencies (@pboling)
  - Including Hashie v0, v1, v2, v3, v4, v5, and HEAD
- [gh2](https://github.com/oauth-xx/snaky_hash/pull/2) - Serializer option (@pboling)
- [gh3](https://github.com/oauth-xx/snaky_hash/pull/3) - Serializer Extensions (@pboling)
- Documentation site at [snaky-hash.galtzo.com](https://snaky-hash.galtzo.com) (@pboling)
- 100% documented! (@pboling)

## [2.0.1] - 2022-09-23

- TAG: [v2.0.1][2.0.1t]

### Added

- Certificate for signing gem releases (@pboling)
- Gemspec metadata (@pboling)
    - funding_uri
    - mailing_list_uri
- Checksums for released gems (@pboling)

### Changed

- Gem releases are now cryptographically signed (@pboling)

## [2.0.0] - 2022-08-29

- TAG: [v2.0.0][2.0.0t]

### Changed

- **BREAKING**: `SnakeHash::Snake` is now a mixin, now with support for symbol or string keys
```ruby
class MySnakedHash < Hashie::Mash
  include SnakyHash::Snake.new(key_type: :string) # or :symbol
end
```

### Added

- `SnakyHash::StringKeyed`: a Hashie::Mash class with snake-cased String keys
- `SnakyHash::SymbolKeyed`: a Hashie::Mash class with snake-cased Symbol keys

## [1.0.1] - 2022-08-26

- TAG: [v1.0.1][1.0.1t]

### Added

- Missing LICENSE.txt file to release

### Removed

- Accidentally added bundler dependency (vestige of transpec process) is now removed

## [1.0.0] - 2022-08-26

- TAG: [v1.0.0][1.0.0t]

### Added

- Initial release

[Unreleased]: https://github.com/ruby-oauth/snaky_hash/compare/v2.0.7...HEAD
[2.0.7]: https://github.com/ruby-oauth/snaky_hash/compare/v2.0.6...v2.0.7
[2.0.7t]: https://github.com/ruby-oauth/snaky_hash/releases/tag/v2.0.7
[2.0.6]: https://github.com/ruby-oauth/snaky_hash/compare/v2.0.5...v2.0.6
[2.0.6t]: https://github.com/ruby-oauth/snaky_hash/releases/tag/v2.0.6
[2.0.5]: https://github.com/ruby-oauth/snaky_hash/compare/v2.0.4...v2.0.5
[2.0.5t]: https://github.com/ruby-oauth/snaky_hash/releases/tag/v2.0.5
[2.0.4]: https://github.com/ruby-oauth/snaky_hash/compare/v2.0.3...v2.0.4
[2.0.4t]: https://github.com/ruby-oauth/snaky_hash/releases/tag/v2.0.4
[2.0.3]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v2.0.2...v2.0.3
[2.0.3t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v2.0.3
[2.0.2]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v2.0.1...v2.0.2
[2.0.2t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v2.0.2
[2.0.1]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v2.0.0...v2.0.1
[2.0.1t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v2.0.1
[2.0.0]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v1.0.1...v2.0.0
[2.0.0t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v2.0.0
[1.0.1]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v1.0.0...v1.0.1
[1.0.1t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v1.0.1
[1.0.0]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v1.0.0
[1.0.0t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v1.0.0
