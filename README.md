# s3vs.rb

Pseudo-Synced Object backed by S3.

## Synopsis

```ruby
require "s3vs"

s3vs_obj = S3VS::Object.new(
  bucket: "mybucket", # or env `S3VS_BUCKET`
  key:    "path/to/mydata.json", # or env `S3VS_KEY`
  # auto_sync: true, # by default
  # s3_options: {}, # cf. http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Client.html#initialize-instance_method
)

my_obj = {
  string:  "ABC",
  integer: 123,
  float:   4.56,
  array:   [7, 8, 9],
  hash:    {mykey: "myvalue"}
}

s3vs_obj.set(my_obj)
```

and below from other process or machine...

```ruby
require "s3vs"

s3vs_obj = S3VS::Object.new(bucket: "mybucket", key: "path/to/mydata.json", auto_sync: false)

s3vs_obj.load.get #=> equal to my_obj
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 's3vs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install s3vs

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/s3vs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
