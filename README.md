# BIL

BIL encoding (from _Big Integer List_) is a mechanism for storing a list of non-negative integers of arbitrary size as a string of characters which are easy to say, to type on common keyboards, and hard to confuse.

`YGPjje` represents the integers 1977, 9 and 5 in that order:

```ruby
if Date.today == Date.new(*BIL.unpack('YGPjje'))
  Voyager.new(name: 1).launch!
end
```

Because BIL encoded integer lists can contain arbitrarily large integers, and will only ever contain the 32 characters in the [character table](#bil-character-table), they can be useful for storing certain kinds of data (eg. tree navigation routes, addresses) in URLs and databases.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bil'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bil

## BIL encoding

Each character in a BIL encoded string contains 5 bits of information. The lowest four bits contain a big-endian number from zero to fifteen, and the highest bit indicates whether there is a subsequent character to parse as part of the current integer (1, upper case) or not (0, lower case) — effectively a [varint](https://en.wikipedia.org/wiki/Variable-length_quantity).

A character sequence being unpacked on its own (eg. `Ta`) has the two characters' highest bits removed, and the remaining bits interpreted as a big-endian integer:


| T (4) | T (3) | T (2) | T (1) | T (0) | a (4) | a (3) | a (2) | a (1) | a (0) |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| 1     | 1     | 1     | 1     | 0     | 0     | 0     | 0     | 0     | 1     |
|       | 1     | 1     | 1     | 0     |       | 0     | 0     | 0     | 1     |

The extracted byte can then be turned into an integer 11100001 = 225.

As leading zeros are not required for integers, the character `Y` is not needed. Instead it is used to indicate the beginning of a new list of integers, allowing multiple lists to sit next to each other in the same string, eg. `YGuzzaYQzKhzaYkzza`, which shows three integer lists which can be read as IPv4 addresses (127.0.0.1, 192.168.0.1, 10.0.0.1).

The leading `Y` of any encoded string is also intended to indicate BIL encoding when interpreted as a [multibase](https://github.com/multiformats/multibase) string.

## BIL character table

The characters are chosen so that flipping the upper bit moves from lower case to upper case in all but the special `Y` case (see below). No confusing characters are included (i, L, M, N, O, S).

| Index | Character | Index | Character |
| ----- | --------- | ----- | --------- |
| 0     | z         | 16    | Y         |
| 1     | a         | 17    | A         |
| 2     | b         | 18    | B         |
| 3     | c         | 19    | C         |
| 4     | d         | 20    | D         |
| 5     | e         | 21    | E         |
| 6     | f         | 22    | F         |
| 7     | g         | 23    | G         |
| 8     | h         | 24    | H         |
| 9     | j         | 25    | J         |
| 10    | k         | 26    | K         |
| 11    | p         | 27    | P         |
| 12    | q         | 28    | Q         |
| 13    | r         | 29    | R         |
| 14    | t         | 30    | T         |
| 15    | u         | 31    | U         |

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jphastings/bil. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bil project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/bil/blob/master/CODE_OF_CONDUCT.md).
