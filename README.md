# EbicsCredentials

EbicsCredentials is a tiny wrapper for keeping together ebics credentials.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ebics_credentials'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ebics_credentials

## Usage

### Feeding with a credentials hash
Take a credentials hash and initialize an `EbicsCredentials` instance with it. 
```ruby
credential_hash = {
  key:        "key",
  url:        "url",
  host_id:    "host_id",
  user_id:    "user_id",
  partner_id: "partner_id"
  passphrase: "passphrase",
}

credentials = EbicsCredentials.new(credential_hash)
```
At initialization, the completeness of the attributes will be validated. If they are invalid, `EbicsCredentials::Error::Invalid` will be raised. 


### Feeding with a base64 encoded json hash
To create an instance from a base64 encoded json string, use `.from_encoded_json`:
```ruby
credential_hash = {
  key:        "key",
  url:        "url",
  host_id:    "host_id",
  user_id:    "user_id",
  partner_id: "partner_id"
  passphrase: "passphrase",
}

encoded_json = Base64.decode64(credential_hash.to_json)

credentials = EbicsCredentials.from_encoded_json(encoded_json)
```
When the given argument is not valid json, `EbicsCredentials::Errors::Invalid` will be raised.

Attribute accessors are provided:
```ruby
credentials.key        # => "key"
credentials.host_id    # => "host_id"
credentials.partner_id # => "partner_id"
credentials.user_id    # => "user_id"
credentials.passphrase # => "passphrase"
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/romanlehnert/ebics_credentials.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

