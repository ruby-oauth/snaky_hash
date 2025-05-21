# Changelog
All notable changes to this project will be documented in this file.

The format (since v2) is based on [Keep a Changelog v1](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning v2](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
### Changed
### Fixed
### Removed

## [2.0.2] - 2025-05-21 ([tag][2.0.2t])
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

## [2.0.1] - 2022-09-23 ([tag][2.0.1t])
### Added
- Certificate for signing gem releases (@pboling)
- Gemspec metadata (@pboling)
    - funding_uri
    - mailing_list_uri
- Checksums for released gems (@pboling)
### Changed
- Gem releases are now cryptographically signed (@pboling)

## [2.0.0] - 2022-08-29 ([tag][2.0.0t])
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

## [1.0.1] - 2022-08-26 ([tag][1.0.1t])
### Added
- Missing LICENSE.txt file to release
### Removed
- Accidentally added bundler dependency (vestige of transpec process) is now removed

## [1.0.0] - 2022-08-26 ([tag][1.0.0t])
### Added
- Initial release

[Unreleased]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v2.0.2...main
[2.0.21]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v2.0.1...v2.0.2
[2.0.2t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v2.0.2
[2.0.1]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v2.0.0...v2.0.1
[2.0.1t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v2.0.1
[2.0.0]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v1.0.1...v2.0.0
[2.0.0t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v2.0.0
[1.0.1]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v1.0.0...v1.0.1
[1.0.1t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v1.0.1
[1.0.0]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v1.0.0
[1.0.0t]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v1.0.0
