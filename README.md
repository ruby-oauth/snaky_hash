# 🐍 SnakyHash

[![Version][👽versioni]][👽version] [![License: MIT][📄license-img]][📄license-ref] [![Downloads Rank][👽dl-ranki]][👽dl-rank] [![Coveralls Test Coverage][🔑coveralls-img]][🔑coveralls] [![QLTY Test Coverage][🔑qlty-covi♻️]][🔑qlty-cov] [![QLTY Maintainability][🔑qlty-mnti♻️]][🔑qlty-mnt] [![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf] [![CI Runtime Dependencies @ HEAD][🚎12-crh-wfi]][🚎12-crh-wf] [![CI Current][🚎11-c-wfi]][🚎11-c-wf] [![CI Truffle Ruby][🚎9-t-wfi]][🚎9-t-wf] [![CI JRuby][🚎10-j-wfi]][🚎10-j-wf] [![CI Supported][🚎6-s-wfi]][🚎6-s-wf] [![CI Legacy][🚎4-lg-wfi]][🚎4-lg-wf] [![CI Unsupported][🚎7-us-wfi]][🚎7-us-wf] [![CI Ancient][🚎1-an-wfi]][🚎1-an-wf] [![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf] [![CI Style][🚎5-st-wfi]][🚎5-st-wf] [![CodeQL][🖐codeQL-img]][🖐codeQL]

---

[![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

This library is similar in purpose to the HashWithIndifferentAccess that is famously used in Rails, but does a lot more.

This gem is used by `oauth` and `oauth2` gems to normalize hash keys to `snake_case` and lookups,
and provide a nice psuedo-object interface.

It can be thought of as a mashup of:

* `Rash` (specifically the [`rash_alt`](https://github.com/shishi/rash_alt) flavor), which is a special `Mash`, made popular by the `hashie` gem, and
* `serialized_hashie` [gem by krystal](https://github.com/krystal/serialized-hashie), rewritten, with some behavior changes

Classes that `include SnakyHash::Snake.new` should inherit from `Hashie::Mash`.

## New for v2.0.2: Serialization Support

The serialization support is set to `false` by default, for backwards compatibility, but may be switched to `true` in the next major release, which will be v3. Example:

```ruby
# This class has `dump` and `load` abilities!
class MyStringKeyedHash < Hashie::Mash
  include SnakyHash::Snake.new(
    key_type: :string,
    serializer: true,
  )
end
```

✨ Also new dump & load plugin extensions to control the way your data is dumped and loaded.

### Note for use with oauth2 gem

The serializer is being introduced as a disabled option for backwards compatibility.
In snaky_hash v3 it will default to `true`.
If you want to start using the serializer immediately, reopen the `SnakyHash::StringKeyed` class and add the `SnakyHash::Serializer` module like this:

```ruby
SnakyHash::StringKeyed.class_eval do
  extend SnakyHash::Serializer
end
```

or you can create a custom class

```ruby
class MyHash < Hashie::Mash
  include SnakyHash::Snake.new(key_type: :string, serializer: true)
  # Which is the same as:
  # include SnakyHash::Snake.new(key_type: :string)
  # extend SnakyHash::Serializer
end
```

You can then add serialization extensions as needed.  See [serialization](#serialization) and [extensions](#extensions) for more.

| Federated [DVCS][💎d-in-dvcs] Repository      | Status                                                            | Issues                    | PRs                      | Wiki                      | CI                       | Discussions                  |
|-----------------------------------------------|-------------------------------------------------------------------|---------------------------|--------------------------|---------------------------|--------------------------|------------------------------|
| 🧪 [oauth-xx/snaky_hash on GitLab][📜src-gl]      | The Truth                                                         | [💚][🤝gl-issues]         | [💚][🤝gl-pulls]         | [💚][📜wiki]              | 🏀 Tiny Matrix           | ➖                            |
| 🧊 [oauth-xx/snaky_hash on CodeBerg][📜src-cb]    | An Ethical Mirror ([Donate][🤝cb-donate])                         | ➖                         | [💚][🤝cb-pulls]         | ➖                         | ⭕️ No Matrix             | ➖                            |
| 🐙 [oauth-xx/snaky_hash on GitHub][📜src-gh]      | A Dirty Mirror                                                    | [💚][🤝gh-issues]         | [💚][🤝gh-pulls]         | ➖                         | 💯 Full Matrix           | ➖                            |
| 🤼 [OAuth Ruby Google Group][⛳gg-discussions] | "Active"                                                          | ➖                         | ➖                        | ➖                         | ➖                        | [💚][⛳gg-discussions]        |
| 🎮️ [Discord Server][✉️discord-invite]        | [![Live Chat on Discord][✉️discord-invite-img]][✉️discord-invite] | [Let's][✉️discord-invite] | [talk][✉️discord-invite] | [about][✉️discord-invite] | [this][✉️discord-invite] | [library!][✉️discord-invite] |

## Upgrading Runtime Gem Dependencies

Due to oauth and oauth2 gems depending on this gem,
 this project sits underneath a large portion of the authorization systems on the internet.

That means it is painful for the Ruby community when this gem forces updates to its runtime dependencies.

As a result, great care, and a lot of time, have been invested to ensure this gem is working with all the
leading versions per each minor version of Ruby of all the runtime dependencies it can install with.

What does that mean specifically for the runtime dependencies?

We have 100% test coverage of lines and branches, and this test suite runs across a large matrix
covering the latest patch for each of the following minor versions:

* MRI Ruby @ v2.3, v2.4, v2.5, v2.6, v2.7, v3.0, v3.1, v3.2, v3.3, v3.4, HEAD
  * NOTE: This gem will still install on ruby v2.2, but vanilla GitHub Actions no longer supports testing against it, so YMMV.
* JRuby @ v9.2, v9.3, v9.4, v10.0, HEAD
* TruffleRuby @ v23.1, v23.2, HEAD
* gem `hashie` @ v0, v1, v2, v3, v4, v5, HEAD ⏩️ [hashie/hashie](https://github.com/hashie/hashie)
* gem `version_gem` - @v1, HEAD ⏩️ [oauth-xx/version_gem](https://gitlab.com/oauth-xx/version_gem)

NOTE: `version_gem`, and this library, were both extracted from the ouaht2 gem. They are part of the `oauth-xx` org,
and are developed in tight collaboration with the oauth and oauth2 gems.

### You should upgrade this gem with confidence\*.

- This gem follows a _strict & correct_ (according to the maintainer of SemVer; [more info][sv-pub-api]) interpretation of SemVer.
  - Dropping support for **any** of the runtime dependency versions above will be a major version bump.
  - If you aren't on one of the minor versions above, make getting there a priority.
- You should upgrade the dependencies of this gem with confidence\*.
- Please do upgrade, and then, when it goes smooth as butter [please sponsor me][🖇sponsor].  Thanks!

[sv-pub-api]: #-is-platform-support-part-of-the-public-api

\* MIT license; I am unable to make guarantees.

| 🚚 Test matrix brought to you by | 🔎 appraisal++                                                          |
|----------------------------------|-------------------------------------------------------------------------|
| Adds back support for old Rubies | ✨ [appraisal PR #250](https://github.com/thoughtbot/appraisal/pull/250) |
| Adds support for `eval_gemfile`  | ✨ [appraisal PR #248](https://github.com/thoughtbot/appraisal/pull/248) |
| Please review                    | my PRs!                                                                 |

## 💡 Info you can shake a stick at

| Tokens to Remember      | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace]                                                                                                                                                                                                                                                                                                                                                                          |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with JRuby        | [![JRuby 9.2 Compat][💎jruby-9.2i]][🚎10-j-wf] [![JRuby 9.3 Compat][💎jruby-9.3i]][🚎10-j-wf] [![JRuby 9.4 Compat][💎jruby-9.4i]][🚎10-j-wf] [![JRuby 10.0 Compat][💎jruby-c-i]][🚎11-c-wf] [![JRuby HEAD Compat][💎jruby-headi]][🚎3-hd-wf]                                                                                                                                                                                                                        |
| Works with Truffle Ruby | [![Truffle Ruby 23.1 Compat][💎truby-23.1i]][🚎9-t-wf] [![Truffle Ruby 24.1 Compat][💎truby-c-i]][🚎11-c-wf] [![Truffle Ruby HEAD Compat][💎truby-headi]][🚎3-hd-wf]                                                                                                                                                                                                                                                                                                |
| Works with MRI Ruby 3   | [![Ruby 3.0 Compat][💎ruby-3.0i]][🚎4-lg-wf] [![Ruby 3.1 Compat][💎ruby-3.1i]][🚎6-s-wf] [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎6-s-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎6-s-wf] [![Ruby 3.4 Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]                                                                                                                                                                                         |
| Works with MRI Ruby 2   | [![Ruby 2.3 Compat][💎ruby-2.3i]][🚎1-an-wf] [![Ruby 2.4 Compat][💎ruby-2.4i]][🚎1-an-wf] [![Ruby 2.5 Compat][💎ruby-2.5i]][🚎1-an-wf] [![Ruby 2.6 Compat][💎ruby-2.6i]][🚎7-us-wf] [![Ruby 2.7 Compat][💎ruby-2.7i]][🚎7-us-wf]                                                                                                                                                                                                                                    |
| Source                  | [![Source on GitLab.com][📜src-gl-img]][📜src-gl] [![Source on CodeBerg.org][📜src-cb-img]][📜src-cb] [![Source on Github.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc]                                                                                                                                                                                                                                                         |
| Documentation           | [![Discussion][⛳gg-discussions-img]][⛳gg-discussions] [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![YARD on Galtzo.com][📜docs-head-rd-img]][🚎yard-head] [![BDFL Blog][🚂bdfl-blog-img]][🚂bdfl-blog] [![Wiki][📜wiki-img]][📜wiki]                                                                                                                                                                                                    |
| Compliance              | [![License: MIT][📄license-img]][📄license-ref] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver]                                                                                                                                                                                                                    |
| Style                   | [![Enforced Code Style Linter][💎rlts-img]][💎rlts] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog] [![Gitmoji Commits][📌gitmoji-img]][📌gitmoji]                                                                                                                                                                                                                                                                                              |
| Support                 | [![Live Chat on Discord][✉️discord-invite-img]][✉️discord-invite] [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]                                                                                                                                                                                                                       |
| Enterprise Support      | [![Get help from me on Tidelift][🏙️entsup-tidelift-img]][🏙️entsup-tidelift]<br/>💡Subscribe for support guarantees covering _all_ FLOSS dependencies!<br/>💡Tidelift is part of [Sonar][🏙️entsup-tidelift-sonar]!<br/>💡Tidelift pays maintainers to maintain the software you depend on!<br/>📊`@`Pointy Haired Boss: An [enterprise support][🏙️entsup-tidelift] subscription is "[never gonna let you down][🧮kloc]", and *supports* open source maintainers! |
| Comrade BDFL 🎖️        | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact BDFL][🚂bdfl-contact-img]][🚂bdfl-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto]                                                                                                                                                              |
| `...` 💖                | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme] [🧊][💖🧊berg] [🐙][💖🐙hub]  [🛖][💖🛖hut] [🧪][💖🧪lab]                                                                                                                                                                   |

## ✨ Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add snaky_hash

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install snaky_hash

### 🔒 Secure Installation

`snaky_hash` is cryptographically signed, and has verifiable [SHA-256 and SHA-512][💎SHA_checksums] checksums by
[stone_checksums][💎stone_checksums]. Be sure the gem you install hasn’t been tampered with
by following the instructions below.

Add my public key (if you haven’t already, expires 2045-04-29) as a trusted certificate:

```shell
gem cert --add <(curl -Ls https://raw.github.com/oauth-xx/snaky_hash/main/certs/pboling.pem)
```

You only need to do that once.  Then proceed to install with:

```shell
gem install snaky_hash -P MediumSecurity
```

The `MediumSecurity` trust profile will verify signed gems, but allow the installation of unsigned dependencies.

This is necessary because not all of `snaky_hash`’s dependencies are signed, so we cannot use `HighSecurity`.

If you want to up your security game full-time:

```shell
bundle config set --global trust-policy MediumSecurity
```

NOTE: Be prepared to track down certs for signed gems and add them the same way you added mine.

## 🔧 Basic Usage

```ruby
class MySnakedHash < Hashie::Mash
  include SnakyHash::Snake.new(key_type: :string) # or :symbol
end

snake = MySnakedHash.new(:a => "a", "b" => "b", 2 => 2, "VeryFineHat" => "Feathers")
snake.a # => 'a'
snake.b # => 'b'
snake[2] # => 2
snake["2"] # => nil, note that this gem only affects string / symbol keys.
snake.very_fine_hat # => 'Feathers'
snake[:very_fine_hat] # => 'Feathers'
snake["very_fine_hat"] # => 'Feathers'
```

Note above that you can access the values via the string, or symbol.
The `key_type` determines how the key is actually stored, but the hash acts as "indifferent".
Note also that keys which do not respond to `to_sym`, because they don't have a natural conversion to a Symbol,
are left as-is.

### Serialization

```ruby
class MySerializedSnakedHash < Hashie::Mash
  include SnakyHash::Snake.new(
    key_type: :symbol, # default :string
    serializer: true,   # default: false
  )
end

snake = MySerializedSnakedHash.new(:a => "a", "b" => "b", 2 => 2, "VeryFineHat" => "Feathers") # => {a: "a", b: "b", 2 => 2, very_fine_hat: "Feathers"}
dump = MySerializedSnakedHash.dump(snake) # => "{\"a\":\"a\",\"b\":\"b\",\"2\":2,\"very_fine_hat\":\"Feathers\"}"
hydrated = MySerializedSnakedHash.load(dump) # => {a: "a", b: "b", "2": 2, very_fine_hat: "Feathers"}
hydrated.class # => MySerializedSnakedHash
hydrated.a # => 'a'
hydrated.b # => 'b'
hydrated[2] # => nil # NOTE: this is the opposite of snake[2] => 2
hydrated["2"] # => 2 # NOTE: this is the opposite of snake["2"] => nil
hydrated.very_fine_hat # => 'Feathers'
hydrated[:very_fine_hat] # => 'Feathers'
hydrated["very_fine_hat"] # => 'Feathers'
```

Note that the key `VeryFineHat` changed to `very_fine_hat`.
That is indeed the point of this library, so not a bug.

Note that the key `2` changed to `"2"` (because JSON keys are strings).
When the JSON dump was reloaded it did not know to restore it as `2` instead of `"2"`.
This is also not a bug, though if you need different behavior, there is a solution in the [next section](#extensions).

### Extensions

You can write your own arbitrary extensions:

* "Hash Load" extensions operate on the hash and nested hashes
  * use `::load_hash_extensions.add(:extension_name) { |hash| }`
  * since v2.0.2, bugs fixed in v2.0.3
* "Value Load" extensions operate on the values, and nested hashes' values, if any
  * use `::load_value_extensions.add(:extension_name) { |value| }`
  * since v2.0.2, bugs fixed in v2.0.3
* "Hash Dump" extensions operate on the hash and nested hashes
  * use `::dump_hash_extensions.add(:extension_name) { |value| }`
  * since v2.0.3
* "Value Dump" extensions operate on the values, and nested hashes' values, if any
  * use `::dump_value_extensions.add(:extension_name) { |value| }`
  * since v2.0.2, bugs fixed in v2.0.3

#### Example

Let's say I want to really smash up my hash and make it more food-like.

```ruby
class MyExtSnakedHash < Hashie::Mash
  include SnakyHash::Snake.new(
    key_type: :symbol, # default :string
    serializer: true,  # default: false
  )
end

# We could swap all values with indexed apples (obliteraating nested data!)
MyExtSnakedHash.dump_hash_extensions.add(:to_apple) do |value|
  num = 0
  value.transform_values do |_key|
    key = "apple-#{num}"
    num += 1
    key
  end
end

# And then when loading the dump we could convert the yum to pear
MyExtSnakedHash.load_hash_extensions.add(:apple_to_pear) do |value|
  value.transform_keys do |key|
    key.to_s.sub("yum", "pear")
  end
end

# We could swap all index numbers "beet-<number>"
MyExtSnakedHash.dump_value_extensions.add(:to_beet) do |value|
  value.to_s.sub(/(\d+)/) { |match| "beet-#{match[0]}" }
end

# And then when loading the dump we could convert beet to corn
MyExtSnakedHash.load_value_extensions.add(:beet_to_corn) do |value|
  value.to_s.sub("beet", "corn")
end

snake = MyExtSnakedHash.new({"YumBread" => "b", "YumCake" => {"b" => "b"}, "YumBoba" => [1, 2, 3]})
snake # => {yum_bread: "b", yum_cake: {b: "b"}, yum_boba: [1, 2, 3]}
snake.yum_bread # => "b"
snake.yum_cake # => {b: "b"}
snake.yum_boba # => [1, 2, 3]
dump = snake.dump
dump # => "{\"yum_bread\":\"apple-beet-0\",\"yum_cake\":\"apple-beet-1\",\"yum_boba\":\"apple-beet-2\"}"
hydrated = MyExtSnakedHash.load(dump)
hydrated # => {pear_bread: "apple-corn-0", pear_cake: "apple-corn-1", pear_boba: "apple-corn-2"}
```

See the specs for more examples.

### Bad Ideas

I don't recommend using these features... but they exist (for now).

<details>
  <summary>Show me what I should *not* do!</summary>

You can still access the original un-snaked camel keys.
And through them you can even use un-snaked camel methods.
But don't.

```ruby
snake = SnakyHash::StringKeyed["VeryFineHat" => "Feathers"]
snake.key?("VeryFineHat") # => true
snake["VeryFineHat"] # => 'Feathers'
snake.VeryFineHat # => 'Feathers', PLEASE don't do this!!!
snake["VeryFineHat"] = "pop" # Please don't do this... you'll get a warning, and it works (for now), but no guarantees.
# WARN -- : You are setting a key that conflicts with a built-in method MySnakedHash#VeryFineHat defined in MySnakedHash. This can cause unexpected behavior when accessing the key as a property. You can still access the key via the #[] method.
# => "pop"
```

Since you are reading this, here's what to do instead.

```ruby
snake.very_fine_hat = "pop" # => 'pop', do this instead!!!
snake.very_fine_hat # => 'pop'
snake[:very_fine_hat] = "moose" # => 'moose', or do this instead!!!
snake.very_fine_hat # => 'moose'
snake["very_fine_hat"] = "cheese" # => 'cheese', or do this instead!!!
snake.very_fine_hat # => 'cheese'
```

</details>

### 🚀 Release Instructions

See [CONTRIBUTING.md][🤝contributing].

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) check [issues][🤝gh-issues], or [PRs][🤝gh-pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### Code Coverage

[![Coveralls Test Coverage][🔑coveralls-img]][🔑coveralls]
[![QLTY Test Coverage][🔑qlty-covi♻️]][🔑qlty-cov]

### 🪇 Code of Conduct

Everyone interacting with this project's codebases, issue trackers,
chat rooms and mailing lists agrees to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/oauth-xx/snaky_hash/-/graphs/main][🚎contributors-gl]

## ⭐️ Star History

<a href="https://star-history.com/#oauth-xx/snaky_hash&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=oauth-xx/snaky_hash&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=oauth-xx/snaky_hash&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=oauth-xx/snaky_hash&type=Date" />
 </picture>
</a>

## 📌 Versioning

This Library adheres to [![Semantic Versioning 2.0.0][📌semver-img]][📌semver].
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.

### 📌 Is "Platform Support" part of the public API?

Yes.  But I'm obligated to include notes...

SemVer should, but doesn't explicitly, say that dropping support for specific Platforms
is a *breaking change* to an API.
It is obvious to many, but not all, and since the spec is silent, the bike shedding is endless.

> dropping support for a platform is both obviously and objectively a breaking change

- Jordan Harband (@ljharb, maintainer of SemVer) [in SemVer issue 716][📌semver-breaking]

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

As a result of this policy, and the interpretive lens used by the maintainer,
you can (and should) specify a dependency on these libraries using
the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("snaky_hash", "~> 2.0")
```

See [CHANGELOG.md][📌changelog] for list of releases.

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].
See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

### © Copyright

<ul>
    <li>
        2022, 2025 Peter H. Boling, of
        <a href="https://railsbling.com">
            RailsBling.com
            <picture>
                <img alt="Rails Bling" height="20" src="https://railsbling.com/images/logos/RailsBling-TrainLogo.svg" />
            </picture>
        </a>, and snaky_hash contributors
    </li>
</ul>

## 🤑 One more thing

You made it to the bottom of the page,
so perhaps you'll indulge me for another 20 seconds.
I maintain many dozens of gems, including this one,
because I want Ruby to be a great place for people to solve problems, big and small.
Please consider supporting my efforts via the giant yellow link below,
or one of the others at the head of this README.

[![Buy me a latte][🖇buyme-img]][🖇buyme]

[⛳gg-discussions]: https://groups.google.com/g/oauth-ruby
[⛳gg-discussions-img]: https://img.shields.io/badge/google-group-0093D0.svg?style=for-the-badge&logo=google&logoColor=orange

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/oauth-xx/snaky_hash
[⛳️namespace-img]: https://img.shields.io/badge/namespace-OAuth2-brightgreen.svg?style=flat&logo=ruby&logoColor=white
[⛳️gem-name]: https://rubygems.org/gems/snaky_hash
[⛳️name-img]: https://img.shields.io/badge/name-snaky_hash-brightgreen.svg?style=flat&logo=rubygems&logoColor=red
[🚂bdfl-blog]: http://www.railsbling.com/tags/snaky_hash
[🚂bdfl-blog-img]: https://img.shields.io/badge/blog-railsbling-0093D0.svg?style=for-the-badge&logo=rubyonrails&logoColor=orange
[🚂bdfl-contact]: http://www.railsbling.com/contact
[🚂bdfl-contact-img]: https://img.shields.io/badge/Contact-BDFL-0093D0.svg?style=flat&logo=rubyonrails&logoColor=red
[💖🖇linkedin]: http://www.linkedin.com/in/peterboling
[💖🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-LinkedIn-0B66C2?style=flat&logo=newjapanprowrestling
[💖✌️wellfound]: https://angel.co/u/peter-boling
[💖✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=flat&logo=wellfound
[💖💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💖💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=flat&logo=crunchbase
[💖🐘ruby-mast]: https://ruby.social/@galtzo
[💖🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=flat&logo=mastodon&label=Ruby%20%40galtzo
[💖🦋bluesky]: https://bsky.app/profile/galtzo.com
[💖🦋bluesky-img]: https://img.shields.io/badge/@galtzo.com-0285FF?style=flat&logo=bluesky&logoColor=white
[💖🌳linktree]: https://linktr.ee/galtzo
[💖🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=flat&logo=linktree
[💖💁🏼‍♂️devto]: https://dev.to/galtzo
[💖💁🏼‍♂️devto-img]: https://img.shields.io/badge/dev.to-0A0A0A?style=flat&logo=devdotto&logoColor=white
[💖💁🏼‍♂️aboutme]: https://about.me/peter.boling
[💖💁🏼‍♂️aboutme-img]: https://img.shields.io/badge/about.me-0A0A0A?style=flat&logo=aboutme&logoColor=white
[💖🧊berg]: https://codeberg.org/pboling
[💖🐙hub]: https://github.org/pboling
[💖🛖hut]: https://sr.ht/~galtzo/
[💖🧪lab]: https://gitlab.com/pboling
[👨🏼‍🏫expsup-upwork]: https://www.upwork.com/freelancers/~014942e9b056abdf86?mp_source=share
[👨🏼‍🏫expsup-upwork-img]: https://img.shields.io/badge/UpWork-13544E?style=for-the-badge&logo=Upwork&logoColor=white
[👨🏼‍🏫expsup-codementor]: https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github
[👨🏼‍🏫expsup-codementor-img]: https://img.shields.io/badge/CodeMentor-Get_Help-1abc9c?style=for-the-badge&logo=CodeMentor&logoColor=white
[🏙️entsup-tidelift]: https://tidelift.com/subscription
[🏙️entsup-tidelift-img]: https://img.shields.io/badge/Tidelift_and_Sonar-Enterprise_Support-FD3456?style=for-the-badge&logo=sonar&logoColor=white
[🏙️entsup-tidelift-sonar]: https://blog.tidelift.com/tidelift-joins-sonar
[💁🏼‍♂️peterboling]: http://www.peterboling.com
[🚂railsbling]: http://www.railsbling.com
[📜src-gl-img]: https://img.shields.io/badge/GitLab-FBA326?style=for-the-badge&logo=Gitlab&logoColor=orange
[📜src-gl]: https://gitlab.com/oauth-xx/snaky_hash/
[📜src-cb-img]: https://img.shields.io/badge/CodeBerg-4893CC?style=for-the-badge&logo=CodeBerg&logoColor=blue
[📜src-cb]: https://codeberg.org/oauth-xx/snaky_hash
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/oauth-xx/snaky_hash
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/YARD_on_Galtzo.com-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜wiki]: https://gitlab.com/oauth-xx/snaky_hash/-/wikis/home
[📜wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=Wiki&logoColor=white
[👽dl-rank]: https://rubygems.org/gems/snaky_hash
[👽dl-ranki]: https://img.shields.io/gem/rd/snaky_hash.svg
[👽version]: https://rubygems.org/gems/snaky_hash
[👽versioni]: https://img.shields.io/gem/v/snaky_hash.svg
[🔑qlty-mnt]: https://qlty.sh/gh/oauth-xx/projects/snaky_hash
[🔑qlty-mnti♻️]: https://qlty.sh/badges/84e960b2-4ed2-4b47-9913-02c32680ec98/maintainability.svg
[🔑qlty-cov]: https://qlty.sh/gh/oauth-xx/projects/snaky_hash
[🔑qlty-covi♻️]: https://qlty.sh/badges/84e960b2-4ed2-4b47-9913-02c32680ec98/test_coverage.svg
[🔑codecov]: https://codecov.io/gh/oauth-xx/snaky_hash
[🔑codecovi♻️]: https://codecov.io/gh/oauth-xx/snaky_hash/graph/badge.svg?token=XqaZixl4ss
[🔑coveralls]: https://coveralls.io/github/oauth-xx/snaky_hash?branch=main
[🔑coveralls-img]: https://coveralls.io/repos/github/oauth-xx/snaky_hash/badge.svg?branch=main
[🖐codeQL]: https://github.com/oauth-xx/snaky_hash/security/code-scanning
[🖐codeQL-img]: https://github.com/oauth-xx/snaky_hash/actions/workflows/codeql-analysis.yml/badge.svg
[🚎1-an-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/ancient.yml
[🚎1-an-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/ancient.yml/badge.svg
[🚎2-cov-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/coverage.yml
[🚎2-cov-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/coverage.yml/badge.svg
[🚎3-hd-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/heads.yml
[🚎3-hd-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/heads.yml/badge.svg
[🚎4-lg-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/legacy.yml
[🚎4-lg-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/legacy.yml/badge.svg
[🚎5-st-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/style.yml
[🚎5-st-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/style.yml/badge.svg
[🚎6-s-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/supported.yml
[🚎6-s-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/supported.yml/badge.svg
[🚎7-us-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/unsupported.yml
[🚎7-us-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/unsupported.yml/badge.svg
[🚎8-ho-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/hoary.yml
[🚎8-ho-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/hoary.yml/badge.svg
[🚎9-t-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/truffle.yml
[🚎9-t-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/truffle.yml/badge.svg
[🚎10-j-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/jruby.yml
[🚎10-j-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/jruby.yml/badge.svg
[🚎11-c-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/current.yml
[🚎11-c-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/current.yml/badge.svg
[🚎12-crh-wf]: https://github.com/oauth-xx/snaky_hash/actions/workflows/current-runtime-heads.yml
[🚎12-crh-wfi]: https://github.com/oauth-xx/snaky_hash/actions/workflows/current-runtime-heads.yml/badge.svg
[⛳liberapay-img]: https://img.shields.io/liberapay/goal/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://img.shields.io/badge/polar-donate-yellow.svg
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/a_more_different_coffee-✓-yellow.svg
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-yellow.svg
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-✓-yellow.svg?style=flat
[💎ruby-2.3i]: https://img.shields.io/badge/Ruby-2.3-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.4i]: https://img.shields.io/badge/Ruby-2.4-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.5i]: https://img.shields.io/badge/Ruby-2.5-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.6i]: https://img.shields.io/badge/Ruby-2.6-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.7i]: https://img.shields.io/badge/Ruby-2.7-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.0i]: https://img.shields.io/badge/Ruby-3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.1i]: https://img.shields.io/badge/Ruby-3.1-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[💎truby-22.3i]: https://img.shields.io/badge/Truffle_Ruby-22.3-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.0i]: https://img.shields.io/badge/Truffle_Ruby-23.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.1i]: https://img.shields.io/badge/Truffle_Ruby-23.1-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-c-i]: https://img.shields.io/badge/Truffle_Ruby-current-34BCB1?style=for-the-badge&logo=ruby&logoColor=green
[💎truby-headi]: https://img.shields.io/badge/Truffle_Ruby-HEAD-34BCB1?style=for-the-badge&logo=ruby&logoColor=blue
[💎jruby-9.1i]: https://img.shields.io/badge/JRuby-9.1-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.2i]: https://img.shields.io/badge/JRuby-9.2-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.3i]: https://img.shields.io/badge/JRuby-9.3-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.4i]: https://img.shields.io/badge/JRuby-9.4-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-c-i]: https://img.shields.io/badge/JRuby-current-FBE742?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-headi]: https://img.shields.io/badge/JRuby-HEAD-FBE742?style=for-the-badge&logo=ruby&logoColor=blue
[🤝gh-issues]: https://github.com/oauth-xx/snaky_hash/issues
[🤝gh-pulls]: https://github.com/oauth-xx/snaky_hash/pulls
[🤝gl-issues]: https://gitlab.com/oauth-xx/snaky_hash/-/issues
[🤝gl-pulls]: https://gitlab.com/oauth-xx/snaky_hash/-/merge_requests
[🤝cb-issues]: https://codeberg.org/oauth-xx/snaky_hash/issues
[🤝cb-pulls]: https://codeberg.org/oauth-xx/snaky_hash/pulls
[🤝cb-donate]: https://donate.codeberg.org/
[🤝contributing]: CONTRIBUTING.md
[🔑codecov-g♻️]: https://codecov.io/gh/oauth-xx/snaky_hash/graphs/tree.svg?token=XqaZixl4ss
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/oauth-xx/snaky_hash/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=oauth-xx/snaky_hash
[🚎contributors-gl]: https://gitlab.com/oauth-xx/snaky_hash/-/graphs/main
[🪇conduct]: CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-259D6C.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-259D6C.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-34495e.svg?style=flat
[📌gitmoji]:https://gitmoji.dev
[📌gitmoji-img]:https://img.shields.io/badge/gitmoji_commits-%20😜%20😍-34495e.svg?style=flat-square
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-0.132-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-259D6C.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-259D6C.svg
[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-259D6C.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/snaky_hash
[🚎yard-head]: https://snaky_hash.galtzo.com
[💎stone_checksums]: https://github.com/pboling/stone_checksums
[💎SHA_checksums]: https://gitlab.com/oauth-xx/snaky_hash/-/tree/main/checksums
[💎rlts]: https://github.com/rubocop-lts/rubocop-lts
[💎rlts-img]: https://img.shields.io/badge/code_style_%26_linting-rubocop--lts-34495e.svg?plastic&logo=ruby&logoColor=white
[💎d-in-dvcs]: https://railsbling.com/posts/dvcs/put_the_d_in_dvcs/
[✉️discord-invite]: https://discord.gg/3qme4XHNKN
[✉️discord-invite-img]: https://img.shields.io/discord/1373797679469170758?style=for-the-badge

<details>
  <summary>Deprecated Badges</summary>

CodeCov currently fails to parse the coverage upload.

[![CodeCov Test Coverage][🔑codecovi♻️]][🔑codecov]

[![Coverage Graph][🔑codecov-g♻️]][🔑codecov]

</details>
