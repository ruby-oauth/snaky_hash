# SnakyHash

This gem is used by the `oauth` and `oauth2` gems, and others, to normalize hash keys and lookups,
and provide a nice psuedo-object interface.

It has its roots in the `Rash`, which was a special `Mash`, made popular by the `hashie` gem.

`SnakyHash::Snake` does inherit from `Hashie::Mash` and adds some additional behaviors.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add snaky_hash

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install snaky_hash

## Usage

For now, please see specs

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pboling/snaky_hash. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pboling/snaky_hash/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SnakyHash project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pboling/snaky_hash/blob/main/CODE_OF_CONDUCT.md).
