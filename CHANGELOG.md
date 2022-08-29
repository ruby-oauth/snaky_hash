# Changelog
All notable changes to this project will be documented in this file.

The format (since v2) is based on [Keep a Changelog v1](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning v2](https://semver.org/spec/v2.0.0.html).

## Unreleased
### Added
### Changed
### Fixed
### Removed

## [Unreleased]

## [2.0.0] - 2022-08-29
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
### Added
- Missing LICENSE.txt file to release
### Removed
- Accidentally added bundler dependency (vestige of transpec process) is now removed

## [1.0.0] - 2022-08-26
### Added
- Initial release

[Unreleased]: https://gitlab.com/oauth-xx/snaky_hash/-/compare/v1.0.1...main
[1.0.1]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v1.0.1
[1.0.0]: https://gitlab.com/oauth-xx/snaky_hash/-/releases/tag/v1.0.0
